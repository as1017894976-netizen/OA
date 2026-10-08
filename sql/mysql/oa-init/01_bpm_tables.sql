SET NAMES utf8mb4;

DROP TABLE IF EXISTS `bpm_category`;
CREATE TABLE `bpm_category` (
  `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '分类编号',
  `name` VARCHAR(30) NULL COMMENT '分类名',
  `code` VARCHAR(30) NULL COMMENT '分类标志',
  `description` VARCHAR(255) NOT NULL COMMENT '分类描述',
  `status` TINYINT NULL COMMENT '分类状态',
  `sort` INT NULL COMMENT '分类排序',
  `creator` VARCHAR(64) NULL COMMENT '创建者',
  `create_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` VARCHAR(64) NULL COMMENT '更新者',
  `update_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` BIT NOT NULL DEFAULT b'0' COMMENT '是否删除',
  `tenant_id` BIGINT NOT NULL DEFAULT 0 COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='BPM 流程分类';

DROP TABLE IF EXISTS `bpm_form`;
CREATE TABLE `bpm_form` (
  `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '编号',
  `name` VARCHAR(64) NOT NULL COMMENT '表单名',
  `status` TINYINT NOT NULL COMMENT '开启状态',
  `conf` VARCHAR(1000) NOT NULL COMMENT '表单的配置',
  `fields` VARCHAR(5000) NOT NULL COMMENT '表单项的数组',
  `remark` VARCHAR(255) NULL COMMENT '备注',
  `creator` VARCHAR(64) NULL COMMENT '创建者',
  `create_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` VARCHAR(64) NULL COMMENT '更新者',
  `update_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` BIT NOT NULL DEFAULT b'0' COMMENT '是否删除',
  `tenant_id` BIGINT NOT NULL DEFAULT 0 COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='BPM 表单定义表';

DROP TABLE IF EXISTS `bpm_oa_leave`;
CREATE TABLE `bpm_oa_leave` (
  `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '请假表单主键',
  `user_id` BIGINT NOT NULL COMMENT '申请人的用户编号',
  `type` TINYINT NOT NULL COMMENT '请假类型',
  `reason` VARCHAR(200) NOT NULL COMMENT '请假原因',
  `start_time` DATETIME NOT NULL COMMENT '开始时间',
  `end_time` DATETIME NOT NULL COMMENT '结束时间',
  `day` TINYINT NOT NULL COMMENT '请假天数',
  `status` TINYINT NOT NULL COMMENT '审批结果',
  `process_instance_id` VARCHAR(64) NULL COMMENT '流程实例的编号',
  `creator` VARCHAR(64) NULL COMMENT '创建者',
  `create_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` VARCHAR(64) NULL COMMENT '更新者',
  `update_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` BIT NOT NULL DEFAULT b'0' COMMENT '是否删除',
  `tenant_id` BIGINT NOT NULL DEFAULT 0 COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='OA 请假申请表';

DROP TABLE IF EXISTS `bpm_process_definition_info`;
CREATE TABLE `bpm_process_definition_info` (
  `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '编号',
  `process_definition_id` VARCHAR(64) NOT NULL COMMENT '流程定义的编号',
  `model_id` VARCHAR(64) NOT NULL COMMENT '流程模型的编号',
  `model_type` TINYINT NOT NULL DEFAULT 10 COMMENT '流程模型的类型',
  `icon` VARCHAR(512) NULL COMMENT '图标',
  `description` VARCHAR(255) NULL COMMENT '描述',
  `form_type` TINYINT NOT NULL COMMENT '表单类型',
  `form_id` BIGINT NULL COMMENT '表单编号',
  `form_conf` VARCHAR(1000) NULL COMMENT '表单的配置',
  `form_fields` VARCHAR(5000) NULL COMMENT '表单项的数组',
  `form_custom_create_path` VARCHAR(255) NULL COMMENT '自定义表单的提交路径',
  `form_custom_view_path` VARCHAR(255) NULL COMMENT '自定义表单的查看路径',
  `simple_model` TEXT NULL COMMENT 'SIMPLE 设计器模型数据 JSON 格式',
  `sort` BIGINT NULL DEFAULT 0 COMMENT '排序值',
  `visible` BIT NOT NULL DEFAULT b'1' COMMENT '是否可见',
  `start_user_ids` VARCHAR(256) NULL COMMENT '可发起用户编号数组',
  `manager_user_ids` VARCHAR(256) NULL COMMENT '可管理用户编号数组',
  `allow_cancel_running_process` BIT NOT NULL DEFAULT b'1' COMMENT '是否允许撤销审批中的申请',
  `process_id_rule` VARCHAR(255) NULL COMMENT '流程 ID 规则',
  `auto_approval_type` TINYINT NOT NULL DEFAULT 0 COMMENT '自动去重类型',
  `title_setting` VARCHAR(512) NULL COMMENT '标题设置',
  `summary_setting` VARCHAR(512) NULL COMMENT '摘要设置',
  `creator` VARCHAR(64) NULL COMMENT '创建者',
  `create_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` VARCHAR(64) NULL COMMENT '更新者',
  `update_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` BIT NOT NULL DEFAULT b'0' COMMENT '是否删除',
  `tenant_id` BIGINT NOT NULL DEFAULT 0 COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='BPM 流程定义的信息表';

DROP TABLE IF EXISTS `bpm_process_expression`;
CREATE TABLE `bpm_process_expression` (
  `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '编号',
  `name` VARCHAR(64) NOT NULL COMMENT '表达式名字',
  `status` TINYINT NOT NULL COMMENT '表达式状态',
  `expression` VARCHAR(1024) NOT NULL COMMENT '表达式',
  `creator` VARCHAR(64) NULL COMMENT '创建者',
  `create_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` VARCHAR(64) NULL COMMENT '更新者',
  `update_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` BIT NOT NULL DEFAULT b'0' COMMENT '是否删除',
  `tenant_id` BIGINT NOT NULL DEFAULT 0 COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='BPM 流程表达式表';

DROP TABLE IF EXISTS `bpm_process_instance_copy`;
CREATE TABLE `bpm_process_instance_copy` (
  `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '编号',
  `user_id` BIGINT NOT NULL DEFAULT 0 COMMENT '用户编号，被抄送人',
  `start_user_id` BIGINT NOT NULL DEFAULT 0 COMMENT '发起流程的用户编号',
  `process_instance_id` VARCHAR(64) NOT NULL COMMENT '流程实例的编号',
  `process_instance_name` VARCHAR(64) NOT NULL COMMENT '流程实例的名字',
  `process_definition_id` VARCHAR(64) NOT NULL COMMENT '流程定义的编号',
  `category` VARCHAR(64) NOT NULL COMMENT '流程定义的分类',
  `activity_id` VARCHAR(64) NOT NULL COMMENT '流程活动的编号',
  `activity_name` VARCHAR(64) NOT NULL COMMENT '流程活动的名字',
  `task_id` VARCHAR(64) NULL COMMENT '流程任务的编号',
  `reason` VARCHAR(256) NULL COMMENT '抄送意见',
  `creator` VARCHAR(64) NULL COMMENT '创建者',
  `create_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` VARCHAR(64) NULL COMMENT '更新者',
  `update_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` BIT NOT NULL DEFAULT b'0' COMMENT '是否删除',
  `tenant_id` BIGINT NOT NULL DEFAULT 0 COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='BPM 流程实例抄送表';

DROP TABLE IF EXISTS `bpm_process_listener`;
CREATE TABLE `bpm_process_listener` (
  `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '编号',
  `name` VARCHAR(30) NOT NULL COMMENT '监听器名字',
  `type` VARCHAR(255) NOT NULL COMMENT '监听器类型',
  `status` TINYINT NOT NULL COMMENT '监听器状态',
  `event` VARCHAR(30) NOT NULL COMMENT '监听事件',
  `value_type` VARCHAR(64) NOT NULL COMMENT '监听器值类型',
  `value` VARCHAR(1024) NOT NULL COMMENT '监听器值',
  `creator` VARCHAR(64) NULL COMMENT '创建者',
  `create_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` VARCHAR(64) NULL COMMENT '更新者',
  `update_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` BIT NOT NULL DEFAULT b'0' COMMENT '是否删除',
  `tenant_id` BIGINT NOT NULL DEFAULT 0 COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='BPM 流程监听器表';

DROP TABLE IF EXISTS `bpm_user_group`;
CREATE TABLE `bpm_user_group` (
  `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '编号',
  `name` VARCHAR(30) NOT NULL COMMENT '组名',
  `description` VARCHAR(255) NOT NULL COMMENT '描述',
  `user_ids` VARCHAR(1024) NULL COMMENT '成员编号数组',
  `status` TINYINT NOT NULL COMMENT '状态（0正常 1停用）',
  `creator` VARCHAR(64) NULL COMMENT '创建者',
  `create_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` VARCHAR(64) NULL COMMENT '更新者',
  `update_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` BIT NOT NULL DEFAULT b'0' COMMENT '是否删除',
  `tenant_id` BIGINT NOT NULL DEFAULT 0 COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='BPM 用户组表';

