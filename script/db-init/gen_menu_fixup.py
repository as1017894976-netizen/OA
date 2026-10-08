"""生成 sql/mysql/oa-init/90_menu_fixup.sql：按前端 OA-vben 实际的页面路径重建「OA协同办公」「人力资源管理」菜单。

各模块自带的菜单脚本存在：用车菜单缺失、员工档案挂在 parent_id=2000（商城商品）下、
会议室/印章/入职等详情页路径与前端 router.push 的路径对不上等问题，这里统一删掉重建。
菜单 id 固定使用 6000~6299，便于后续增量脚本引用。

同时把「OA协同办公」授权给普通角色（common）：员工要能发起用车、用印、会议室单据，
审批人也要能在待办里打开单据详情（详情接口要求 query 权限）。台账只授权查询（选车、选印章、选会议室用）。
"""

# (id, 名称, 类型 1目录/2菜单/3按钮, 排序, 父id, 路由, 图标, 组件, 组件名, 是否显示)
MENUS = []
BUTTON_NAMES = {'query': '查询', 'create': '新增', 'save': '保存', 'update': '修改', 'delete': '删除',
                'export': '导出', 'submit': '提交审批', 'withdraw': '撤回', 'upload': '上传',
                'favorite': '收藏', 'share': '分享', 'approve': '审批通过', 'reject': '驳回', 'cancel': '取消'}


def menu(mid, name, mtype, sort, parent, path, icon='', component=None, component_name=None, visible=True, perm=''):
    MENUS.append((mid, name, perm, mtype, sort, parent, path, icon, component, component_name, visible))


def buttons(start, parent, prefix, actions, label):
    for i, act in enumerate(actions):
        menu(start + i, f'{BUTTON_NAMES[act]}{label}', 3, i + 1, parent, '', perm=f'{prefix}:{act}')


CRUD = ['query', 'create', 'update', 'delete', 'export']

# ---------------- OA 协同办公 ----------------
OA = 6000
menu(OA, 'OA协同办公', 1, 20, 0, '/oa', 'ep:briefcase')

menu(6010, '用车管理', 1, 10, OA, 'car', 'ep:van')
menu(6011, '车辆台账', 2, 1, 6010, 'car-info', 'ep:list', 'oa/car/carinfo/index', 'OaCarInfo')
buttons(6100, 6011, 'oa:car', CRUD, '车辆')
menu(6012, '用车申请', 2, 2, 6010, 'car-apply', 'ep:document-add', 'oa/car/carapply/list/index', 'OaCarApplyBillList')
buttons(6110, 6012, 'oa:car-apply-bill', CRUD + ['save', 'submit'], '用车申请')
menu(6013, '用车申请详情', 2, 3, 6010, 'car-apply-info', '', 'oa/car/carapply/info/index', 'OaCarApplyBillInfo', visible=False,
     perm='oa:car-apply-bill:query')
menu(6014, '还车申请', 2, 4, 6010, 'car-return', 'ep:document-checked', 'oa/car/carreturn/list/index', 'OaCarReturnBillList')
buttons(6120, 6014, 'oa:car-return-bill', CRUD + ['save', 'submit'], '还车申请')
menu(6015, '还车申请详情', 2, 5, 6010, 'car-return-info', '', 'oa/car/carreturn/info/index', 'OaCarReturnBillInfo', visible=False,
     perm='oa:car-return-bill:query')

menu(6020, '印章管理', 1, 20, OA, 'seal', 'ep:stamp')
menu(6021, '印章台账', 2, 1, 6020, 'seal-info', 'ep:list', 'oa/seal/sealinfo/index', 'OaSealInfo')
buttons(6130, 6021, 'oa:seal', CRUD, '印章')
menu(6022, '用印申请', 2, 2, 6020, 'seal-apply', 'ep:document-checked', 'oa/seal/sealapply/list/index', 'OaSealApplyBillList')
buttons(6140, 6022, 'oa:seal-apply-bill', CRUD + ['submit', 'withdraw'], '用印申请')
menu(6023, '用印申请详情', 2, 3, 6020, 'seal-apply-info', '', 'oa/seal/sealapply/info/index', 'OaSealApplyBillInfo', visible=False,
     perm='oa:seal-apply-bill:query')

menu(6030, '会议室管理', 1, 30, OA, 'meetingroom', 'ep:office-building')
menu(6031, '会议室台账', 2, 1, 6030, 'room-info', 'ep:list', 'oa/meetingroom/roominfo/index', 'OaMeetingRoom')
buttons(6150, 6031, 'oa:meeting-room', CRUD, '会议室')
menu(6032, '会议室预定', 2, 2, 6030, 'booking', 'ep:calendar', 'oa/meetingroom/booking/list/index', 'OaMeetingRoomBookingList')
buttons(6160, 6032, 'oa:meeting-room-booking', CRUD + ['submit', 'approve', 'reject', 'cancel'], '预定')
menu(6033, '会议室预定详情', 2, 3, 6030, 'booking-info', '', 'oa/meetingroom/booking/info/index', 'OaMeetingRoomBookingInfo',
     visible=False, perm='oa:meeting-room-booking:query')

menu(6040, '企业云盘', 2, 40, OA, 'file', 'ep:folder', 'oa/file/index', 'OaFileManagement')
buttons(6170, 6040, 'oa:file', ['query', 'create', 'upload', 'update', 'delete', 'export', 'favorite', 'share'], '文件')

# ---------------- 人力资源管理 ----------------
HRM = 6200
menu(HRM, '人力资源管理', 1, 30, 0, '/hrm', 'ep:user')

menu(6210, '员工档案', 1, 10, HRM, 'employee', 'ant-design:solution-outlined')
menu(6211, '员工档案列表', 2, 1, 6210, 'employee-archive', 'ep:list', 'hrm/employee/list/index', 'HrmEmployeeArchiveList')
buttons(6230, 6211, 'hrm:employee-archive', CRUD, '员工档案')
menu(6212, '员工档案详情', 2, 2, 6210, 'employee-archive-info', '', 'hrm/employee/info/index', 'HrmEmployeeArchiveInfo',
     visible=False, perm='hrm:employee-archive:query')

menu(6220, '员工关系', 1, 20, HRM, 'employee-relation', 'ep:connection')
REL = [  # (列表id, 名称, 路由前缀, 前端目录, 组件名前缀, 权限前缀, 按钮起始id)
    (6221, '入职管理', 'entry', 'entry', 'HrmEmployeeEntryBill', 'hrm:employee-entry-bill', 6240),
    (6223, '员工转正', 'regular', 'regular', 'HrmEmployeeRegularBill', 'hrm:employee-regular-bill', 6250),
    (6225, '人事调动', 'transfer', 'transfer', 'HrmEmployeeTransferBill', 'hrm:employee-transfer-bill', 6260),
    (6227, '员工离职', 'resignation', 'resignation', 'HrmEmployeeResignationBill', 'hrm:employee-resignation-bill', 6270),
]
for i, (mid, name, route, folder, comp, perm, btn) in enumerate(REL):
    menu(mid, name, 2, i * 2 + 1, 6220, f'{route}-list', 'ep:document',
         f'hrm/employee-relation/{folder}/list/index', f'{comp}List')
    buttons(btn, mid, perm, CRUD + ['submit', 'withdraw'], name.replace('管理', '') + '申请')
    menu(mid + 1, f'{name}详情', 2, i * 2 + 2, 6220, f'{route}-info', '',
         f'hrm/employee-relation/{folder}/info/index', f'{comp}Info', visible=False, perm=f'{perm}:query')


COMMON_ROLE_ID, COMMON_ROLE_TENANT_ID = 2, 1
LEDGER_MENUS = {6011, 6021, 6031}  # 台账：普通角色只给查询


def common_role_menu_ids():
    parent = {m[0]: m[5] for m in MENUS}

    def under_oa(mid):
        while mid:
            if mid == OA:
                return True
            mid = parent.get(mid)
        return False

    return [m[0] for m in MENUS if under_oa(m[0])
            and not (m[5] in LEDGER_MENUS and m[3] == 3 and not m[2].endswith(':query'))]


def q(v):
    if v is None:
        return 'NULL'
    if isinstance(v, bool):
        return "b'1'" if v else "b'0'"
    if isinstance(v, int):
        return str(v)
    return "'" + v.replace("'", "''") + "'"


def main():
    out = ['-- 由 script/db-init/gen_menu_fixup.py 生成，请勿手工修改。', __doc__.strip().replace('\n', '\n-- ').join(['-- ', '']), '', 'SET NAMES utf8mb4;', '']
    out.append('-- 1. 删除各模块脚本插入的 OA、人力菜单（含挂错位置的「员工档案管理」）')
    out.append('DROP TABLE IF EXISTS tmp_menu_ids; CREATE TABLE tmp_menu_ids (id BIGINT PRIMARY KEY);')
    out.append("INSERT INTO tmp_menu_ids SELECT id FROM system_menu WHERE parent_id = 0 AND name IN ('OA协同办公', '人力资源管理');")
    out.append("INSERT IGNORE INTO tmp_menu_ids SELECT id FROM system_menu WHERE name = '员工档案管理';")
    for _ in range(4):  # 菜单最多 4 层，逐层把子菜单加进来
        out.append('INSERT IGNORE INTO tmp_menu_ids SELECT m.id FROM system_menu m JOIN (SELECT id FROM tmp_menu_ids) p ON m.parent_id = p.id;')
    out.append('DELETE FROM system_role_menu WHERE menu_id IN (SELECT id FROM tmp_menu_ids);')
    out.append('DELETE FROM system_menu WHERE id IN (SELECT id FROM tmp_menu_ids);')
    out.append('DROP TABLE tmp_menu_ids;')
    out.append('')
    out.append('-- 2. 按前端页面重建')
    out.append('INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, '
               "status, visible, keep_alive, always_show, creator, updater) VALUES")
    rows = [f"({', '.join(q(v) for v in m[:10])}, 0, {q(m[10])}, b'1', b'1', '1', '1')" for m in MENUS]
    out.append(',\n'.join(rows) + ';')
    out.append('')
    out.append('-- 3. 普通角色（common）授权 OA协同办公')
    out.append('INSERT INTO system_role_menu (role_id, menu_id, creator, updater, tenant_id) VALUES')
    out.append(',\n'.join(f"({COMMON_ROLE_ID}, {mid}, '1', '1', {COMMON_ROLE_TENANT_ID})" for mid in common_role_menu_ids()) + ';')
    ids = [m[0] for m in MENUS]
    assert len(ids) == len(set(ids)), '菜单 id 重复'
    print('\n'.join(out))


if __name__ == '__main__':
    main()
