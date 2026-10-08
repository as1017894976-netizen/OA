-- 通用附件表（取自 sql/mysql/common_attachment_migration.sql 第 1 步；新装库没有旧的 oa_attachment，无需迁移数据）
SET NAMES utf8mb4;

CREATE TABLE IF NOT EXISTS `common_attachment` (
    `id` bigint NOT NULL AUTO_INCREMENT COMMENT '附件ID',
    `business_type` varchar(50) NOT NULL COMMENT '业务类型',
    `business_id` bigint NOT NULL COMMENT '业务单据ID',
    `file_name` varchar(255) NOT NULL COMMENT '文件名称',
    `file_path` varchar(500) NOT NULL COMMENT '文件路径',
    `file_url` varchar(500) NOT NULL COMMENT '文件访问URL',
    `file_size` bigint NOT NULL COMMENT '文件大小（字节）',
    `file_type` varchar(100) DEFAULT NULL COMMENT '文件类型（MIME类型）',
    `file_extension` varchar(20) DEFAULT NULL COMMENT '文件扩展名',
    `upload_time` datetime DEFAULT NULL COMMENT '上传时间',
    `sort_order` int DEFAULT 0 COMMENT '排序顺序',
    `remark` varchar(500) DEFAULT NULL COMMENT '备注',
    `creator` varchar(64) DEFAULT '' COMMENT '创建者',
    `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `updater` varchar(64) DEFAULT '' COMMENT '更新者',
    `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
    `tenant_id` bigint NOT NULL DEFAULT 0 COMMENT '租户编号',
    PRIMARY KEY (`id`),
    KEY `idx_business` (`business_type`, `business_id`),
    KEY `idx_create_time` (`create_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='通用附件信息表';
