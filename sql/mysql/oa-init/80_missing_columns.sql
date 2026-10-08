-- 实体类（*DO.java）里有、但开源版建表脚本里漏掉的字段。
-- 由 script/db-init/do_schema.py --check 校验发现。
SET NAMES utf8mb4;

-- 流程定义扩展：流程分类、可发起部门、是否允许审批人撤回
ALTER TABLE `bpm_process_definition_info` ADD COLUMN `category` varchar(64) NULL DEFAULT NULL COMMENT '流程分类编码' AFTER `model_id`;
ALTER TABLE `bpm_process_definition_info` ADD COLUMN `start_dept_ids` varchar(256) NULL DEFAULT NULL COMMENT '可发起部门编号数组';
ALTER TABLE `bpm_process_definition_info` ADD COLUMN `allow_withdraw_task` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否允许审批人撤回任务';

-- 用车申请单：还车状态
ALTER TABLE `oa_car_apply_bill` ADD COLUMN `return_status` int NULL DEFAULT 0 COMMENT '还车状态';

-- 用印申请单：用章事由
ALTER TABLE `oa_seal_apply_bill` ADD COLUMN `cause` varchar(500) NULL DEFAULT NULL COMMENT '用章事由';

-- 部门：组织类型（0 部门 1 公司）
ALTER TABLE `system_dept` ADD COLUMN `org_type` varchar(10) NULL DEFAULT '0' COMMENT '组织类型（0部门 1公司）';
