-- 实体类（*DO.java）里有、但开源版建表脚本里漏掉的字段。
-- 由 script/db-init/do_schema.py --check 校验发现。
SET NAMES utf8mb4;

-- 流程定义扩展：流程分类、可发起部门、是否允许审批人撤回、前后置通知、打印模板
ALTER TABLE `bpm_process_definition_info` ADD COLUMN `category` varchar(64) NULL DEFAULT NULL COMMENT '流程分类编码' AFTER `model_id`;
ALTER TABLE `bpm_process_definition_info` ADD COLUMN `start_dept_ids` varchar(256) NULL DEFAULT NULL COMMENT '可发起部门编号数组';
ALTER TABLE `bpm_process_definition_info` ADD COLUMN `allow_withdraw_task` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否允许审批人撤回任务';
ALTER TABLE `bpm_process_definition_info` ADD COLUMN `process_before_trigger_setting` text NULL COMMENT '流程前置通知设置';
ALTER TABLE `bpm_process_definition_info` ADD COLUMN `process_after_trigger_setting` text NULL COMMENT '流程后置通知设置';
ALTER TABLE `bpm_process_definition_info` ADD COLUMN `task_before_trigger_setting` text NULL COMMENT '任务前置通知设置';
ALTER TABLE `bpm_process_definition_info` ADD COLUMN `task_after_trigger_setting` text NULL COMMENT '任务后置通知设置';
ALTER TABLE `bpm_process_definition_info` ADD COLUMN `print_template_setting` text NULL COMMENT '打印模板设置';

-- 用车申请单：还车状态
ALTER TABLE `oa_car_apply_bill` ADD COLUMN `return_status` int NULL DEFAULT 0 COMMENT '还车状态';

-- 用印申请单：用章事由，建表脚本叫 use_purpose，实体类叫 cause
ALTER TABLE `oa_seal_apply_bill` CHANGE COLUMN `use_purpose` `cause` varchar(500) NOT NULL COMMENT '用章事由';

-- 部门：组织类型（0 部门 1 公司）
ALTER TABLE `system_dept` ADD COLUMN `org_type` varchar(10) NULL DEFAULT '0' COMMENT '组织类型（0部门 1公司）';
