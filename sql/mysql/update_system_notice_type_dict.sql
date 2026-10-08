-- =============================================
-- 更新通知公告类型字典数据
-- 执行时间：2025-01-XX
-- 说明：将原有的"通知"和"公告"更新为新的字典选项
-- =============================================

-- 删除原有的字典数据（如果存在）
DELETE FROM `system_dict_data` WHERE `dict_type` = 'system_notice_type' AND `deleted` = b'0';

-- 插入新的字典数据
-- 不指定 id，避免与主脚本中已有的字典数据主键冲突
INSERT INTO `system_dict_data` (`sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES
(1, '通知公告', '1', 'system_notice_type', 0, 'primary', '', '通知公告', 'admin', NOW(), 'admin', NOW(), b'0'),
(2, '公司动态', '2', 'system_notice_type', 0, 'success', '', '公司动态', 'admin', NOW(), 'admin', NOW(), b'0'),
(3, '行业咨询', '3', 'system_notice_type', 0, 'info', '', '行业咨询', 'admin', NOW(), 'admin', NOW(), b'0'),
(4, '规章制度', '4', 'system_notice_type', 0, 'warning', '', '规章制度', 'admin', NOW(), 'admin', NOW(), b'0');

-- 如果ID冲突，可以使用以下方式（自动获取下一个ID）：
-- INSERT INTO `system_dict_data` (`sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) 
-- SELECT 1, '通知公告', '1', 'system_notice_type', 0, 'primary', '', '通知公告', 'admin', NOW(), 'admin', NOW(), b'0'
-- WHERE NOT EXISTS (SELECT 1 FROM `system_dict_data` WHERE `dict_type` = 'system_notice_type' AND `value` = '1' AND `deleted` = b'0');
-- 
-- INSERT INTO `system_dict_data` (`sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) 
-- SELECT 2, '公司动态', '2', 'system_notice_type', 0, 'success', '', '公司动态', 'admin', NOW(), 'admin', NOW(), b'0'
-- WHERE NOT EXISTS (SELECT 1 FROM `system_dict_data` WHERE `dict_type` = 'system_notice_type' AND `value` = '2' AND `deleted` = b'0');
-- 
-- INSERT INTO `system_dict_data` (`sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) 
-- SELECT 3, '行业咨询', '3', 'system_notice_type', 0, 'info', '', '行业咨询', 'admin', NOW(), 'admin', NOW(), b'0'
-- WHERE NOT EXISTS (SELECT 1 FROM `system_dict_data` WHERE `dict_type` = 'system_notice_type' AND `value` = '3' AND `deleted` = b'0');
-- 
-- INSERT INTO `system_dict_data` (`sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) 
-- SELECT 4, '规章制度', '4', 'system_notice_type', 0, 'warning', '', '规章制度', 'admin', NOW(), 'admin', NOW(), b'0'
-- WHERE NOT EXISTS (SELECT 1 FROM `system_dict_data` WHERE `dict_type` = 'system_notice_type' AND `value` = '4' AND `deleted` = b'0');
