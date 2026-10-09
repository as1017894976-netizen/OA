-- 空模板：在完整初始化脚本（含 OA、人力、流程等）导入后执行，去掉所有业务模块的数据，
-- 只留下「工作台」「系统管理」「基础设施」三棵菜单和对应的表。
-- skeleton-init.sql 就是「完整脚本 + 本文件」导出的结果。
SET NAMES utf8mb4;

-- 1. 菜单：只保留 工作台(5049)、系统管理(1)、基础设施(2) 及其下级
DROP TABLE IF EXISTS tmp_keep_menu;
CREATE TABLE tmp_keep_menu (id BIGINT PRIMARY KEY);
INSERT INTO tmp_keep_menu
WITH RECURSIVE t AS (
    SELECT id FROM system_menu WHERE id IN (1, 2, 5049)
    UNION ALL
    -- 跳过两个打不开的页面：定时任务(110) 后端用的是 xxl-job，没有对应接口；代码生成案例(1070) 前端没有这个页面
    SELECT m.id FROM system_menu m JOIN t ON m.parent_id = t.id WHERE m.id NOT IN (110, 1070)
)
SELECT id FROM t;
DELETE FROM system_role_menu WHERE menu_id NOT IN (SELECT id FROM tmp_keep_menu);
DELETE FROM system_menu WHERE id NOT IN (SELECT id FROM tmp_keep_menu);
DROP TABLE tmp_keep_menu;

-- 2. 业务模块的表
DROP TABLE IF EXISTS
    asset_category, asset_goods, asset_info, asset_life_time,
    bpm_category, bpm_form, bpm_oa_leave, bpm_process_definition_info, bpm_process_expression,
    bpm_process_instance_copy, bpm_process_listener, bpm_user_group,
    common_attachment,
    infra_job, infra_job_log,
    hrm_employee, hrm_employee_education, hrm_employee_entry_bill, hrm_employee_entry_bill_education,
    hrm_employee_entry_bill_family, hrm_employee_entry_bill_work_experience, hrm_employee_family,
    hrm_employee_regular_bill, hrm_employee_resignation_bill, hrm_employee_transfer_bill,
    hrm_employee_work_experience,
    oa_car, oa_car_apply_bill, oa_car_return_bill, oa_file_favorite, oa_file_info, oa_file_permission,
    oa_meeting_room, oa_meeting_room_booking, oa_seal, oa_seal_apply_bill,
    wms_goods_common_operation_order, wms_goods_warehousing_detail, wms_purchase_in_warehousing,
    wms_purchase_order, wms_purchase_order_detail, wms_warehousing;

-- 3. 业务模块的字典
DELETE d FROM system_dict_data d JOIN system_dict_type t ON t.type = d.dict_type
WHERE SUBSTRING_INDEX(t.type, '_', 1) IN
      ('ai', 'bpm', 'brokerage', 'crm', 'erp', 'hrm', 'iot', 'member', 'mp', 'oa', 'pay', 'product', 'promotion', 'trade');
DELETE FROM system_dict_data
WHERE SUBSTRING_INDEX(dict_type, '_', 1) IN
      ('ai', 'bpm', 'brokerage', 'crm', 'erp', 'hrm', 'iot', 'member', 'mp', 'oa', 'pay', 'product', 'promotion', 'trade');
DELETE FROM system_dict_type
WHERE SUBSTRING_INDEX(type, '_', 1) IN
      ('ai', 'bpm', 'brokerage', 'crm', 'erp', 'hrm', 'iot', 'member', 'mp', 'oa', 'pay', 'product', 'promotion', 'trade');

-- 4. 首页：去掉依赖流程模块的「任务列表」组件，以及应用中心里指向流程、报表的入口
DELETE FROM system_home_page_layout WHERE component_code = 'workbench_task_list';
DELETE FROM system_home_component WHERE code = 'workbench_task_list';
DELETE FROM system_home_app_config WHERE name IN ('流程审批', '数据报表');
