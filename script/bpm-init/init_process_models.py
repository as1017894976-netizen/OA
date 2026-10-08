"""给开源版自带的 OA、人事单据创建并发布审批流程模型。

单据提交时按固定的流程 key 发起流程（见 OaBillTypeEnum、HrmBillTypeEnum），
模型不存在时提交会报「流程定义不存在」。本脚本通过后台接口创建这些模型，可重复执行：
已存在的 key 会跳过，加 --redeploy 则按本脚本的定义更新并重新发布。

默认流程：发起人 → 发起人的部门负责人审批 → 结束。
  - 部门没有负责人时，转交给流程管理员（--manager-user-ids，默认 admin）审批；
  - 发起人本身就是部门负责人时，自动跳过该节点；
  - 审批不通过时退回发起人，修改后可重新提交。
需要会签、多级审批时，发布后在「工作流程 → 流程模型」里用设计器调整即可。

用法：
  python3 script/bpm-init/init_process_models.py \\
      --base-url http://127.0.0.1:48080 --username admin --password admin123 [--tenant-id 1] [--redeploy]
"""
import argparse
import json
import sys
import urllib.error
import urllib.request

# (流程 key, 名称, 分类编码, 新建页路由, 详情页组件路径)
# 新建页路由与 90_menu_fixup.sql 中隐藏的「详情」菜单一致；详情页组件路径供审批详情页加载业务表单
PROCESSES = [
    ('oa_car_apply_bill', '用车申请', 'oa', '/oa/car/car-apply-info', '/oa/car/carapply/info/index'),
    ('oa_car_return_bill', '还车申请', 'oa', '/oa/car/car-return-info', '/oa/car/carreturn/info/index'),
    ('oa_seal_apply_bill', '用印申请', 'oa', '/oa/seal/seal-apply-info', '/oa/seal/sealapply/info/index'),
    ('oa_meeting_room_booking', '会议室预定', 'oa', '/oa/meetingroom/booking-info',
     '/oa/meetingroom/booking/info/index'),
    ('hr_employee_entry_bill', '员工入职', 'hrm', '/hrm/employee-relation/entry-info',
     '/hrm/employee-relation/entry/info/index'),
    ('hr_employee_regular_bill', '员工转正', 'hrm', '/hrm/employee-relation/regular-info',
     '/hrm/employee-relation/regular/info/index'),
    ('hr_employee_transfer_bill', '人事调动', 'hrm', '/hrm/employee-relation/transfer-info',
     '/hrm/employee-relation/transfer/info/index'),
    ('hr_employee_resignation_bill', '员工离职', 'hrm', '/hrm/employee-relation/resignation-info',
     '/hrm/employee-relation/resignation/info/index'),
]
CATEGORIES = [('oa', '协同办公', 1), ('hrm', '人事管理', 2)]

# 枚举值见 yudao-module-bpm-api 中的 BpmSimpleModelNodeTypeEnum、BpmTaskCandidateStrategyEnum 等
NODE_START_USER, NODE_APPROVE, NODE_END = 10, 11, 1
STRATEGY_START_USER_DEPT_LEADER = 37
APPROVE_TYPE_USER, APPROVE_METHOD_RANDOM = 1, 1
REJECT_RETURN_USER_TASK = 2
ASSIGN_EMPTY_TO_ADMIN = 4
ASSIGN_START_USER_SKIP = 2
MODEL_TYPE_SIMPLE, FORM_TYPE_CUSTOM = 20, 20


def simple_model():
    return {
        'id': 'StartUserNode', 'type': NODE_START_USER, 'name': '发起人', 'showText': '发起人',
        'childNode': {
            'id': 'Activity_dept_leader', 'type': NODE_APPROVE, 'name': '部门负责人审批',
            'showText': '发起人的部门负责人',
            'candidateStrategy': STRATEGY_START_USER_DEPT_LEADER, 'candidateParam': '1',
            'approveType': APPROVE_TYPE_USER, 'approveMethod': APPROVE_METHOD_RANDOM,
            'rejectHandler': {'type': REJECT_RETURN_USER_TASK, 'returnNodeId': 'StartUserNode'},
            'assignEmptyHandler': {'type': ASSIGN_EMPTY_TO_ADMIN},
            'assignStartUserHandlerType': ASSIGN_START_USER_SKIP,
            'timeoutHandler': {'enable': False, 'type': 1, 'timeDuration': 'PT6H'},
            'childNode': {'id': 'EndEvent', 'type': NODE_END, 'name': '结束'},
        },
    }


class Client:
    def __init__(self, base_url, tenant_id):
        self.base = base_url.rstrip('/') + '/admin-api'
        self.tenant_id = str(tenant_id)
        self.token = None

    def call(self, method, path, body=None):
        headers = {'tenant-id': self.tenant_id, 'Content-Type': 'application/json'}
        if self.token:
            headers['Authorization'] = 'Bearer ' + self.token
        data = json.dumps(body).encode() if body is not None else None
        req = urllib.request.Request(self.base + path, data=data, method=method, headers=headers)
        try:
            with urllib.request.urlopen(req, timeout=60) as resp:
                result = json.loads(resp.read())
        except urllib.error.HTTPError as e:
            raise SystemExit(f'{method} {path} 失败: HTTP {e.code} {e.read()[:300]!r}')
        if result.get('code') != 0:
            raise SystemExit(f'{method} {path} 失败: {result.get("msg")}')
        return result.get('data')


def main():
    ap = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    ap.add_argument('--base-url', default='http://127.0.0.1:48080')
    ap.add_argument('--username', default='admin')
    ap.add_argument('--password', default='admin123')
    ap.add_argument('--tenant-id', default='1')
    ap.add_argument('--manager-user-ids', default='1', help='流程管理员用户编号，逗号分隔')
    ap.add_argument('--redeploy', action='store_true', help='已存在的模型也按本脚本更新并重新发布')
    a = ap.parse_args()
    managers = [int(x) for x in a.manager_user_ids.split(',') if x]

    c = Client(a.base_url, a.tenant_id)
    c.token = c.call('POST', '/system/auth/login', {'username': a.username, 'password': a.password})['accessToken']

    existing_categories = {x['code'] for x in c.call('GET', '/bpm/category/page?pageNo=1&pageSize=100')['list']}
    for code, name, sort in CATEGORIES:
        if code not in existing_categories:
            c.call('POST', '/bpm/category/create', {'code': code, 'name': name, 'sort': sort, 'status': 0})
            print(f'创建流程分类 {name}（{code}）')

    models = {m['key']: m for m in c.call('GET', '/bpm/model/list')}
    for key, name, category, create_path, view_path in PROCESSES:
        model = models.get(key)
        if model and not a.redeploy:
            print(f'跳过 {name}（{key}）：模型已存在')
            continue
        body = {
            'key': key, 'name': name, 'category': category, 'type': MODEL_TYPE_SIMPLE,
            'formType': FORM_TYPE_CUSTOM, 'formCustomCreatePath': create_path, 'formCustomViewPath': view_path,
            'visible': True, 'managerUserIds': managers, 'startUserIds': [], 'startDeptIds': [],
            'allowCancelRunningProcess': True, 'allowWithdrawTask': True, 'simpleModel': simple_model(),
        }
        if model:
            body['id'] = model['id']
            c.call('PUT', '/bpm/model/update', body)
            model_id = model['id']
        else:
            model_id = c.call('POST', '/bpm/model/create', body)
        c.call('POST', f'/bpm/model/deploy?id={model_id}')
        print(f'{"更新" if model else "创建"}并发布 {name}（{key}）')


if __name__ == '__main__':
    sys.exit(main())
