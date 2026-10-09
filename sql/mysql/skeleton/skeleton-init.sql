-- 空模板初始化脚本：只有系统管理、基础设施两个模块的表、菜单和字典。
-- 由 PR #1 的完整脚本 ruoyi-office-init.sql 导入后执行同目录 cleanup.sql 再导出得到。
-- 用法：CREATE DATABASE `ruoyi-office` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci; 然后导入本文件。

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
DROP TABLE IF EXISTS `infra_api_access_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `infra_api_access_log` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '日志主键',
  `trace_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '链路追踪编号',
  `user_id` bigint NOT NULL DEFAULT '0' COMMENT '用户编号',
  `user_type` tinyint NOT NULL DEFAULT '0' COMMENT '用户类型',
  `application_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '应用名',
  `request_method` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '请求方法名',
  `request_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '请求地址',
  `request_params` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '请求参数',
  `response_body` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '响应结果',
  `user_ip` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户 IP',
  `user_agent` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '浏览器 UA',
  `operate_module` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '操作模块',
  `operate_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '操作名',
  `operate_type` tinyint DEFAULT '0' COMMENT '操作分类',
  `begin_time` datetime NOT NULL COMMENT '开始请求时间',
  `end_time` datetime NOT NULL COMMENT '结束请求时间',
  `duration` int NOT NULL COMMENT '执行时长',
  `result_code` int NOT NULL DEFAULT '0' COMMENT '结果码',
  `result_msg` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '结果提示',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_create_time` (`create_time`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=36233 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='API 访问日志表';
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `infra_api_access_log` WRITE;
/*!40000 ALTER TABLE `infra_api_access_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `infra_api_access_log` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `infra_api_error_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `infra_api_error_log` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `trace_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '链路追踪编号',
  `user_id` bigint NOT NULL DEFAULT '0' COMMENT '用户编号',
  `user_type` tinyint NOT NULL DEFAULT '0' COMMENT '用户类型',
  `application_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '应用名',
  `request_method` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '请求方法名',
  `request_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '请求地址',
  `request_params` varchar(8000) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '请求参数',
  `user_ip` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户 IP',
  `user_agent` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '浏览器 UA',
  `exception_time` datetime NOT NULL COMMENT '异常发生时间',
  `exception_name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '异常名',
  `exception_message` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '异常导致的消息',
  `exception_root_cause_message` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '异常导致的根消息',
  `exception_stack_trace` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '异常的栈轨迹',
  `exception_class_name` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '异常发生的类全名',
  `exception_file_name` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '异常发生的类文件',
  `exception_method_name` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '异常发生的方法名',
  `exception_line_number` int NOT NULL COMMENT '异常发生的方法所在行',
  `process_status` tinyint NOT NULL COMMENT '处理状态',
  `process_time` datetime DEFAULT NULL COMMENT '处理时间',
  `process_user_id` int DEFAULT '0' COMMENT '处理用户编号',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=23367 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='系统异常日志';
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `infra_api_error_log` WRITE;
/*!40000 ALTER TABLE `infra_api_error_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `infra_api_error_log` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `infra_codegen_column`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `infra_codegen_column` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_id` bigint NOT NULL COMMENT '表编号',
  `column_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '字段名',
  `data_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '字段类型',
  `column_comment` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '字段描述',
  `nullable` bit(1) NOT NULL COMMENT '是否允许为空',
  `primary_key` bit(1) NOT NULL COMMENT '是否主键',
  `ordinal_position` int NOT NULL COMMENT '排序',
  `java_type` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Java 属性类型',
  `java_field` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Java 属性名',
  `dict_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '字典类型',
  `example` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '数据示例',
  `create_operation` bit(1) NOT NULL COMMENT '是否为 Create 创建操作的字段',
  `update_operation` bit(1) NOT NULL COMMENT '是否为 Update 更新操作的字段',
  `list_operation` bit(1) NOT NULL COMMENT '是否为 List 查询操作的字段',
  `list_operation_condition` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '=' COMMENT 'List 查询操作的条件类型',
  `list_operation_result` bit(1) NOT NULL COMMENT '是否为 List 查询操作的返回字段',
  `html_type` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '显示类型',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2880 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='代码生成表字段定义';
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `infra_codegen_column` WRITE;
/*!40000 ALTER TABLE `infra_codegen_column` DISABLE KEYS */;
/*!40000 ALTER TABLE `infra_codegen_column` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `infra_codegen_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `infra_codegen_table` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `data_source_config_id` bigint NOT NULL COMMENT '数据源配置的编号',
  `scene` tinyint NOT NULL DEFAULT '1' COMMENT '生成场景',
  `table_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '表名称',
  `table_comment` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '表描述',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  `module_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '模块名',
  `business_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '业务名',
  `class_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '类名称',
  `class_comment` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '类描述',
  `author` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '作者',
  `template_type` tinyint NOT NULL DEFAULT '1' COMMENT '模板类型',
  `front_type` tinyint NOT NULL COMMENT '前端类型',
  `parent_menu_id` bigint DEFAULT NULL COMMENT '父菜单编号',
  `master_table_id` bigint DEFAULT NULL COMMENT '主表的编号',
  `sub_join_column_id` bigint DEFAULT NULL COMMENT '子表关联主表的字段编号',
  `sub_join_many` bit(1) DEFAULT NULL COMMENT '主表与子表是否一对多',
  `tree_parent_column_id` bigint DEFAULT NULL COMMENT '树表的父字段编号',
  `tree_name_column_id` bigint DEFAULT NULL COMMENT '树表的名字字段编号',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=210 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='代码生成表定义';
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `infra_codegen_table` WRITE;
/*!40000 ALTER TABLE `infra_codegen_table` DISABLE KEYS */;
/*!40000 ALTER TABLE `infra_codegen_table` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `infra_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `infra_config` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '参数主键',
  `category` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '参数分组',
  `type` tinyint NOT NULL COMMENT '参数类型',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '参数名称',
  `config_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '参数键名',
  `value` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '参数键值',
  `visible` bit(1) NOT NULL COMMENT '是否可见',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='参数配置表';
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `infra_config` WRITE;
/*!40000 ALTER TABLE `infra_config` DISABLE KEYS */;
INSERT INTO `infra_config` VALUES (2,'biz',1,'用户管理-账号初始密码','system.user.init-password','123456',_binary '\0','初始化密码 123456','admin','2021-01-05 17:03:48','1','2024-07-20 17:22:47',_binary '\0'),(7,'url',2,'MySQL 监控的地址','url.druid','',_binary '','','1','2023-04-07 13:41:16','1','2023-04-07 14:33:38',_binary '\0'),(8,'url',2,'SkyWalking 监控的地址','url.skywalking','',_binary '','','1','2023-04-07 13:41:16','1','2023-04-07 14:57:03',_binary '\0'),(9,'url',2,'Spring Boot Admin 监控的地址','url.spring-boot-admin','',_binary '','','1','2023-04-07 13:41:16','1','2023-04-07 14:52:07',_binary '\0'),(10,'url',2,'Swagger 接口文档的地址','url.swagger','',_binary '','','1','2023-04-07 13:41:16','1','2023-04-07 14:59:00',_binary '\0'),(12,'test2',2,'test3','test4','test5',_binary '','test6','1','2023-12-03 09:55:16','1','2025-04-06 21:00:09',_binary '\0'),(13,'用户管理-账号初始密码',2,'用户管理-注册开关','system.user.register-enabled','true',_binary '\0','','1','2025-04-26 17:23:41','1','2025-04-26 17:23:41',_binary '\0');
/*!40000 ALTER TABLE `infra_config` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `infra_data_source_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `infra_data_source_config` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键编号',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '参数名称',
  `url` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '数据源连接',
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户名',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '密码',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='数据源配置表';
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `infra_data_source_config` WRITE;
/*!40000 ALTER TABLE `infra_data_source_config` DISABLE KEYS */;
/*!40000 ALTER TABLE `infra_data_source_config` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `infra_file`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `infra_file` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '文件编号',
  `config_id` bigint DEFAULT NULL COMMENT '配置编号',
  `name` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '文件名',
  `path` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '文件路径',
  `url` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '文件 URL',
  `type` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '文件类型',
  `size` int NOT NULL COMMENT '文件大小',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2163 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='文件表';
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `infra_file` WRITE;
/*!40000 ALTER TABLE `infra_file` DISABLE KEYS */;
/*!40000 ALTER TABLE `infra_file` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `infra_file_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `infra_file_config` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `name` varchar(63) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '配置名',
  `storage` tinyint NOT NULL COMMENT '存储器',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  `master` bit(1) NOT NULL COMMENT '是否为主配置',
  `config` varchar(4096) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '存储配置',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='文件配置表';
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `infra_file_config` WRITE;
/*!40000 ALTER TABLE `infra_file_config` DISABLE KEYS */;
INSERT INTO `infra_file_config` VALUES (4,'数据库（示例）',1,'我是数据库',_binary '\0','{\"@class\":\"cn.iocoder.yudao.module.infra.framework.file.core.client.db.DBFileClientConfig\",\"domain\":\"http://127.0.0.1:48080\"}','1','2022-03-15 23:56:24','1','2025-11-24 20:57:14',_binary '\0'),(22,'七牛存储器（示例）',20,'请换成你自己的密钥！！！',_binary '','{\"@class\":\"cn.iocoder.yudao.module.infra.framework.file.core.client.s3.S3FileClientConfig\",\"endpoint\":\"s3.cn-south-1.qiniucs.com\",\"domain\":\"http://test.yudao.iocoder.cn\",\"bucket\":\"ruoyi-vue-pro\",\"accessKey\":\"3TvrJ70gl2Gt6IBe7_IZT1F6i_k0iMuRtyEv4EyS\",\"accessSecret\":\"wd0tbVBYlp0S-ihA8Qg2hPLncoP83wyrIq24OZuY\",\"enablePathStyleAccess\":false,\"enablePublicAccess\":true}','1','2024-01-13 22:11:12','1','2025-11-24 20:57:14',_binary '\0'),(24,'腾讯云存储（示例）',20,'请换成你的密钥！！！',_binary '\0','{\"@class\":\"cn.iocoder.yudao.module.infra.framework.file.core.client.s3.S3FileClientConfig\",\"endpoint\":\"https://cos.ap-shanghai.myqcloud.com\",\"domain\":\"http://tengxun-oss.iocoder.cn\",\"bucket\":\"aoteman-1255880240\",\"accessKey\":\"AKIDAF6WSh1uiIjwqtrOsGSN3WryqTM6cTMt\",\"accessSecret\":\"X\",\"enablePathStyleAccess\":false,\"enablePublicAccess\":true}','1','2024-11-09 16:03:22','1','2025-11-24 20:57:14',_binary '\0'),(25,'阿里云存储（示例）',20,'',_binary '\0','{\"@class\":\"cn.iocoder.yudao.module.infra.framework.file.core.client.s3.S3FileClientConfig\",\"endpoint\":\"oss-cn-beijing.aliyuncs.com\",\"domain\":\"http://ali-oss.iocoder.cn\",\"bucket\":\"yunai-aoteman\",\"accessKey\":\"LTAI5tEQLgnDyjh3WpNcdMKA\",\"accessSecret\":\"X\",\"enablePathStyleAccess\":false,\"enablePublicAccess\":true}','1','2024-11-09 16:47:08','1','2025-11-24 20:57:14',_binary '\0'),(26,'火山云存储（示例）',20,'',_binary '\0','{\"@class\":\"cn.iocoder.yudao.module.infra.framework.file.core.client.s3.S3FileClientConfig\",\"endpoint\":\"tos-s3-cn-beijing.volces.com\",\"domain\":null,\"bucket\":\"yunai\",\"accessKey\":\"AKLTZjc3Zjc4MzZmMjU3NDk0ZTgxYmIyMmFkNTIwMDI1ZGE\",\"accessSecret\":\"X==\",\"enablePathStyleAccess\":false,\"enablePublicAccess\":true}','1','2024-11-09 16:56:42','1','2025-11-24 20:57:14',_binary '\0'),(27,'华为云存储（示例）',20,'',_binary '\0','{\"@class\":\"cn.iocoder.yudao.module.infra.framework.file.core.client.s3.S3FileClientConfig\",\"endpoint\":\"obs.cn-east-3.myhuaweicloud.com\",\"domain\":\"\",\"bucket\":\"yudao\",\"accessKey\":\"PVDONDEIOTW88LF8DC4U\",\"accessSecret\":\"X\",\"enablePathStyleAccess\":false,\"enablePublicAccess\":true}','1','2024-11-09 17:18:41','1','2025-11-24 20:57:14',_binary '\0'),(28,'MinIO 存储（示例）',20,'',_binary '\0','{\"@class\":\"cn.iocoder.yudao.module.infra.framework.file.core.client.s3.S3FileClientConfig\",\"endpoint\":\"http://127.0.0.1:9000\",\"domain\":\"http://127.0.0.1:9000/yudao\",\"bucket\":\"yudao\",\"accessKey\":\"admin\",\"accessSecret\":\"password\",\"enablePathStyleAccess\":false,\"enablePublicAccess\":true}','1','2024-11-09 17:43:10','1','2025-11-24 20:57:14',_binary '\0'),(29,'本地存储（示例）',10,'mac/linux 使用 /，windows 使用 \\',_binary '\0','{\"@class\":\"cn.iocoder.yudao.module.infra.framework.file.core.client.local.LocalFileClientConfig\",\"basePath\":\"/Users/yunai/tmp/file\",\"domain\":\"http://127.0.0.1:48080\"}','1','2025-05-02 11:25:45','1','2025-11-24 20:57:14',_binary '\0'),(30,'SFTP 存储（示例）',12,'',_binary '\0','{\"@class\":\"cn.iocoder.yudao.module.infra.framework.file.core.client.sftp.SftpFileClientConfig\",\"basePath\":\"/upload\",\"domain\":\"http://127.0.0.1:48080\",\"host\":\"127.0.0.1\",\"port\":2222,\"username\":\"foo\",\"password\":\"pass\"}','1','2025-05-02 16:34:10','1','2025-11-24 20:57:14',_binary '\0'),(34,'七牛云存储【私有】（示例）',20,'请换成你自己的密钥！！！',_binary '\0','{\"@class\":\"cn.iocoder.yudao.module.infra.framework.file.core.client.s3.S3FileClientConfig\",\"endpoint\":\"s3.cn-south-1.qiniucs.com\",\"domain\":\"http://t151glocd.hn-bkt.clouddn.com\",\"bucket\":\"ruoyi-vue-pro-private\",\"accessKey\":\"3TvrJ70gl2Gt6IBe7_IZT1F6i_k0iMuRtyEv4EyS\",\"accessSecret\":\"wd0tbVBYlp0S-ihA8Qg2hPLncoP83wyrIq24OZuY\",\"enablePathStyleAccess\":false,\"enablePublicAccess\":false}','1','2025-08-17 21:22:00','1','2025-11-24 20:57:14',_binary '\0'),(35,'1',20,'1',_binary '\0','{\"@class\":\"cn.iocoder.yudao.module.infra.framework.file.core.client.s3.S3FileClientConfig\",\"endpoint\":\"http://www.baidu.com\",\"domain\":\"http://www.xxx.com\",\"bucket\":\"1\",\"accessKey\":\"2\",\"accessSecret\":\"3\",\"enablePathStyleAccess\":false,\"enablePublicAccess\":false,\"region\":\"1\"}','1','2025-10-02 14:32:12','1','2025-11-29 15:59:39',_binary '\0');
/*!40000 ALTER TABLE `infra_file_config` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `infra_file_content`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `infra_file_content` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `config_id` bigint NOT NULL COMMENT '配置编号',
  `path` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '文件路径',
  `content` mediumblob NOT NULL COMMENT '文件内容',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=286 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='文件表';
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `infra_file_content` WRITE;
/*!40000 ALTER TABLE `infra_file_content` DISABLE KEYS */;
/*!40000 ALTER TABLE `infra_file_content` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `system_dept`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `system_dept` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '部门id',
  `name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '部门名称',
  `parent_id` bigint NOT NULL DEFAULT '0' COMMENT '父部门id',
  `sort` int NOT NULL DEFAULT '0' COMMENT '显示顺序',
  `leader_user_id` bigint DEFAULT NULL COMMENT '负责人',
  `phone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '联系电话',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '邮箱',
  `status` tinyint NOT NULL COMMENT '部门状态（0正常 1停用）',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  `org_type` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '0' COMMENT '组织类型（0部门 1公司）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=118 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='部门表';
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `system_dept` WRITE;
/*!40000 ALTER TABLE `system_dept` DISABLE KEYS */;
INSERT INTO `system_dept` VALUES (100,'芋道源码',0,0,1,'15888888888','ry@qq.com',0,'admin','2021-01-05 17:03:47','1','2026-01-04 18:01:12',_binary '\0',1,'0'),(101,'深圳总公司',100,1,104,'15888888888','ry@qq.com',0,'admin','2021-01-05 17:03:47','1','2025-03-29 15:49:55',_binary '\0',1,'0'),(102,'长沙分公司',100,2,NULL,'15888888888','ry@qq.com',0,'admin','2021-01-05 17:03:47','','2021-12-15 05:01:40',_binary '\0',1,'0'),(103,'研发部门',101,1,104,'15888888888','ry@qq.com',0,'admin','2021-01-05 17:03:47','1','2026-01-04 18:01:24',_binary '\0',1,'0'),(104,'市场部门',101,2,NULL,'15888888888','ry@qq.com',0,'admin','2021-01-05 17:03:47','','2021-12-15 05:01:38',_binary '\0',1,'0'),(105,'测试部门',101,3,NULL,'15888888888','ry@qq.com',0,'admin','2021-01-05 17:03:47','1','2022-05-16 20:25:15',_binary '\0',1,'0'),(106,'财务部门',101,4,103,'15888888888','ry@qq.com',0,'admin','2021-01-05 17:03:47','103','2022-01-15 21:32:22',_binary '\0',1,'0'),(107,'运维部门',101,5,1,'15888888888','ry@qq.com',0,'admin','2021-01-05 17:03:47','1','2023-12-02 09:28:22',_binary '\0',1,'0'),(108,'市场部门',102,1,NULL,'15888888888','ry@qq.com',0,'admin','2021-01-05 17:03:47','1','2022-02-16 08:35:45',_binary '\0',1,'0'),(109,'财务部门',102,2,NULL,'15888888888','ry@qq.com',0,'admin','2021-01-05 17:03:47','','2021-12-15 05:01:29',_binary '\0',1,'0'),(110,'新部门',0,1,NULL,NULL,NULL,0,'110','2022-02-23 20:46:30','110','2022-02-23 20:46:30',_binary '\0',121,'0'),(111,'顶级部门',0,1,NULL,NULL,NULL,0,'113','2022-03-07 21:44:50','113','2022-03-07 21:44:50',_binary '\0',122,'0'),(112,'产品部门',101,100,1,NULL,NULL,1,'1','2023-12-02 09:45:13','1','2023-12-02 09:45:31',_binary '\0',1,'0'),(113,'支持部门',102,3,104,NULL,NULL,1,'1','2023-12-02 09:47:38','1','2025-03-29 15:00:56',_binary '\0',1,'0'),(116,'某个子部门',0,1,NULL,NULL,NULL,0,'1','2025-12-08 14:51:12','1','2025-12-08 14:51:12',_binary '\0',1,'0'),(117,'某个子部门 2',0,2,NULL,NULL,NULL,0,'1','2025-12-08 14:51:25','1','2025-12-08 14:51:25',_binary '\0',1,'0');
/*!40000 ALTER TABLE `system_dept` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `system_dict_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `system_dict_data` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '字典编码',
  `sort` int NOT NULL DEFAULT '0' COMMENT '字典排序',
  `label` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '字典标签',
  `value` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '字典键值',
  `dict_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '字典类型',
  `status` tinyint NOT NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `color_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '颜色类型',
  `css_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'css 样式',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3254 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='字典数据表';
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `system_dict_data` WRITE;
/*!40000 ALTER TABLE `system_dict_data` DISABLE KEYS */;
INSERT INTO `system_dict_data` VALUES (1,1,'男','1','system_user_sex',0,'primary','A','性别男','admin','2021-01-05 17:03:48','1','2025-12-10 13:19:26',_binary '\0'),(2,2,'女','2','system_user_sex',0,'success','','性别女','admin','2021-01-05 17:03:48','1','2023-11-15 23:30:37',_binary '\0'),(8,1,'正常','1','infra_job_status',0,'success','','正常状态','admin','2021-01-05 17:03:48','1','2022-02-16 19:33:38',_binary '\0'),(9,2,'暂停','2','infra_job_status',0,'danger','','停用状态','admin','2021-01-05 17:03:48','1','2022-02-16 19:33:45',_binary '\0'),(12,1,'系统内置','1','infra_config_type',0,'danger','','参数类型 - 系统内置','admin','2021-01-05 17:03:48','1','2022-02-16 19:06:02',_binary '\0'),(13,2,'自定义','2','infra_config_type',0,'primary','','参数类型 - 自定义','admin','2021-01-05 17:03:48','1','2022-02-16 19:06:07',_binary '\0'),(16,0,'其它','0','infra_operate_type',0,'default','','其它操作','admin','2021-01-05 17:03:48','1','2024-03-14 12:44:19',_binary '\0'),(17,1,'查询','1','infra_operate_type',0,'info','','查询操作','admin','2021-01-05 17:03:48','1','2024-03-14 12:44:20',_binary '\0'),(18,2,'新增','2','infra_operate_type',0,'primary','','新增操作','admin','2021-01-05 17:03:48','1','2024-03-14 12:44:21',_binary '\0'),(19,3,'修改','3','infra_operate_type',0,'warning','','修改操作','admin','2021-01-05 17:03:48','1','2024-03-14 12:44:22',_binary '\0'),(20,4,'删除','4','infra_operate_type',0,'danger','','删除操作','admin','2021-01-05 17:03:48','1','2024-03-14 12:44:23',_binary '\0'),(22,5,'导出','5','infra_operate_type',0,'default','','导出操作','admin','2021-01-05 17:03:48','1','2024-03-14 12:44:24',_binary '\0'),(23,6,'导入','6','infra_operate_type',0,'default','','导入操作','admin','2021-01-05 17:03:48','1','2024-03-14 12:44:25',_binary '\0'),(27,1,'开启','0','common_status',0,'primary','','开启状态','admin','2021-01-05 17:03:48','1','2022-02-16 08:00:39',_binary '\0'),(28,2,'关闭','1','common_status',0,'info','','关闭状态','admin','2021-01-05 17:03:48','1','2022-02-16 08:00:44',_binary '\0'),(29,1,'目录','1','system_menu_type',0,'','','目录','admin','2021-01-05 17:03:48','','2022-02-01 16:43:45',_binary '\0'),(30,2,'菜单','2','system_menu_type',0,'','','菜单','admin','2021-01-05 17:03:48','','2022-02-01 16:43:41',_binary '\0'),(31,3,'按钮','3','system_menu_type',0,'','','按钮','admin','2021-01-05 17:03:48','','2022-02-01 16:43:39',_binary '\0'),(32,1,'内置','1','system_role_type',0,'danger','','内置角色','admin','2021-01-05 17:03:48','1','2022-02-16 13:02:08',_binary '\0'),(33,2,'自定义','2','system_role_type',0,'primary','','自定义角色','admin','2021-01-05 17:03:48','1','2022-02-16 13:02:12',_binary '\0'),(34,1,'全部数据权限','1','system_data_scope',0,'','','全部数据权限','admin','2021-01-05 17:03:48','','2022-02-01 16:47:17',_binary '\0'),(35,2,'指定部门数据权限','2','system_data_scope',0,'','','指定部门数据权限','admin','2021-01-05 17:03:48','','2022-02-01 16:47:18',_binary '\0'),(36,3,'本部门数据权限','3','system_data_scope',0,'','','本部门数据权限','admin','2021-01-05 17:03:48','','2022-02-01 16:47:16',_binary '\0'),(37,4,'本部门及以下数据权限','4','system_data_scope',0,'','','本部门及以下数据权限','admin','2021-01-05 17:03:48','','2022-02-01 16:47:21',_binary '\0'),(38,5,'仅本人数据权限','5','system_data_scope',0,'','','仅本人数据权限','admin','2021-01-05 17:03:48','','2022-02-01 16:47:23',_binary '\0'),(39,0,'成功','0','system_login_result',0,'success','','登陆结果 - 成功','','2021-01-18 06:17:36','1','2022-02-16 13:23:49',_binary '\0'),(40,10,'账号或密码不正确','10','system_login_result',0,'primary','','登陆结果 - 账号或密码不正确','','2021-01-18 06:17:54','1','2022-02-16 13:24:27',_binary '\0'),(41,20,'用户被禁用','20','system_login_result',0,'warning','','登陆结果 - 用户被禁用','','2021-01-18 06:17:54','1','2022-02-16 13:23:57',_binary '\0'),(42,30,'验证码不存在','30','system_login_result',0,'info','','登陆结果 - 验证码不存在','','2021-01-18 06:17:54','1','2022-02-16 13:24:07',_binary '\0'),(43,31,'验证码不正确','31','system_login_result',0,'info','','登陆结果 - 验证码不正确','','2021-01-18 06:17:54','1','2022-02-16 13:24:11',_binary '\0'),(44,100,'未知异常','100','system_login_result',0,'danger','','登陆结果 - 未知异常','','2021-01-18 06:17:54','1','2022-02-16 13:24:23',_binary '\0'),(45,1,'是','true','infra_boolean_string',0,'danger','','Boolean 是否类型 - 是','','2021-01-19 03:20:55','1','2022-03-15 23:01:45',_binary '\0'),(46,1,'否','false','infra_boolean_string',0,'info','','Boolean 是否类型 - 否','','2021-01-19 03:20:55','1','2022-03-15 23:09:45',_binary '\0'),(50,1,'单表（增删改查）','1','infra_codegen_template_type',0,'','',NULL,'','2021-02-05 07:09:06','','2022-03-10 16:33:15',_binary '\0'),(51,2,'树表（增删改查）','2','infra_codegen_template_type',0,'','',NULL,'','2021-02-05 07:14:46','','2022-03-10 16:33:19',_binary '\0'),(53,0,'初始化中','0','infra_job_status',0,'primary','',NULL,'','2021-02-07 07:46:49','1','2022-02-16 19:33:29',_binary '\0'),(57,0,'运行中','0','infra_job_log_status',0,'primary','','RUNNING','','2021-02-08 10:04:24','1','2022-02-16 19:07:48',_binary '\0'),(58,1,'成功','1','infra_job_log_status',0,'success','',NULL,'','2021-02-08 10:06:57','1','2022-02-16 19:07:52',_binary '\0'),(59,2,'失败','2','infra_job_log_status',0,'warning','','失败','','2021-02-08 10:07:38','1','2022-02-16 19:07:56',_binary '\0'),(60,1,'会员','1','user_type',0,'primary','',NULL,'','2021-02-26 00:16:27','1','2022-02-16 10:22:19',_binary '\0'),(61,2,'管理员','2','user_type',0,'success','',NULL,'','2021-02-26 00:16:34','1','2025-04-06 18:37:43',_binary '\0'),(62,0,'未处理','0','infra_api_error_log_process_status',0,'primary','',NULL,'','2021-02-26 07:07:19','1','2022-02-16 20:14:17',_binary '\0'),(63,1,'已处理','1','infra_api_error_log_process_status',0,'success','',NULL,'','2021-02-26 07:07:26','1','2022-02-16 20:14:08',_binary '\0'),(64,2,'已忽略','2','infra_api_error_log_process_status',0,'danger','',NULL,'','2021-02-26 07:07:34','1','2022-02-16 20:14:14',_binary '\0'),(66,1,'阿里云','ALIYUN','system_sms_channel_code',0,'primary','',NULL,'1','2021-04-05 01:05:26','1','2024-07-22 22:23:25',_binary '\0'),(67,1,'验证码','1','system_sms_template_type',0,'warning','',NULL,'1','2021-04-05 21:50:57','1','2022-02-16 12:48:30',_binary '\0'),(68,2,'通知','2','system_sms_template_type',0,'primary','',NULL,'1','2021-04-05 21:51:08','1','2022-02-16 12:48:27',_binary '\0'),(69,0,'营销','3','system_sms_template_type',0,'danger','',NULL,'1','2021-04-05 21:51:15','1','2022-02-16 12:48:22',_binary '\0'),(70,0,'初始化','0','system_sms_send_status',0,'primary','',NULL,'1','2021-04-11 20:18:33','1','2022-02-16 10:26:07',_binary '\0'),(71,1,'发送成功','10','system_sms_send_status',0,'success','',NULL,'1','2021-04-11 20:18:43','1','2022-02-16 10:25:56',_binary '\0'),(72,2,'发送失败','20','system_sms_send_status',0,'danger','',NULL,'1','2021-04-11 20:18:49','1','2022-02-16 10:26:03',_binary '\0'),(73,3,'不发送','30','system_sms_send_status',0,'info','',NULL,'1','2021-04-11 20:19:44','1','2022-02-16 10:26:10',_binary '\0'),(74,0,'等待结果','0','system_sms_receive_status',0,'primary','',NULL,'1','2021-04-11 20:27:43','1','2022-02-16 10:28:24',_binary '\0'),(75,1,'接收成功','10','system_sms_receive_status',0,'success','',NULL,'1','2021-04-11 20:29:25','1','2022-02-16 10:28:28',_binary '\0'),(76,2,'接收失败','20','system_sms_receive_status',0,'danger','',NULL,'1','2021-04-11 20:29:31','1','2022-02-16 10:28:32',_binary '\0'),(77,0,'调试(钉钉)','DEBUG_DING_TALK','system_sms_channel_code',0,'info','',NULL,'1','2021-04-13 00:20:37','1','2022-02-16 10:10:00',_binary '\0'),(80,100,'账号登录','100','system_login_type',0,'primary','','账号登录','1','2021-10-06 00:52:02','1','2022-02-16 13:11:34',_binary '\0'),(81,101,'社交登录','101','system_login_type',0,'info','','社交登录','1','2021-10-06 00:52:17','1','2022-02-16 13:11:40',_binary '\0'),(83,200,'主动登出','200','system_login_type',0,'primary','','主动登出','1','2021-10-06 00:52:58','1','2022-02-16 13:11:49',_binary '\0'),(85,202,'强制登出','202','system_login_type',0,'danger','','强制退出','1','2021-10-06 00:53:41','1','2022-02-16 13:11:57',_binary '\0'),(1145,1,'管理后台','1','infra_codegen_scene',0,'','','代码生成的场景枚举 - 管理后台','1','2022-02-02 13:15:06','1','2022-03-10 16:32:59',_binary '\0'),(1146,2,'用户 APP','2','infra_codegen_scene',0,'','','代码生成的场景枚举 - 用户 APP','1','2022-02-02 13:15:19','1','2022-03-10 16:33:03',_binary '\0'),(1150,1,'数据库','1','infra_file_storage',0,'default','',NULL,'1','2022-03-15 00:25:28','1','2022-03-15 00:25:28',_binary '\0'),(1151,10,'本地磁盘','10','infra_file_storage',0,'default','',NULL,'1','2022-03-15 00:25:41','1','2022-03-15 00:25:56',_binary '\0'),(1152,11,'FTP 服务器','11','infra_file_storage',0,'default','',NULL,'1','2022-03-15 00:26:06','1','2022-03-15 00:26:10',_binary '\0'),(1153,12,'SFTP 服务器','12','infra_file_storage',0,'default','',NULL,'1','2022-03-15 00:26:22','1','2022-03-15 00:26:22',_binary '\0'),(1154,20,'S3 对象存储','20','infra_file_storage',0,'default','',NULL,'1','2022-03-15 00:26:31','1','2022-03-15 00:26:45',_binary '\0'),(1155,103,'短信登录','103','system_login_type',0,'default','',NULL,'1','2022-05-09 23:57:58','1','2022-05-09 23:58:09',_binary '\0'),(1156,1,'password','password','system_oauth2_grant_type',0,'default','','密码模式','1','2022-05-12 00:22:05','1','2022-05-11 16:26:01',_binary '\0'),(1157,2,'authorization_code','authorization_code','system_oauth2_grant_type',0,'primary','','授权码模式','1','2022-05-12 00:22:59','1','2022-05-11 16:26:02',_binary '\0'),(1158,3,'implicit','implicit','system_oauth2_grant_type',0,'success','','简化模式','1','2022-05-12 00:23:40','1','2022-05-11 16:26:05',_binary '\0'),(1159,4,'client_credentials','client_credentials','system_oauth2_grant_type',0,'default','','客户端模式','1','2022-05-12 00:23:51','1','2022-05-11 16:26:08',_binary '\0'),(1160,5,'refresh_token','refresh_token','system_oauth2_grant_type',0,'info','','刷新模式','1','2022-05-12 00:24:02','1','2022-05-11 16:26:11',_binary '\0'),(1194,10,'微信小程序','10','terminal',0,'default','','终端 - 微信小程序','1','2022-12-10 10:51:11','1','2022-12-10 10:51:57',_binary '\0'),(1195,20,'H5 网页','20','terminal',0,'default','','终端 - H5 网页','1','2022-12-10 10:51:30','1','2022-12-10 10:51:59',_binary '\0'),(1196,11,'微信公众号','11','terminal',0,'default','','终端 - 微信公众号','1','2022-12-10 10:54:16','1','2022-12-10 10:52:01',_binary '\0'),(1197,31,'苹果 App','31','terminal',0,'default','','终端 - 苹果 App','1','2022-12-10 10:54:42','1','2022-12-10 10:52:18',_binary '\0'),(1198,32,'安卓 App','32','terminal',0,'default','','终端 - 安卓 App','1','2022-12-10 10:55:02','1','2022-12-10 10:59:17',_binary '\0'),(1223,0,'初始化','0','system_mail_send_status',0,'primary','','邮件发送状态 - 初始化\n','1','2023-01-26 09:53:49','1','2023-01-26 16:36:14',_binary '\0'),(1224,10,'发送成功','10','system_mail_send_status',0,'success','','邮件发送状态 - 发送成功','1','2023-01-26 09:54:28','1','2023-01-26 16:36:22',_binary '\0'),(1225,20,'发送失败','20','system_mail_send_status',0,'danger','','邮件发送状态 - 发送失败','1','2023-01-26 09:54:50','1','2023-01-26 16:36:26',_binary '\0'),(1226,30,'不发送','30','system_mail_send_status',0,'info','','邮件发送状态 -  不发送','1','2023-01-26 09:55:06','1','2023-01-26 16:36:36',_binary '\0'),(1227,1,'通知公告','1','system_notify_template_type',0,'primary','','站内信模版的类型 - 通知公告','1','2023-01-28 10:35:59','1','2023-01-28 10:35:59',_binary '\0'),(1228,2,'系统消息','2','system_notify_template_type',0,'success','','站内信模版的类型 - 系统消息','1','2023-01-28 10:36:20','1','2023-01-28 10:36:25',_binary '\0'),(1231,10,'Vue2 Element UI 标准模版','10','infra_codegen_front_type',0,'','','','1','2023-04-13 00:03:55','1','2023-04-13 00:03:55',_binary '\0'),(1232,20,'Vue3 Element Plus 标准模版','20','infra_codegen_front_type',0,'','','','1','2023-04-13 00:04:08','1','2023-04-13 00:04:08',_binary '\0'),(1234,30,'Vben2.0 Ant Design Schema 模版','30','infra_codegen_front_type',1,'','','','1','2023-04-13 00:04:26','1','2025-07-27 10:55:14',_binary '\0'),(1435,10,'Gitee','10','system_social_type',0,'','','','1','2023-11-04 13:04:42','1','2023-11-04 13:04:42',_binary '\0'),(1436,20,'钉钉','20','system_social_type',0,'','','','1','2023-11-04 13:04:54','1','2023-11-04 13:04:54',_binary '\0'),(1437,30,'企业微信','30','system_social_type',0,'','','','1','2023-11-04 13:05:09','1','2023-11-04 13:05:09',_binary '\0'),(1438,31,'微信公众平台','31','system_social_type',0,'','','','1','2023-11-04 13:05:18','1','2023-11-04 13:05:18',_binary '\0'),(1439,32,'微信开放平台','32','system_social_type',0,'','','','1','2023-11-04 13:05:30','1','2023-11-04 13:05:30',_binary '\0'),(1440,34,'微信小程序','34','system_social_type',0,'','','','1','2023-11-04 13:05:38','1','2023-11-04 13:07:16',_binary '\0'),(1443,15,'子表','15','infra_codegen_template_type',0,'default','','','1','2023-11-13 23:06:16','1','2023-11-13 23:06:16',_binary '\0'),(1444,10,'主表（标准模式）','10','infra_codegen_template_type',0,'default','','','1','2023-11-14 12:32:49','1','2023-11-14 12:32:49',_binary '\0'),(1445,11,'主表（ERP 模式）','11','infra_codegen_template_type',0,'default','','','1','2023-11-14 12:33:05','1','2023-11-14 12:33:05',_binary '\0'),(1446,12,'主表（内嵌模式）','12','infra_codegen_template_type',0,'','','','1','2023-11-14 12:33:31','1','2023-11-14 12:33:31',_binary '\0'),(1529,1,'天','1','date_interval',0,'','','','1','2024-03-29 22:50:26','1','2024-03-29 22:50:26',_binary '\0'),(1530,2,'周','2','date_interval',0,'','','','1','2024-03-29 22:50:36','1','2024-03-29 22:50:36',_binary '\0'),(1531,3,'月','3','date_interval',0,'','','','1','2024-03-29 22:50:46','1','2024-03-29 22:50:54',_binary '\0'),(1532,4,'季度','4','date_interval',0,'','','','1','2024-03-29 22:51:01','1','2024-03-29 22:51:01',_binary '\0'),(1533,5,'年','5','date_interval',0,'','','','1','2024-03-29 22:51:07','1','2024-03-29 22:51:07',_binary '\0'),(1586,2,'腾讯云','TENCENT','system_sms_channel_code',0,'','','','1','2024-07-22 22:23:16','1','2024-07-22 22:23:16',_binary '\0'),(1587,3,'华为云','HUAWEI','system_sms_channel_code',0,'','','','1','2024-07-22 22:23:46','1','2024-07-22 22:23:53',_binary '\0'),(1591,4,'七牛云','QINIU','system_sms_channel_code',0,'','','','1','2024-08-31 08:45:03','1','2024-08-31 08:45:24',_binary '\0'),(3001,40,'Vben5.0 Ant Design Schema 模版','40','infra_codegen_front_type',0,'','',NULL,'1','2025-04-23 21:47:47','1','2025-09-04 23:25:12',_binary '\0'),(3031,41,'Vben5.0 Ant Design 标准模版','41','infra_codegen_front_type',0,'','','','1','2025-09-04 23:26:07','1','2025-09-04 23:26:07',_binary '\0'),(3032,50,'Vben5.0 Element Plus Schema 模版','50','infra_codegen_front_type',0,'','','','1','2025-09-04 23:26:38','1','2025-09-04 23:26:38',_binary '\0'),(3033,51,'Vben5.0 Element Plus 标准模版','51','infra_codegen_front_type',0,'','','','1','2025-09-04 23:26:49','1','2025-09-04 23:26:49',_binary '\0'),(3035,40,'支付宝小程序','40','system_social_type',0,'','','','1','2023-11-04 13:05:38','1','2023-11-04 13:07:16',_binary '\0'),(3036,60,'Admin Uniapp 移动端','60','infra_codegen_front_type',0,'','',NULL,'1','2025-12-16 19:25:51','1','2025-12-17 09:46:15',_binary '\0'),(3054,1,'会议','meeting','schedule_type',0,'default','','会议类型日程','1','2026-10-08 10:15:23','','2026-10-08 10:15:23',_binary '\0'),(3055,2,'任务','task','schedule_type',0,'default','','任务类型日程','1','2026-10-08 10:15:23','','2026-10-08 10:15:23',_binary '\0'),(3056,3,'提醒','reminder','schedule_type',0,'default','','提醒类型日程','1','2026-10-08 10:15:23','','2026-10-08 10:15:23',_binary '\0'),(3057,4,'其他','other','schedule_type',0,'default','','其他类型日程','1','2026-10-08 10:15:23','','2026-10-08 10:15:23',_binary '\0'),(3058,1,'工作','work','schedule_category',0,'default','','工作相关日程','1','2026-10-08 10:15:23','','2026-10-08 10:15:23',_binary '\0'),(3059,2,'个人','personal','schedule_category',0,'default','','个人相关日程','1','2026-10-08 10:15:23','','2026-10-08 10:15:23',_binary '\0'),(3060,3,'重要','important','schedule_category',0,'default','','重要日程','1','2026-10-08 10:15:23','','2026-10-08 10:15:23',_binary '\0'),(3061,4,'其他','other','schedule_category',0,'default','','其他分类日程','1','2026-10-08 10:15:23','','2026-10-08 10:15:23',_binary '\0'),(3062,1,'通知公告','1','system_notice_type',0,'primary','','通知公告','admin','2026-10-08 10:15:23','admin','2026-10-08 10:15:23',_binary '\0'),(3063,2,'公司动态','2','system_notice_type',0,'success','','公司动态','admin','2026-10-08 10:15:23','admin','2026-10-08 10:15:23',_binary '\0'),(3064,3,'行业咨询','3','system_notice_type',0,'info','','行业咨询','admin','2026-10-08 10:15:23','admin','2026-10-08 10:15:23',_binary '\0'),(3065,4,'规章制度','4','system_notice_type',0,'warning','','规章制度','admin','2026-10-08 10:15:23','admin','2026-10-08 10:15:23',_binary '\0');
/*!40000 ALTER TABLE `system_dict_data` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `system_dict_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `system_dict_type` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '字典主键',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '字典名称',
  `type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '字典类型',
  `status` tinyint NOT NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  `deleted_time` datetime DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2044 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='字典类型表';
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `system_dict_type` WRITE;
/*!40000 ALTER TABLE `system_dict_type` DISABLE KEYS */;
INSERT INTO `system_dict_type` VALUES (1,'用户性别','system_user_sex',0,NULL,'admin','2021-01-05 17:03:48','1','2022-05-16 20:29:32',_binary '\0',NULL),(6,'参数类型','infra_config_type',0,NULL,'admin','2021-01-05 17:03:48','','2022-02-01 16:36:54',_binary '\0',NULL),(7,'通知类型','system_notice_type',0,NULL,'admin','2021-01-05 17:03:48','','2022-02-01 16:35:26',_binary '\0',NULL),(9,'操作类型','infra_operate_type',0,NULL,'admin','2021-01-05 17:03:48','1','2024-03-14 12:44:01',_binary '\0',NULL),(10,'系统状态','common_status',0,NULL,'admin','2021-01-05 17:03:48','','2022-02-01 16:21:28',_binary '\0',NULL),(11,'Boolean 是否类型','infra_boolean_string',0,'boolean 转是否','','2021-01-19 03:20:08','','2022-02-01 16:37:10',_binary '\0',NULL),(104,'登陆结果','system_login_result',0,'登陆结果','','2021-01-18 06:17:11','','2022-02-01 16:36:00',_binary '\0',NULL),(106,'代码生成模板类型','infra_codegen_template_type',0,NULL,'','2021-02-05 07:08:06','1','2022-05-16 20:26:50',_binary '\0',NULL),(107,'定时任务状态','infra_job_status',0,NULL,'','2021-02-07 07:44:16','','2022-02-01 16:51:11',_binary '\0',NULL),(108,'定时任务日志状态','infra_job_log_status',0,NULL,'','2021-02-08 10:03:51','','2022-02-01 16:50:43',_binary '\0',NULL),(109,'用户类型','user_type',0,NULL,'','2021-02-26 00:15:51','','2021-02-26 00:15:51',_binary '\0',NULL),(110,'API 异常数据的处理状态','infra_api_error_log_process_status',0,NULL,'','2021-02-26 07:07:01','','2022-02-01 16:50:53',_binary '\0',NULL),(111,'短信渠道编码','system_sms_channel_code',0,NULL,'1','2021-04-05 01:04:50','1','2022-02-16 02:09:08',_binary '\0',NULL),(112,'短信模板的类型','system_sms_template_type',0,NULL,'1','2021-04-05 21:50:43','1','2022-02-01 16:35:06',_binary '\0',NULL),(113,'短信发送状态','system_sms_send_status',0,NULL,'1','2021-04-11 20:18:03','1','2022-02-01 16:35:09',_binary '\0',NULL),(114,'短信接收状态','system_sms_receive_status',0,NULL,'1','2021-04-11 20:27:14','1','2022-02-01 16:35:14',_binary '\0',NULL),(116,'登陆日志的类型','system_login_type',0,'登陆日志的类型','1','2021-10-06 00:50:46','1','2022-02-01 16:35:56',_binary '\0',NULL),(144,'代码生成的场景枚举','infra_codegen_scene',0,'代码生成的场景枚举','1','2022-02-02 13:14:45','1','2022-03-10 16:33:46',_binary '\0',NULL),(145,'角色类型','system_role_type',0,'角色类型','1','2022-02-16 13:01:46','1','2022-02-16 13:01:46',_binary '\0',NULL),(146,'文件存储器','infra_file_storage',0,'文件存储器','1','2022-03-15 00:24:38','1','2022-03-15 00:24:38',_binary '\0',NULL),(147,'OAuth 2.0 授权类型','system_oauth2_grant_type',0,'OAuth 2.0 授权类型（模式）','1','2022-05-12 00:20:52','1','2022-05-11 16:25:49',_binary '\0',NULL),(160,'终端','terminal',0,'终端','1','2022-12-10 10:50:50','1','2022-12-10 10:53:11',_binary '\0',NULL),(166,'邮件发送状态','system_mail_send_status',0,'邮件发送状态','1','2023-01-26 09:53:13','1','2023-01-26 09:53:13',_binary '\0','1970-01-01 00:00:00'),(167,'站内信模版的类型','system_notify_template_type',0,'站内信模版的类型','1','2023-01-28 10:35:10','1','2023-01-28 10:35:10',_binary '\0','1970-01-01 00:00:00'),(168,'代码生成的前端类型','infra_codegen_front_type',0,'','1','2023-04-12 23:57:52','1','2023-04-12 23:57:52',_binary '\0','1970-01-01 00:00:00'),(601,'社交类型','system_social_type',0,'','1','2023-11-04 13:03:54','1','2023-11-04 13:03:54',_binary '\0','1970-01-01 00:00:00'),(616,'时间间隔','date_interval',0,'','1','2024-03-29 22:50:09','1','2024-03-29 22:50:09',_binary '\0','1970-01-01 00:00:00'),(2012,'日程类型','schedule_type',0,'日程类型：会议、任务、提醒等','1','2026-10-08 10:15:23','','2026-10-08 10:15:23',_binary '\0',NULL),(2013,'日程分类','schedule_category',0,'日程分类：工作、个人、重要等','1','2026-10-08 10:15:23','','2026-10-08 10:15:23',_binary '\0',NULL);
/*!40000 ALTER TABLE `system_dict_type` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `system_home_app_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `system_home_app_config` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '应用ID',
  `menu_id` bigint NOT NULL COMMENT '关联菜单ID（来自system_menu表）',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '应用名称',
  `icon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '应用图标（支持iconify图标名称或图片URL）',
  `color` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '图标颜色（十六进制颜色值）',
  `description` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '应用描述',
  `sort` int NOT NULL DEFAULT '0' COMMENT '排序（数字越小越靠前）',
  `status` tinyint NOT NULL DEFAULT '0' COMMENT '状态（0=启用 1=禁用）',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户ID',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_menu_id` (`menu_id`) USING BTREE COMMENT '菜单ID索引',
  KEY `idx_sort` (`sort`) USING BTREE COMMENT '排序索引',
  KEY `idx_status` (`status`) USING BTREE COMMENT '状态索引'
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='系统级应用配置表';
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `system_home_app_config` WRITE;
/*!40000 ALTER TABLE `system_home_app_config` DISABLE KEYS */;
INSERT INTO `system_home_app_config` VALUES (1,1,'组织管理','carbon:collaborate','#1890FF','管理组织架构、部门和员工',1,0,'admin','2026-10-08 10:15:22','','2026-10-08 10:15:22',_binary '\0',1),(2,2,'权限配置','carbon:user-role','#52C41A','配置角色、菜单和权限',2,0,'admin','2026-10-08 10:15:22','','2026-10-08 10:15:22',_binary '\0',1),(5,5,'系统设置','carbon:settings','#13C2C2','系统参数和配置管理',5,0,'admin','2026-10-08 10:15:22','','2026-10-08 10:15:22',_binary '\0',1),(6,6,'消息中心','carbon:notification','#EB2F96','查看系统通知和消息',6,0,'admin','2026-10-08 10:15:22','','2026-10-08 10:15:22',_binary '\0',1);
/*!40000 ALTER TABLE `system_home_app_config` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `system_home_app_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `system_home_app_user` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '用户应用ID',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `menu_id` bigint NOT NULL COMMENT '关联菜单ID（来自system_menu表）',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '自定义应用名称（为空则使用菜单名称）',
  `icon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '自定义图标（为空则使用菜单图标）',
  `color` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '自定义图标颜色',
  `sort` int NOT NULL DEFAULT '0' COMMENT '排序（数字越小越靠前）',
  `status` tinyint NOT NULL DEFAULT '0' COMMENT '状态（0=显示 1=隐藏）',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户ID',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uk_user_menu` (`user_id`,`menu_id`,`deleted`) USING BTREE COMMENT '用户菜单唯一索引',
  KEY `idx_user_id` (`user_id`) USING BTREE COMMENT '用户ID索引',
  KEY `idx_menu_id` (`menu_id`) USING BTREE COMMENT '菜单ID索引',
  KEY `idx_sort` (`sort`) USING BTREE COMMENT '排序索引'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户级应用配置表';
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `system_home_app_user` WRITE;
/*!40000 ALTER TABLE `system_home_app_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `system_home_app_user` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `system_home_component`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `system_home_component` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '组件ID',
  `category_id` bigint NOT NULL COMMENT '分类ID',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '组件名称',
  `code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '组件编码',
  `component_path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '组件路径',
  `description` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '组件描述',
  `preview_image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '预览图',
  `default_width` int NOT NULL DEFAULT '12' COMMENT '默认宽度（网格列数1-24）',
  `default_height` int NOT NULL DEFAULT '4' COMMENT '默认高度（网格行数）',
  `config_schema` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '配置Schema（JSON格式）',
  `status` tinyint NOT NULL DEFAULT '1' COMMENT '状态（0停用 1启用）',
  `sort` int NOT NULL DEFAULT '0' COMMENT '排序',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_code` (`code`,`deleted`) USING BTREE,
  KEY `idx_category_id` (`category_id`,`deleted`) USING BTREE,
  KEY `idx_tenant_id` (`tenant_id`,`deleted`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='首页组件定义表';
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `system_home_component` WRITE;
/*!40000 ALTER TABLE `system_home_component` DISABLE KEYS */;
INSERT INTO `system_home_component` VALUES (1,1,'访问统计','analytics_visits','dashboard/home/components/statistics/analytics-visits.vue','展示网站访问数据统计卡片',NULL,3,2,'{\"properties\": [{\"key\": \"showTitle\", \"type\": \"boolean\", \"label\": \"显示标题\", \"default\": true, \"required\": false}, {\"key\": \"title\", \"type\": \"string\", \"label\": \"标题文本\", \"default\": \"访问统计\", \"required\": false}, {\"key\": \"paddingTop\", \"max\": 50, \"min\": 0, \"type\": \"number\", \"label\": \"上内边距(px)\", \"default\": 0, \"required\": false}, {\"key\": \"paddingRight\", \"max\": 50, \"min\": 0, \"type\": \"number\", \"label\": \"右内边距(px)\", \"default\": 0, \"required\": false}, {\"key\": \"paddingBottom\", \"max\": 50, \"min\": 0, \"type\": \"number\", \"label\": \"下内边距(px)\", \"default\": 0, \"required\": false}, {\"key\": \"paddingLeft\", \"max\": 50, \"min\": 0, \"type\": \"number\", \"label\": \"左内边距(px)\", \"default\": 0, \"required\": false}, {\"key\": \"floatingTitle\", \"type\": \"boolean\", \"label\": \"浮动标题\", \"default\": false, \"required\": false}, {\"key\": \"titleMarginTop\", \"max\": 100, \"min\": 0, \"type\": \"number\", \"label\": \"标题上边距(px)\", \"default\": 8, \"required\": false}, {\"key\": \"titleMarginRight\", \"max\": 100, \"min\": 0, \"type\": \"number\", \"label\": \"标题右边距(px)\", \"default\": 8, \"required\": false}, {\"key\": \"titleMarginBottom\", \"max\": 100, \"min\": 0, \"type\": \"number\", \"label\": \"标题下边距(px)\", \"default\": 0, \"required\": false}, {\"key\": \"titleMarginLeft\", \"max\": 100, \"min\": 0, \"type\": \"number\", \"label\": \"标题左边距(px)\", \"default\": 8, \"required\": false}, {\"key\": \"titleFontSize\", \"max\": 24, \"min\": 10, \"type\": \"number\", \"label\": \"标题文字大小(px)\", \"default\": 12, \"required\": false}, {\"key\": \"titleBold\", \"type\": \"boolean\", \"label\": \"标题文字加粗\", \"default\": false, \"required\": false}, {\"key\": \"titleColor\", \"type\": \"string\", \"label\": \"标题文字颜色\", \"default\": \"#4B5563\", \"required\": false}]}',1,1,'1','2026-10-08 10:15:22','','2026-10-08 10:15:23',_binary '\0',0),(2,2,'访问来源图表','analytics_visits_source','dashboard/home/components/charts/analytics-visits-source.vue','展示访问来源的饼图分析',NULL,6,4,'{\"properties\": [{\"key\": \"showTitle\", \"type\": \"boolean\", \"label\": \"显示标题\", \"default\": true, \"required\": false}, {\"key\": \"title\", \"type\": \"string\", \"label\": \"标题文本\", \"default\": \"访问来源\", \"required\": false}, {\"key\": \"paddingTop\", \"max\": 50, \"min\": 0, \"type\": \"number\", \"label\": \"上内边距(px)\", \"default\": 0, \"required\": false}, {\"key\": \"paddingRight\", \"max\": 50, \"min\": 0, \"type\": \"number\", \"label\": \"右内边距(px)\", \"default\": 0, \"required\": false}, {\"key\": \"paddingBottom\", \"max\": 50, \"min\": 0, \"type\": \"number\", \"label\": \"下内边距(px)\", \"default\": 0, \"required\": false}, {\"key\": \"paddingLeft\", \"max\": 50, \"min\": 0, \"type\": \"number\", \"label\": \"左内边距(px)\", \"default\": 0, \"required\": false}, {\"key\": \"floatingTitle\", \"type\": \"boolean\", \"label\": \"浮动标题\", \"default\": false, \"required\": false}, {\"key\": \"titleMarginTop\", \"max\": 100, \"min\": 0, \"type\": \"number\", \"label\": \"标题上边距(px)\", \"default\": 8, \"required\": false}, {\"key\": \"titleMarginRight\", \"max\": 100, \"min\": 0, \"type\": \"number\", \"label\": \"标题右边距(px)\", \"default\": 8, \"required\": false}, {\"key\": \"titleMarginBottom\", \"max\": 100, \"min\": 0, \"type\": \"number\", \"label\": \"标题下边距(px)\", \"default\": 0, \"required\": false}, {\"key\": \"titleMarginLeft\", \"max\": 100, \"min\": 0, \"type\": \"number\", \"label\": \"标题左边距(px)\", \"default\": 8, \"required\": false}, {\"key\": \"titleFontSize\", \"max\": 24, \"min\": 10, \"type\": \"number\", \"label\": \"标题文字大小(px)\", \"default\": 12, \"required\": false}, {\"key\": \"titleBold\", \"type\": \"boolean\", \"label\": \"标题文字加粗\", \"default\": false, \"required\": false}, {\"key\": \"titleColor\", \"type\": \"string\", \"label\": \"标题文字颜色\", \"default\": \"#4B5563\", \"required\": false}]}',1,1,'1','2026-10-08 10:15:22','','2026-10-08 10:15:23',_binary '\0',0),(3,3,'项目列表','workbench_project','dashboard/home/components/lists/workbench-project.vue','展示项目卡片列表',NULL,6,6,'{\"properties\": [{\"key\": \"showTitle\", \"type\": \"boolean\", \"label\": \"显示标题\", \"default\": true, \"required\": false}, {\"key\": \"title\", \"type\": \"string\", \"label\": \"标题文本\", \"default\": \"项目\", \"required\": false}, {\"key\": \"paddingTop\", \"max\": 50, \"min\": 0, \"type\": \"number\", \"label\": \"上内边距(px)\", \"default\": 0, \"required\": false}, {\"key\": \"paddingRight\", \"max\": 50, \"min\": 0, \"type\": \"number\", \"label\": \"右内边距(px)\", \"default\": 0, \"required\": false}, {\"key\": \"paddingBottom\", \"max\": 50, \"min\": 0, \"type\": \"number\", \"label\": \"下内边距(px)\", \"default\": 0, \"required\": false}, {\"key\": \"paddingLeft\", \"max\": 50, \"min\": 0, \"type\": \"number\", \"label\": \"左内边距(px)\", \"default\": 0, \"required\": false}, {\"key\": \"floatingTitle\", \"type\": \"boolean\", \"label\": \"浮动标题\", \"default\": false, \"required\": false}, {\"key\": \"titleMarginTop\", \"max\": 100, \"min\": 0, \"type\": \"number\", \"label\": \"标题上边距(px)\", \"default\": 8, \"required\": false}, {\"key\": \"titleMarginRight\", \"max\": 100, \"min\": 0, \"type\": \"number\", \"label\": \"标题右边距(px)\", \"default\": 8, \"required\": false}, {\"key\": \"titleMarginBottom\", \"max\": 100, \"min\": 0, \"type\": \"number\", \"label\": \"标题下边距(px)\", \"default\": 0, \"required\": false}, {\"key\": \"titleMarginLeft\", \"max\": 100, \"min\": 0, \"type\": \"number\", \"label\": \"标题左边距(px)\", \"default\": 8, \"required\": false}, {\"key\": \"titleFontSize\", \"max\": 24, \"min\": 10, \"type\": \"number\", \"label\": \"标题文字大小(px)\", \"default\": 12, \"required\": false}, {\"key\": \"titleBold\", \"type\": \"boolean\", \"label\": \"标题文字加粗\", \"default\": false, \"required\": false}, {\"key\": \"titleColor\", \"type\": \"string\", \"label\": \"标题文字颜色\", \"default\": \"#4B5563\", \"required\": false}]}',1,1,'1','2026-10-08 10:15:22','','2026-10-08 10:15:23',_binary '\0',0),(4,4,'快捷导航','workbench_quick_nav','dashboard/home/components/navigation/workbench-quick-nav.vue','展示快捷导航入口',NULL,6,3,'{\"properties\": [{\"key\": \"showTitle\", \"type\": \"boolean\", \"label\": \"显示标题\", \"default\": true, \"required\": false}, {\"key\": \"title\", \"type\": \"string\", \"label\": \"标题文本\", \"default\": \"快捷导航\", \"required\": false}, {\"key\": \"paddingTop\", \"max\": 50, \"min\": 0, \"type\": \"number\", \"label\": \"上内边距(px)\", \"default\": 0, \"required\": false}, {\"key\": \"paddingRight\", \"max\": 50, \"min\": 0, \"type\": \"number\", \"label\": \"右内边距(px)\", \"default\": 0, \"required\": false}, {\"key\": \"paddingBottom\", \"max\": 50, \"min\": 0, \"type\": \"number\", \"label\": \"下内边距(px)\", \"default\": 0, \"required\": false}, {\"key\": \"paddingLeft\", \"max\": 50, \"min\": 0, \"type\": \"number\", \"label\": \"左内边距(px)\", \"default\": 0, \"required\": false}, {\"key\": \"floatingTitle\", \"type\": \"boolean\", \"label\": \"浮动标题\", \"default\": false, \"required\": false}, {\"key\": \"titleMarginTop\", \"max\": 100, \"min\": 0, \"type\": \"number\", \"label\": \"标题上边距(px)\", \"default\": 8, \"required\": false}, {\"key\": \"titleMarginRight\", \"max\": 100, \"min\": 0, \"type\": \"number\", \"label\": \"标题右边距(px)\", \"default\": 8, \"required\": false}, {\"key\": \"titleMarginBottom\", \"max\": 100, \"min\": 0, \"type\": \"number\", \"label\": \"标题下边距(px)\", \"default\": 0, \"required\": false}, {\"key\": \"titleMarginLeft\", \"max\": 100, \"min\": 0, \"type\": \"number\", \"label\": \"标题左边距(px)\", \"default\": 8, \"required\": false}, {\"key\": \"titleFontSize\", \"max\": 24, \"min\": 10, \"type\": \"number\", \"label\": \"标题文字大小(px)\", \"default\": 12, \"required\": false}, {\"key\": \"titleBold\", \"type\": \"boolean\", \"label\": \"标题文字加粗\", \"default\": false, \"required\": false}, {\"key\": \"titleColor\", \"type\": \"string\", \"label\": \"标题文字颜色\", \"default\": \"#4B5563\", \"required\": false}]}',1,1,'1','2026-10-08 10:15:22','','2026-10-08 10:15:23',_binary '\0',0),(5,3,'动态列表','workbench_trends','dashboard/home/components/lists/workbench-trends.vue','展示最新动态列表',NULL,6,6,'{\n  \"properties\": [\n    {\n      \"key\": \"showTitle\",\n      \"label\": \"显示标题\",\n      \"type\": \"boolean\",\n      \"default\": true,\n      \"required\": false\n    },\n    {\n      \"key\": \"title\",\n      \"label\": \"标题\",\n      \"type\": \"string\",\n      \"default\": \"最新动态\",\n      \"required\": true\n    },\n    {\n      \"key\": \"titleIcon\",\n      \"label\": \"标题图标\",\n      \"type\": \"icon\",\n      \"default\": \"lucide:activity\",\n      \"required\": false\n    },\n    {\n      \"key\": \"titleIconColor\",\n      \"label\": \"图标颜色\",\n      \"type\": \"color\",\n      \"default\": \"#eb2f96\",\n      \"required\": false\n    }\n  ]\n}',1,2,'1','2026-10-08 10:15:22','','2026-10-08 10:15:22',_binary '\0',0),(20,2,'欢迎组件','workbench_welcome','dashboard/home/components/welcome/workbench-welcome.vue','展示欢迎信息、用户信息和天气，支持和风天气API',NULL,24,4,'{\n    \"properties\": [\n      {\n        \"key\": \"greeting\",\n        \"type\": \"string\",\n        \"label\": \"提示语\",\n        \"default\": \"欢迎回来，开始您的工作吧！\",\n        \"required\": false\n      },\n      {\n        \"key\": \"showWeather\",\n        \"type\": \"boolean\",\n        \"label\": \"显示天气\",\n        \"default\": true,\n        \"required\": false\n      },\n      {\n        \"key\": \"weatherApiKey\",\n        \"type\": \"string\",\n        \"label\": \"和风天气API Key\",\n        \"default\": \"\",\n        \"required\": false\n      },\n      {\n        \"key\": \"paddingTop\",\n        \"type\": \"number\",\n        \"label\": \"内边距-上(px)\",\n        \"default\": 0,\n        \"min\": 0,\n        \"max\": 100,\n        \"required\": false\n      },\n      {\n        \"key\": \"paddingRight\",\n        \"type\": \"number\",\n        \"label\": \"内边距-右(px)\",\n        \"default\": 0,\n        \"min\": 0,\n        \"max\": 100,\n        \"required\": false\n      },\n      {\n        \"key\": \"paddingBottom\",\n        \"type\": \"number\",\n        \"label\": \"内边距-下(px)\",\n        \"default\": 0,\n        \"min\": 0,\n        \"max\": 100,\n        \"required\": false\n      },\n      {\n        \"key\": \"paddingLeft\",\n        \"type\": \"number\",\n        \"label\": \"内边距-左(px)\",\n        \"default\": 0,\n        \"min\": 0,\n        \"max\": 100,\n        \"required\": false\n      },\n      {\n        \"key\": \"marginTop\",\n        \"type\": \"number\",\n        \"label\": \"外边距-上(px)\",\n        \"default\": 0,\n        \"min\": 0,\n        \"max\": 100,\n        \"required\": false\n      },\n      {\n        \"key\": \"marginRight\",\n        \"type\": \"number\",\n        \"label\": \"外边距-右(px)\",\n        \"default\": 0,\n        \"min\": 0,\n        \"max\": 100,\n        \"required\": false\n      },\n      {\n        \"key\": \"marginBottom\",\n        \"type\": \"number\",\n        \"label\": \"外边距-下(px)\",\n        \"default\": 0,\n        \"min\": 0,\n        \"max\": 100,\n        \"required\": false\n      },\n      {\n        \"key\": \"marginLeft\",\n        \"type\": \"number\",\n        \"label\": \"外边距-左(px)\",\n        \"default\": 0,\n        \"min\": 0,\n        \"max\": 100,\n        \"required\": false\n      }\n    ]\n  }',0,5,'1','2026-01-09 16:00:00','','2026-01-09 16:00:00',_binary '\0',1),(21,2,'通知公告','workbench_notice','dashboard/home/components/notice/workbench-notice.vue','展示系统通知公告列表，支持徽章和快速预览',NULL,12,8,'{\n    \"properties\": [\n      {\n        \"key\": \"maxRecordNum\",\n        \"type\": \"number\",\n        \"label\": \"最大显示条数\",\n        \"default\": 10,\n        \"min\": 5,\n        \"max\": 50,\n        \"required\": false\n      },\n      {\n        \"key\": \"showBadge\",\n        \"type\": \"boolean\",\n        \"label\": \"显示未读徽章\",\n        \"default\": true,\n        \"required\": false\n      },\n      {\n        \"key\": \"paddingTop\",\n        \"type\": \"number\",\n        \"label\": \"内边距-上(px)\",\n        \"default\": 0,\n        \"min\": 0,\n        \"max\": 100,\n        \"required\": false\n      },\n      {\n        \"key\": \"paddingRight\",\n        \"type\": \"number\",\n        \"label\": \"内边距-右(px)\",\n        \"default\": 0,\n        \"min\": 0,\n        \"max\": 100,\n        \"required\": false\n      },\n      {\n        \"key\": \"paddingBottom\",\n        \"type\": \"number\",\n        \"label\": \"内边距-下(px)\",\n        \"default\": 0,\n        \"min\": 0,\n        \"max\": 100,\n        \"required\": false\n      },\n      {\n        \"key\": \"paddingLeft\",\n        \"type\": \"number\",\n        \"label\": \"内边距-左(px)\",\n        \"default\": 0,\n        \"min\": 0,\n        \"max\": 100,\n        \"required\": false\n      },\n      {\n        \"key\": \"marginTop\",\n        \"type\": \"number\",\n        \"label\": \"外边距-上(px)\",\n        \"default\": 0,\n        \"min\": 0,\n        \"max\": 100,\n        \"required\": false\n      },\n      {\n        \"key\": \"marginRight\",\n        \"type\": \"number\",\n        \"label\": \"外边距-右(px)\",\n        \"default\": 0,\n        \"min\": 0,\n        \"max\": 100,\n        \"required\": false\n      },\n      {\n        \"key\": \"marginBottom\",\n        \"type\": \"number\",\n        \"label\": \"外边距-下(px)\",\n        \"default\": 0,\n        \"min\": 0,\n        \"max\": 100,\n        \"required\": false\n      },\n      {\n        \"key\": \"marginLeft\",\n        \"type\": \"number\",\n        \"label\": \"外边距-左(px)\",\n        \"default\": 0,\n        \"min\": 0,\n        \"max\": 100,\n        \"required\": false\n      }\n    ]\n  }',0,6,'1','2026-01-09 16:00:00','','2026-01-09 16:00:00',_binary '\0',1),(22,3,'我的日程','workbench_schedule','dashboard/home/components/schedule/workbench-schedule.vue','展示日程日历和待办事项，支持日期选择和日程查看',NULL,12,10,'{\n    \"properties\": [\n      {\n        \"key\": \"title\",\n        \"type\": \"string\",\n        \"label\": \"标题\",\n        \"default\": \"日程待办\",\n        \"required\": true\n      },\n      {\n        \"key\": \"maxRecordNum\",\n        \"type\": \"number\",\n        \"label\": \"最大显示条数\",\n        \"default\": 10,\n        \"min\": 5,\n        \"max\": 50,\n        \"required\": false\n      },\n      {\n        \"key\": \"paddingTop\",\n        \"type\": \"number\",\n        \"label\": \"内边距-上(px)\",\n        \"default\": 16,\n        \"min\": 0,\n        \"max\": 100,\n        \"required\": false\n      },\n      {\n        \"key\": \"paddingRight\",\n        \"type\": \"number\",\n        \"label\": \"内边距-右(px)\",\n        \"default\": 16,\n        \"min\": 0,\n        \"max\": 100,\n        \"required\": false\n      },\n      {\n        \"key\": \"paddingBottom\",\n        \"type\": \"number\",\n        \"label\": \"内边距-下(px)\",\n        \"default\": 16,\n        \"min\": 0,\n        \"max\": 100,\n        \"required\": false\n      },\n      {\n        \"key\": \"paddingLeft\",\n        \"type\": \"number\",\n        \"label\": \"内边距-左(px)\",\n        \"default\": 16,\n        \"min\": 0,\n        \"max\": 100,\n        \"required\": false\n      },\n      {\n        \"key\": \"marginTop\",\n        \"type\": \"number\",\n        \"label\": \"外边距-上(px)\",\n        \"default\": 0,\n        \"min\": 0,\n        \"max\": 100,\n        \"required\": false\n      },\n      {\n        \"key\": \"marginRight\",\n        \"type\": \"number\",\n        \"label\": \"外边距-右(px)\",\n        \"default\": 0,\n        \"min\": 0,\n        \"max\": 100,\n        \"required\": false\n      },\n      {\n        \"key\": \"marginBottom\",\n        \"type\": \"number\",\n        \"label\": \"外边距-下(px)\",\n        \"default\": 0,\n        \"min\": 0,\n        \"max\": 100,\n        \"required\": false\n      },\n      {\n        \"key\": \"marginLeft\",\n        \"type\": \"number\",\n        \"label\": \"外边距-左(px)\",\n        \"default\": 0,\n        \"min\": 0,\n        \"max\": 100,\n        \"required\": false\n      }\n    ]\n  }',1,7,'1','2026-10-08 10:15:22','','2026-10-08 10:15:22',_binary '\0',1),(23,2,'应用中心','workbench_app_center','dashboard/home/components/app-center/workbench-app-center.vue','展示常用应用，支持拖拽排序和个性化配置',NULL,12,8,'{\n    \"properties\": [\n      {\n        \"key\": \"maxAppCount\",\n        \"type\": \"number\",\n        \"label\": \"最大显示应用数\",\n        \"default\": 12,\n        \"min\": 4,\n        \"max\": 24,\n        \"required\": false\n      },\n      {\n        \"key\": \"gridCols\",\n        \"type\": \"number\",\n        \"label\": \"网格列数\",\n        \"default\": 4,\n        \"min\": 2,\n        \"max\": 6,\n        \"required\": false\n      },\n      {\n        \"key\": \"enableDrag\",\n        \"type\": \"boolean\",\n        \"label\": \"启用拖拽排序\",\n        \"default\": true,\n        \"required\": false\n      },\n      {\n        \"key\": \"paddingTop\",\n        \"type\": \"number\",\n        \"label\": \"内边距-上(px)\",\n        \"default\": 0,\n        \"min\": 0,\n        \"max\": 100,\n        \"required\": false\n      },\n      {\n        \"key\": \"paddingRight\",\n        \"type\": \"number\",\n        \"label\": \"内边距-右(px)\",\n        \"default\": 0,\n        \"min\": 0,\n        \"max\": 100,\n        \"required\": false\n      },\n      {\n        \"key\": \"paddingBottom\",\n        \"type\": \"number\",\n        \"label\": \"内边距-下(px)\",\n        \"default\": 0,\n        \"min\": 0,\n        \"max\": 100,\n        \"required\": false\n      },\n      {\n        \"key\": \"paddingLeft\",\n        \"type\": \"number\",\n        \"label\": \"内边距-左(px)\",\n        \"default\": 0,\n        \"min\": 0,\n        \"max\": 100,\n        \"required\": false\n      },\n      {\n        \"key\": \"marginTop\",\n        \"type\": \"number\",\n        \"label\": \"外边距-上(px)\",\n        \"default\": 0,\n        \"min\": 0,\n        \"max\": 100,\n        \"required\": false\n      },\n      {\n        \"key\": \"marginRight\",\n        \"type\": \"number\",\n        \"label\": \"外边距-右(px)\",\n        \"default\": 0,\n        \"min\": 0,\n        \"max\": 100,\n        \"required\": false\n      },\n      {\n        \"key\": \"marginBottom\",\n        \"type\": \"number\",\n        \"label\": \"外边距-下(px)\",\n        \"default\": 0,\n        \"min\": 0,\n        \"max\": 100,\n        \"required\": false\n      },\n      {\n        \"key\": \"marginLeft\",\n        \"type\": \"number\",\n        \"label\": \"外边距-左(px)\",\n        \"default\": 0,\n        \"min\": 0,\n        \"max\": 100,\n        \"required\": false\n      }\n    ]\n  }',0,7,'1','2026-01-09 16:00:00','','2026-01-09 16:00:00',_binary '\0',1);
/*!40000 ALTER TABLE `system_home_component` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `system_home_component_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `system_home_component_category` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '分类ID',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '分类名称',
  `code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '分类编码',
  `icon` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '分类图标',
  `sort` int NOT NULL DEFAULT '0' COMMENT '排序',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_code` (`code`,`deleted`) USING BTREE,
  KEY `idx_tenant_id` (`tenant_id`,`deleted`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='首页组件分类表';
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `system_home_component_category` WRITE;
/*!40000 ALTER TABLE `system_home_component_category` DISABLE KEYS */;
INSERT INTO `system_home_component_category` VALUES (1,'统计卡片','statistics','lucide:bar-chart-2',1,'1','2026-10-08 10:15:22','','2026-10-08 10:15:22',_binary '\0',0),(2,'图表组件','chart','lucide:pie-chart',2,'1','2026-10-08 10:15:22','','2026-10-08 10:15:22',_binary '\0',0),(3,'列表组件','list','lucide:list',3,'1','2026-10-08 10:15:22','','2026-10-08 10:15:22',_binary '\0',0),(4,'快捷导航','navigation','lucide:compass',4,'1','2026-10-08 10:15:22','','2026-10-08 10:15:22',_binary '\0',0),(5,'其他组件','other','lucide:box',99,'1','2026-10-08 10:15:22','','2026-10-08 10:15:22',_binary '\0',0);
/*!40000 ALTER TABLE `system_home_component_category` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `system_home_page`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `system_home_page` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '首页ID',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '首页名称',
  `code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '首页编码',
  `description` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '首页描述',
  `preview_image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '预览图',
  `is_default` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否默认首页',
  `status` tinyint NOT NULL DEFAULT '1' COMMENT '状态（0停用 1启用）',
  `sort` int NOT NULL DEFAULT '0' COMMENT '排序',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_code` (`code`,`deleted`) USING BTREE,
  KEY `idx_is_default` (`is_default`,`deleted`) USING BTREE,
  KEY `idx_tenant_id` (`tenant_id`,`deleted`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='首页配置表';
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `system_home_page` WRITE;
/*!40000 ALTER TABLE `system_home_page` DISABLE KEYS */;
INSERT INTO `system_home_page` VALUES (1,'默认工作台','default_workspace','系统默认首页',NULL,1,1,0,'1','2026-10-08 10:15:22','','2026-10-08 10:15:22',_binary '\0',0);
/*!40000 ALTER TABLE `system_home_page` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `system_home_page_layout`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `system_home_page_layout` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '布局ID',
  `page_id` bigint NOT NULL COMMENT '首页ID',
  `component_code` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '组件编码',
  `position_x` int NOT NULL DEFAULT '0' COMMENT 'X坐标',
  `position_y` int NOT NULL DEFAULT '0' COMMENT 'Y坐标',
  `width` int NOT NULL DEFAULT '6' COMMENT '宽度（栅格数）',
  `height` int NOT NULL DEFAULT '4' COMMENT '高度（栅格数）',
  `config` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '组件配置（JSON）',
  `sort` int NOT NULL DEFAULT '0' COMMENT '排序',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`),
  KEY `idx_page_id` (`page_id`,`deleted`) USING BTREE,
  KEY `idx_tenant_id` (`tenant_id`,`deleted`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='首页布局配置表';
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `system_home_page_layout` WRITE;
/*!40000 ALTER TABLE `system_home_page_layout` DISABLE KEYS */;
/*!40000 ALTER TABLE `system_home_page_layout` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `system_login_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `system_login_log` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '访问ID',
  `log_type` bigint NOT NULL COMMENT '日志类型',
  `trace_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '链路追踪编号',
  `user_id` bigint NOT NULL DEFAULT '0' COMMENT '用户编号',
  `user_type` tinyint NOT NULL DEFAULT '0' COMMENT '用户类型',
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '用户账号',
  `result` tinyint NOT NULL COMMENT '登陆结果',
  `user_ip` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户 IP',
  `user_agent` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '浏览器 UA',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4449 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='系统访问记录';
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `system_login_log` WRITE;
/*!40000 ALTER TABLE `system_login_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `system_login_log` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `system_mail_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `system_mail_account` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `mail` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '邮箱',
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户名',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '密码',
  `host` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'SMTP 服务器域名',
  `port` int NOT NULL COMMENT 'SMTP 服务器端口',
  `ssl_enable` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否开启 SSL',
  `starttls_enable` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否开启 STARTTLS',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='邮箱账号表';
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `system_mail_account` WRITE;
/*!40000 ALTER TABLE `system_mail_account` DISABLE KEYS */;
INSERT INTO `system_mail_account` VALUES (1,'7684413@qq.com','7684413@qq.com','1234576','127.0.0.1',8080,_binary '\0',_binary '\0','1','2023-01-25 17:39:52','1','2025-04-04 16:34:40',_binary '\0'),(2,'ydym_test@163.com','ydym_test@163.com','WBZTEINMIFVRYSOE','smtp.163.com',465,_binary '',_binary '\0','1','2023-01-26 01:26:03','1','2025-12-20 18:09:32',_binary '\0'),(3,'76854114@qq.com','3335','11234','yunai1.cn',466,_binary '\0',_binary '\0','1','2023-01-27 15:06:38','1','2023-01-27 07:08:36',_binary ''),(4,'7685413x@qq.com','2','3','4',5,_binary '',_binary '\0','1','2023-04-12 23:05:06','1','2023-04-12 15:05:11',_binary '');
/*!40000 ALTER TABLE `system_mail_account` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `system_mail_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `system_mail_log` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `user_id` bigint DEFAULT NULL COMMENT '用户编号',
  `user_type` tinyint DEFAULT NULL COMMENT '用户类型',
  `to_mails` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '接收邮箱地址',
  `cc_mails` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '抄送邮箱地址',
  `bcc_mails` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '密送邮箱地址',
  `account_id` bigint NOT NULL COMMENT '邮箱账号编号',
  `from_mail` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '发送邮箱地址',
  `template_id` bigint NOT NULL COMMENT '模板编号',
  `template_code` varchar(63) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '模板编码',
  `template_nickname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '模版发送人名称',
  `template_title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '邮件标题',
  `template_content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '邮件内容',
  `template_params` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '邮件参数',
  `send_status` tinyint NOT NULL DEFAULT '0' COMMENT '发送状态',
  `send_time` datetime DEFAULT NULL COMMENT '发送时间',
  `send_message_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '发送返回的消息 ID',
  `send_exception` varchar(4096) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '发送异常',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=368 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='邮件日志表';
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `system_mail_log` WRITE;
/*!40000 ALTER TABLE `system_mail_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `system_mail_log` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `system_mail_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `system_mail_template` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `name` varchar(63) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '模板名称',
  `code` varchar(63) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '模板编码',
  `account_id` bigint NOT NULL COMMENT '发送的邮箱账号编号',
  `nickname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '发送人名称',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '模板标题',
  `content` varchar(10240) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '模板内容',
  `params` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '参数数组',
  `status` tinyint NOT NULL COMMENT '开启状态',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='邮件模版表';
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `system_mail_template` WRITE;
/*!40000 ALTER TABLE `system_mail_template` DISABLE KEYS */;
INSERT INTO `system_mail_template` VALUES (13,'后台用户短信登录','admin-sms-login',1,'奥特曼','你猜我猜','<p>您的验证码是{code}，名字是{name}</p>','[\"code\",\"name\"]',0,'3','1','2021-10-11 08:10:00','1','2023-12-02 19:51:14',_binary '\0'),(14,'测试模版','test_01',2,'芋艿','一个标题','<p>你是 {key01} 吗？</p><p><br></p><p>是的话，赶紧 {key02} 一下！</p>','[\"key01\",\"key02\"]',0,NULL,'1','2023-01-26 01:27:40','1','2025-07-26 21:48:45',_binary '\0'),(15,'3','2',2,'7','4','<p>45</p>','[]',1,'80','1','2023-01-27 15:50:35','1','2025-07-26 21:47:49',_binary '');
/*!40000 ALTER TABLE `system_mail_template` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `system_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `system_menu` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '菜单ID',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '菜单名称',
  `permission` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '权限标识',
  `type` tinyint NOT NULL COMMENT '菜单类型',
  `sort` int NOT NULL DEFAULT '0' COMMENT '显示顺序',
  `parent_id` bigint NOT NULL DEFAULT '0' COMMENT '父菜单ID',
  `path` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '路由地址',
  `icon` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '#' COMMENT '菜单图标',
  `component` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '组件路径',
  `component_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '组件名',
  `status` tinyint NOT NULL DEFAULT '0' COMMENT '菜单状态',
  `visible` bit(1) NOT NULL DEFAULT b'1' COMMENT '是否可见',
  `keep_alive` bit(1) NOT NULL DEFAULT b'1' COMMENT '是否缓存',
  `always_show` bit(1) NOT NULL DEFAULT b'1' COMMENT '是否总是显示',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6277 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='菜单权限表';
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `system_menu` WRITE;
/*!40000 ALTER TABLE `system_menu` DISABLE KEYS */;
INSERT INTO `system_menu` VALUES (1,'系统管理','',1,10,0,'/system','ep:tools',NULL,NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','1','2025-03-15 21:30:27',_binary '\0'),(2,'基础设施','',1,20,0,'/infra','ep:monitor',NULL,NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','1','2024-03-01 08:28:40',_binary '\0'),(100,'用户管理','system:user:list',2,1,1,'user','ep:avatar','system/user/index','SystemUser',0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','1','2026-01-01 18:43:01',_binary '\0'),(101,'角色管理','',2,2,1,'role','ep:user','system/role/index','SystemRole',0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','1','2026-01-05 19:30:33',_binary '\0'),(102,'菜单管理','',2,3,1,'menu','ep:menu','system/menu/index','SystemMenu',0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','1','2024-02-29 01:03:50',_binary '\0'),(103,'部门管理','',2,4,1,'dept','fa:address-card','system/dept/index','SystemDept',0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','1','2024-02-29 01:06:28',_binary '\0'),(104,'岗位管理','',2,5,1,'post','fa:address-book-o','system/post/index','SystemPost',0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','1','2024-02-29 01:06:39',_binary '\0'),(105,'字典管理','',2,6,1,'dict','ep:collection','system/dict/index','SystemDictType',0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','1','2024-02-29 01:07:12',_binary '\0'),(106,'配置管理','',2,8,2,'config','fa:connectdevelop','infra/config/index','InfraConfig',0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','1','2024-04-23 00:02:45',_binary '\0'),(107,'通知公告','',2,4,2739,'notice','ep:takeaway-box','system/notice/index','SystemNotice',0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','1','2024-04-22 23:56:17',_binary '\0'),(108,'审计日志','',1,9,1,'log','ep:document-copy','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','1','2024-02-29 01:08:30',_binary '\0'),(109,'令牌管理','',2,2,1261,'token','fa:key','system/oauth2/token/index','SystemTokenClient',0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','1','2024-02-29 01:13:48',_binary '\0'),(111,'MySQL 监控','',2,1,2740,'druid','fa-solid:box','infra/druid/index','InfraDruid',0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','1','2024-04-23 00:05:58',_binary '\0'),(112,'Java 监控','',2,3,2740,'admin-server','ep:coffee-cup','infra/server/index','InfraAdminServer',0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','1','2024-04-23 00:06:57',_binary '\0'),(113,'Redis 监控','',2,2,2740,'redis','fa:reddit-square','infra/redis/index','InfraRedis',0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','1','2024-04-23 00:06:09',_binary '\0'),(114,'表单构建','infra:build:list',2,2,2,'build','fa:wpforms','infra/build/index','InfraBuild',0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','1','2024-02-29 08:51:35',_binary '\0'),(115,'代码生成','infra:codegen:query',2,1,2,'codegen','ep:document-copy','infra/codegen/index','InfraCodegen',0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','1','2024-02-29 08:51:06',_binary '\0'),(116,'API 接口','infra:swagger:list',2,3,2,'swagger','fa:fighter-jet','infra/swagger/index','InfraSwagger',0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','1','2024-04-23 00:01:24',_binary '\0'),(500,'操作日志','',2,1,108,'operate-log','ep:position','system/operatelog/index','SystemOperateLog',0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','1','2024-02-29 01:09:59',_binary '\0'),(501,'登录日志','',2,2,108,'login-log','ep:promotion','system/loginlog/index','SystemLoginLog',0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','1','2024-02-29 01:10:29',_binary '\0'),(1001,'用户查询','system:user:query',3,1,100,'','#','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','','2022-04-20 17:03:10',_binary '\0'),(1002,'用户新增','system:user:create',3,2,100,'','','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','1','2022-04-20 17:03:10',_binary '\0'),(1003,'用户修改','system:user:update',3,3,100,'','','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','1','2022-04-20 17:03:10',_binary '\0'),(1004,'用户删除','system:user:delete',3,4,100,'','','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','1','2022-04-20 17:03:10',_binary '\0'),(1005,'用户导出','system:user:export',3,5,100,'','#','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','','2022-04-20 17:03:10',_binary '\0'),(1006,'用户导入','system:user:import',3,6,100,'','#','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','','2022-04-20 17:03:10',_binary '\0'),(1007,'重置密码','system:user:update-password',3,7,100,'','','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','1','2022-04-20 17:03:10',_binary '\0'),(1008,'角色查询','system:role:query',3,1,101,'','#','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','','2022-04-20 17:03:10',_binary '\0'),(1009,'角色新增','system:role:create',3,2,101,'','','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','1','2022-04-20 17:03:10',_binary '\0'),(1010,'角色修改','system:role:update',3,3,101,'','','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','1','2022-04-20 17:03:10',_binary '\0'),(1011,'角色删除','system:role:delete',3,4,101,'','','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','1','2022-04-20 17:03:10',_binary '\0'),(1012,'角色导出','system:role:export',3,5,101,'','#','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','','2022-04-20 17:03:10',_binary '\0'),(1013,'菜单查询','system:menu:query',3,1,102,'','#','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','','2022-04-20 17:03:10',_binary '\0'),(1014,'菜单新增','system:menu:create',3,2,102,'','#','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','','2022-04-20 17:03:10',_binary '\0'),(1015,'菜单修改','system:menu:update',3,3,102,'','#','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','','2022-04-20 17:03:10',_binary '\0'),(1016,'菜单删除','system:menu:delete',3,4,102,'','#','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','','2022-04-20 17:03:10',_binary '\0'),(1017,'部门查询','system:dept:query',3,1,103,'','#','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','','2022-04-20 17:03:10',_binary '\0'),(1018,'部门新增','system:dept:create',3,2,103,'','','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','1','2022-04-20 17:03:10',_binary '\0'),(1019,'部门修改','system:dept:update',3,3,103,'','','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','1','2022-04-20 17:03:10',_binary '\0'),(1020,'部门删除','system:dept:delete',3,4,103,'','','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','1','2022-04-20 17:03:10',_binary '\0'),(1021,'岗位查询','system:post:query',3,1,104,'','#','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','','2022-04-20 17:03:10',_binary '\0'),(1022,'岗位新增','system:post:create',3,2,104,'','','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','1','2022-04-20 17:03:10',_binary '\0'),(1023,'岗位修改','system:post:update',3,3,104,'','','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','1','2022-04-20 17:03:10',_binary '\0'),(1024,'岗位删除','system:post:delete',3,4,104,'','','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','1','2022-04-20 17:03:10',_binary '\0'),(1025,'岗位导出','system:post:export',3,5,104,'','#','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','','2022-04-20 17:03:10',_binary '\0'),(1026,'字典查询','system:dict:query',3,1,105,'#','#','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','','2022-04-20 17:03:10',_binary '\0'),(1027,'字典新增','system:dict:create',3,2,105,'','','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','1','2022-04-20 17:03:10',_binary '\0'),(1028,'字典修改','system:dict:update',3,3,105,'','','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','1','2022-04-20 17:03:10',_binary '\0'),(1029,'字典删除','system:dict:delete',3,4,105,'','','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','1','2022-04-20 17:03:10',_binary '\0'),(1030,'字典导出','system:dict:export',3,5,105,'#','#','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','','2022-04-20 17:03:10',_binary '\0'),(1031,'配置查询','infra:config:query',3,1,106,'','','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','','2022-04-20 17:03:10',_binary '\0'),(1032,'配置新增','infra:config:create',3,2,106,'','','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','1','2022-04-20 17:03:10',_binary '\0'),(1033,'配置修改','infra:config:update',3,3,106,'','','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','1','2022-04-20 17:03:10',_binary '\0'),(1034,'配置删除','infra:config:delete',3,4,106,'','','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','1','2022-04-20 17:03:10',_binary '\0'),(1035,'配置导出','infra:config:export',3,5,106,'','','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','','2022-04-20 17:03:10',_binary '\0'),(1036,'公告查询','system:notice:query',3,1,107,'#','#','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','','2022-04-20 17:03:10',_binary '\0'),(1037,'公告新增','system:notice:create',3,2,107,'','','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','1','2022-04-20 17:03:10',_binary '\0'),(1038,'公告修改','system:notice:update',3,3,107,'','','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','1','2022-04-20 17:03:10',_binary '\0'),(1039,'公告删除','system:notice:delete',3,4,107,'','','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','1','2022-04-20 17:03:10',_binary '\0'),(1040,'操作查询','system:operate-log:query',3,1,500,'','','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','','2022-04-20 17:03:10',_binary '\0'),(1042,'日志导出','system:operate-log:export',3,2,500,'','','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','','2022-04-20 17:03:10',_binary '\0'),(1043,'登录查询','system:login-log:query',3,1,501,'#','#','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','','2022-04-20 17:03:10',_binary '\0'),(1045,'日志导出','system:login-log:export',3,3,501,'#','#','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','','2022-04-20 17:03:10',_binary '\0'),(1046,'令牌列表','system:oauth2-token:page',3,1,109,'','','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','1','2022-05-09 23:54:42',_binary '\0'),(1048,'令牌删除','system:oauth2-token:delete',3,2,109,'','','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','1','2022-05-09 23:54:53',_binary '\0'),(1056,'生成修改','infra:codegen:update',3,2,115,'','','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','1','2022-04-20 17:03:10',_binary '\0'),(1057,'生成删除','infra:codegen:delete',3,3,115,'','','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','1','2022-04-20 17:03:10',_binary '\0'),(1058,'导入代码','infra:codegen:create',3,2,115,'','','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','1','2022-04-20 17:03:10',_binary '\0'),(1059,'预览代码','infra:codegen:preview',3,4,115,'','','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','1','2022-04-20 17:03:10',_binary '\0'),(1060,'生成代码','infra:codegen:download',3,5,115,'','','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','1','2022-04-20 17:03:10',_binary '\0'),(1063,'设置角色菜单权限','system:permission:assign-role-menu',3,6,101,'','','',NULL,0,_binary '',_binary '',_binary '','','2021-01-06 17:53:44','','2022-04-20 17:03:10',_binary '\0'),(1064,'设置角色数据权限','system:permission:assign-role-data-scope',3,7,101,'','','',NULL,0,_binary '',_binary '',_binary '','','2021-01-06 17:56:31','','2022-04-20 17:03:10',_binary '\0'),(1065,'设置用户角色','system:permission:assign-user-role',3,8,101,'','','',NULL,0,_binary '',_binary '',_binary '','','2021-01-07 10:23:28','','2022-04-20 17:03:10',_binary '\0'),(1066,'获得 Redis 监控信息','infra:redis:get-monitor-info',3,1,113,'','','',NULL,0,_binary '',_binary '',_binary '','','2021-01-26 01:02:31','','2022-04-20 17:03:10',_binary '\0'),(1067,'获得 Redis Key 列表','infra:redis:get-key-list',3,2,113,'','','',NULL,0,_binary '',_binary '',_binary '','','2021-01-26 01:02:52','','2022-04-20 17:03:10',_binary '\0'),(1077,'链路追踪','',2,4,2740,'skywalking','fa:eye','infra/skywalking/index','InfraSkyWalking',0,_binary '',_binary '',_binary '','','2021-02-08 20:41:31','1','2024-04-23 00:07:15',_binary '\0'),(1078,'访问日志','',2,1,1083,'api-access-log','ep:place','infra/apiAccessLog/index','InfraApiAccessLog',0,_binary '',_binary '',_binary '','','2021-02-26 01:32:59','1','2024-02-29 08:54:57',_binary '\0'),(1082,'日志导出','infra:api-access-log:export',3,2,1078,'','','',NULL,0,_binary '',_binary '',_binary '','','2021-02-26 01:32:59','1','2022-04-20 17:03:10',_binary '\0'),(1083,'API 日志','',2,4,2,'log','fa:tasks',NULL,NULL,0,_binary '',_binary '',_binary '','','2021-02-26 02:18:24','1','2024-04-22 23:58:36',_binary '\0'),(1084,'错误日志','infra:api-error-log:query',2,2,1083,'api-error-log','ep:warning-filled','infra/apiErrorLog/index','InfraApiErrorLog',0,_binary '',_binary '',_binary '','','2021-02-26 07:53:20','1','2024-02-29 08:55:17',_binary '\0'),(1085,'日志处理','infra:api-error-log:update-status',3,2,1084,'','','',NULL,0,_binary '',_binary '',_binary '','','2021-02-26 07:53:20','1','2022-04-20 17:03:10',_binary '\0'),(1086,'日志导出','infra:api-error-log:export',3,3,1084,'','','',NULL,0,_binary '',_binary '',_binary '','','2021-02-26 07:53:20','1','2022-04-20 17:03:10',_binary '\0'),(1088,'日志查询','infra:api-access-log:query',3,1,1078,'','','',NULL,0,_binary '',_binary '',_binary '','1','2021-03-10 01:28:04','1','2022-04-20 17:03:10',_binary '\0'),(1089,'日志查询','infra:api-error-log:query',3,1,1084,'','','',NULL,0,_binary '',_binary '',_binary '','1','2021-03-10 01:29:09','1','2022-04-20 17:03:10',_binary '\0'),(1090,'文件列表','',2,5,1243,'file','ep:upload-filled','infra/file/index','InfraFile',0,_binary '',_binary '',_binary '','','2021-03-12 20:16:20','1','2024-02-29 08:53:02',_binary '\0'),(1091,'文件查询','infra:file:query',3,1,1090,'','','',NULL,0,_binary '',_binary '',_binary '','','2021-03-12 20:16:20','','2022-04-20 17:03:10',_binary '\0'),(1092,'文件删除','infra:file:delete',3,4,1090,'','','',NULL,0,_binary '',_binary '',_binary '','','2021-03-12 20:16:20','','2022-04-20 17:03:10',_binary '\0'),(1093,'短信管理','',1,1,2739,'sms','ep:message',NULL,NULL,0,_binary '',_binary '',_binary '','1','2021-04-05 01:10:16','1','2024-04-22 23:56:03',_binary '\0'),(1094,'短信渠道','',2,0,1093,'sms-channel','fa:stack-exchange','system/sms/channel/index','SystemSmsChannel',0,_binary '',_binary '',_binary '','','2021-04-01 11:07:15','1','2024-02-29 01:15:54',_binary '\0'),(1095,'短信渠道查询','system:sms-channel:query',3,1,1094,'','','',NULL,0,_binary '',_binary '',_binary '','','2021-04-01 11:07:15','','2022-04-20 17:03:10',_binary '\0'),(1096,'短信渠道创建','system:sms-channel:create',3,2,1094,'','','',NULL,0,_binary '',_binary '',_binary '','','2021-04-01 11:07:15','','2022-04-20 17:03:10',_binary '\0'),(1097,'短信渠道更新','system:sms-channel:update',3,3,1094,'','','',NULL,0,_binary '',_binary '',_binary '','','2021-04-01 11:07:15','','2022-04-20 17:03:10',_binary '\0'),(1098,'短信渠道删除','system:sms-channel:delete',3,4,1094,'','','',NULL,0,_binary '',_binary '',_binary '','','2021-04-01 11:07:15','','2022-04-20 17:03:10',_binary '\0'),(1100,'短信模板','',2,1,1093,'sms-template','ep:connection','system/sms/template/index','SystemSmsTemplate',0,_binary '',_binary '',_binary '','','2021-04-01 17:35:17','1','2024-02-29 01:16:18',_binary '\0'),(1101,'短信模板查询','system:sms-template:query',3,1,1100,'','','',NULL,0,_binary '',_binary '',_binary '','','2021-04-01 17:35:17','','2022-04-20 17:03:10',_binary '\0'),(1102,'短信模板创建','system:sms-template:create',3,2,1100,'','','',NULL,0,_binary '',_binary '',_binary '','','2021-04-01 17:35:17','','2022-04-20 17:03:10',_binary '\0'),(1103,'短信模板更新','system:sms-template:update',3,3,1100,'','','',NULL,0,_binary '',_binary '',_binary '','','2021-04-01 17:35:17','','2022-04-20 17:03:10',_binary '\0'),(1104,'短信模板删除','system:sms-template:delete',3,4,1100,'','','',NULL,0,_binary '',_binary '',_binary '','','2021-04-01 17:35:17','','2022-04-20 17:03:10',_binary '\0'),(1105,'短信模板导出','system:sms-template:export',3,5,1100,'','','',NULL,0,_binary '',_binary '',_binary '','','2021-04-01 17:35:17','','2022-04-20 17:03:10',_binary '\0'),(1106,'发送测试短信','system:sms-template:send-sms',3,6,1100,'','','',NULL,0,_binary '',_binary '',_binary '','1','2021-04-11 00:26:40','1','2022-04-20 17:03:10',_binary '\0'),(1107,'短信日志','',2,2,1093,'sms-log','fa:edit','system/sms/log/index','SystemSmsLog',0,_binary '',_binary '',_binary '','','2021-04-11 08:37:05','1','2024-02-29 08:49:02',_binary '\0'),(1108,'短信日志查询','system:sms-log:query',3,1,1107,'','','',NULL,0,_binary '',_binary '',_binary '','','2021-04-11 08:37:05','','2022-04-20 17:03:10',_binary '\0'),(1109,'短信日志导出','system:sms-log:export',3,5,1107,'','','',NULL,0,_binary '',_binary '',_binary '','','2021-04-11 08:37:05','','2022-04-20 17:03:10',_binary '\0'),(1138,'租户列表','',2,0,1224,'list','ep:house','system/tenant/index','SystemTenant',0,_binary '',_binary '',_binary '','','2021-12-14 12:31:43','1','2024-02-29 01:01:10',_binary '\0'),(1139,'租户查询','system:tenant:query',3,1,1138,'','','',NULL,0,_binary '',_binary '',_binary '','','2021-12-14 12:31:44','','2022-04-20 17:03:10',_binary '\0'),(1140,'租户创建','system:tenant:create',3,2,1138,'','','',NULL,0,_binary '',_binary '',_binary '','','2021-12-14 12:31:44','','2022-04-20 17:03:10',_binary '\0'),(1141,'租户更新','system:tenant:update',3,3,1138,'','','',NULL,0,_binary '',_binary '',_binary '','','2021-12-14 12:31:44','','2022-04-20 17:03:10',_binary '\0'),(1142,'租户删除','system:tenant:delete',3,4,1138,'','','',NULL,0,_binary '',_binary '',_binary '','','2021-12-14 12:31:44','','2022-04-20 17:03:10',_binary '\0'),(1143,'租户导出','system:tenant:export',3,5,1138,'','','',NULL,0,_binary '',_binary '',_binary '','','2021-12-14 12:31:44','','2022-04-20 17:03:10',_binary '\0'),(1224,'租户管理','',2,0,1,'tenant','fa-solid:house-user',NULL,NULL,0,_binary '',_binary '',_binary '','1','2022-02-20 01:41:13','1','2024-02-29 00:59:29',_binary '\0'),(1225,'租户套餐','',2,0,1224,'package','fa:bars','system/tenantPackage/index','SystemTenantPackage',0,_binary '',_binary '',_binary '','','2022-02-19 17:44:06','1','2024-02-29 01:01:43',_binary '\0'),(1226,'租户套餐查询','system:tenant-package:query',3,1,1225,'','','',NULL,0,_binary '',_binary '',_binary '','','2022-02-19 17:44:06','','2022-04-20 17:03:10',_binary '\0'),(1227,'租户套餐创建','system:tenant-package:create',3,2,1225,'','','',NULL,0,_binary '',_binary '',_binary '','','2022-02-19 17:44:06','','2022-04-20 17:03:10',_binary '\0'),(1228,'租户套餐更新','system:tenant-package:update',3,3,1225,'','','',NULL,0,_binary '',_binary '',_binary '','','2022-02-19 17:44:06','','2022-04-20 17:03:10',_binary '\0'),(1229,'租户套餐删除','system:tenant-package:delete',3,4,1225,'','','',NULL,0,_binary '',_binary '',_binary '','','2022-02-19 17:44:06','','2022-04-20 17:03:10',_binary '\0'),(1237,'文件配置','',2,0,1243,'file-config','fa-solid:file-signature','infra/fileConfig/index','InfraFileConfig',0,_binary '',_binary '',_binary '','','2022-03-15 14:35:28','1','2024-02-29 08:52:54',_binary '\0'),(1238,'文件配置查询','infra:file-config:query',3,1,1237,'','','',NULL,0,_binary '',_binary '',_binary '','','2022-03-15 14:35:28','','2022-04-20 17:03:10',_binary '\0'),(1239,'文件配置创建','infra:file-config:create',3,2,1237,'','','',NULL,0,_binary '',_binary '',_binary '','','2022-03-15 14:35:28','','2022-04-20 17:03:10',_binary '\0'),(1240,'文件配置更新','infra:file-config:update',3,3,1237,'','','',NULL,0,_binary '',_binary '',_binary '','','2022-03-15 14:35:28','','2022-04-20 17:03:10',_binary '\0'),(1241,'文件配置删除','infra:file-config:delete',3,4,1237,'','','',NULL,0,_binary '',_binary '',_binary '','','2022-03-15 14:35:28','','2022-04-20 17:03:10',_binary '\0'),(1242,'文件配置导出','infra:file-config:export',3,5,1237,'','','',NULL,0,_binary '',_binary '',_binary '','','2022-03-15 14:35:28','','2022-04-20 17:03:10',_binary '\0'),(1243,'文件管理','',2,6,2,'file','ep:files',NULL,'',0,_binary '',_binary '',_binary '','1','2022-03-16 23:47:40','1','2024-04-23 00:02:11',_binary '\0'),(1255,'数据源配置','',2,1,2,'data-source-config','ep:data-analysis','infra/dataSourceConfig/index','InfraDataSourceConfig',0,_binary '',_binary '',_binary '','','2022-04-27 14:37:32','1','2024-02-29 08:51:25',_binary '\0'),(1256,'数据源配置查询','infra:data-source-config:query',3,1,1255,'','','',NULL,0,_binary '',_binary '',_binary '','','2022-04-27 14:37:32','','2022-04-27 14:37:32',_binary '\0'),(1257,'数据源配置创建','infra:data-source-config:create',3,2,1255,'','','',NULL,0,_binary '',_binary '',_binary '','','2022-04-27 14:37:32','','2022-04-27 14:37:32',_binary '\0'),(1258,'数据源配置更新','infra:data-source-config:update',3,3,1255,'','','',NULL,0,_binary '',_binary '',_binary '','','2022-04-27 14:37:32','','2022-04-27 14:37:32',_binary '\0'),(1259,'数据源配置删除','infra:data-source-config:delete',3,4,1255,'','','',NULL,0,_binary '',_binary '',_binary '','','2022-04-27 14:37:32','','2022-04-27 14:37:32',_binary '\0'),(1260,'数据源配置导出','infra:data-source-config:export',3,5,1255,'','','',NULL,0,_binary '',_binary '',_binary '','','2022-04-27 14:37:32','','2022-04-27 14:37:32',_binary '\0'),(1261,'OAuth 2.0','',2,10,1,'oauth2','fa:dashcube',NULL,NULL,0,_binary '',_binary '',_binary '','1','2022-05-09 23:38:17','1','2024-02-29 01:12:08',_binary '\0'),(1263,'应用管理','',2,0,1261,'oauth2/application','fa:hdd-o','system/oauth2/client/index','SystemOAuth2Client',0,_binary '',_binary '',_binary '','','2022-05-10 16:26:33','1','2024-02-29 01:13:14',_binary '\0'),(1264,'客户端查询','system:oauth2-client:query',3,1,1263,'','','',NULL,0,_binary '',_binary '',_binary '','','2022-05-10 16:26:33','1','2022-05-11 00:31:06',_binary '\0'),(1265,'客户端创建','system:oauth2-client:create',3,2,1263,'','','',NULL,0,_binary '',_binary '',_binary '','','2022-05-10 16:26:33','1','2022-05-11 00:31:23',_binary '\0'),(1266,'客户端更新','system:oauth2-client:update',3,3,1263,'','','',NULL,0,_binary '',_binary '',_binary '','','2022-05-10 16:26:33','1','2022-05-11 00:31:28',_binary '\0'),(1267,'客户端删除','system:oauth2-client:delete',3,4,1263,'','','',NULL,0,_binary '',_binary '',_binary '','','2022-05-10 16:26:33','1','2022-05-11 00:31:33',_binary '\0'),(2083,'地区管理','',2,14,1,'area','fa:map-marker','system/area/index','SystemArea',0,_binary '',_binary '',_binary '','1','2022-12-23 17:35:05','1','2024-02-29 08:50:28',_binary '\0'),(2130,'邮箱管理','',2,2,2739,'mail','fa-solid:mail-bulk',NULL,NULL,0,_binary '',_binary '',_binary '','1','2023-01-25 17:27:44','1','2024-04-22 23:56:08',_binary '\0'),(2131,'邮箱账号','',2,0,2130,'mail-account','fa:universal-access','system/mail/account/index','SystemMailAccount',0,_binary '',_binary '',_binary '','','2023-01-25 09:33:48','1','2024-02-29 08:48:16',_binary '\0'),(2132,'账号查询','system:mail-account:query',3,1,2131,'','','',NULL,0,_binary '',_binary '',_binary '','','2023-01-25 09:33:48','','2023-01-25 09:33:48',_binary '\0'),(2133,'账号创建','system:mail-account:create',3,2,2131,'','','',NULL,0,_binary '',_binary '',_binary '','','2023-01-25 09:33:48','','2023-01-25 09:33:48',_binary '\0'),(2134,'账号更新','system:mail-account:update',3,3,2131,'','','',NULL,0,_binary '',_binary '',_binary '','','2023-01-25 09:33:48','','2023-01-25 09:33:48',_binary '\0'),(2135,'账号删除','system:mail-account:delete',3,4,2131,'','','',NULL,0,_binary '',_binary '',_binary '','','2023-01-25 09:33:48','','2023-01-25 09:33:48',_binary '\0'),(2136,'邮件模版','',2,0,2130,'mail-template','fa:tag','system/mail/template/index','SystemMailTemplate',0,_binary '',_binary '',_binary '','','2023-01-25 12:05:31','1','2024-02-29 08:48:41',_binary '\0'),(2137,'模版查询','system:mail-template:query',3,1,2136,'','','',NULL,0,_binary '',_binary '',_binary '','','2023-01-25 12:05:31','','2023-01-25 12:05:31',_binary '\0'),(2138,'模版创建','system:mail-template:create',3,2,2136,'','','',NULL,0,_binary '',_binary '',_binary '','','2023-01-25 12:05:31','','2023-01-25 12:05:31',_binary '\0'),(2139,'模版更新','system:mail-template:update',3,3,2136,'','','',NULL,0,_binary '',_binary '',_binary '','','2023-01-25 12:05:31','','2023-01-25 12:05:31',_binary '\0'),(2140,'模版删除','system:mail-template:delete',3,4,2136,'','','',NULL,0,_binary '',_binary '',_binary '','','2023-01-25 12:05:31','','2023-01-25 12:05:31',_binary '\0'),(2141,'邮件记录','',2,0,2130,'mail-log','fa:edit','system/mail/log/index','SystemMailLog',0,_binary '',_binary '',_binary '','','2023-01-26 02:16:50','1','2024-02-29 08:48:51',_binary '\0'),(2142,'日志查询','system:mail-log:query',3,1,2141,'','','',NULL,0,_binary '',_binary '',_binary '','','2023-01-26 02:16:50','','2023-01-26 02:16:50',_binary '\0'),(2143,'发送测试邮件','system:mail-template:send-mail',3,5,2136,'','','',NULL,0,_binary '',_binary '',_binary '','1','2023-01-26 23:29:15','1','2023-01-26 23:29:15',_binary '\0'),(2144,'站内信管理','',1,3,2739,'notify','ep:message-box',NULL,NULL,0,_binary '',_binary '',_binary '','1','2023-01-28 10:25:18','1','2024-04-22 23:56:12',_binary '\0'),(2145,'模板管理','',2,0,2144,'notify-template','fa:archive','system/notify/template/index','SystemNotifyTemplate',0,_binary '',_binary '',_binary '','','2023-01-28 02:26:42','1','2024-02-29 08:49:14',_binary '\0'),(2146,'站内信模板查询','system:notify-template:query',3,1,2145,'','','',NULL,0,_binary '',_binary '',_binary '','','2023-01-28 02:26:42','','2023-01-28 02:26:42',_binary '\0'),(2147,'站内信模板创建','system:notify-template:create',3,2,2145,'','','',NULL,0,_binary '',_binary '',_binary '','','2023-01-28 02:26:42','','2023-01-28 02:26:42',_binary '\0'),(2148,'站内信模板更新','system:notify-template:update',3,3,2145,'','','',NULL,0,_binary '',_binary '',_binary '','','2023-01-28 02:26:42','','2023-01-28 02:26:42',_binary '\0'),(2149,'站内信模板删除','system:notify-template:delete',3,4,2145,'','','',NULL,0,_binary '',_binary '',_binary '','','2023-01-28 02:26:42','','2023-01-28 02:26:42',_binary '\0'),(2150,'发送测试站内信','system:notify-template:send-notify',3,5,2145,'','','',NULL,0,_binary '',_binary '',_binary '','1','2023-01-28 10:54:43','1','2023-01-28 10:54:43',_binary '\0'),(2151,'消息记录','',2,0,2144,'notify-message','fa:edit','system/notify/message/index','SystemNotifyMessage',0,_binary '',_binary '',_binary '','','2023-01-28 04:28:22','1','2024-02-29 08:49:22',_binary '\0'),(2152,'站内信消息查询','system:notify-message:query',3,1,2151,'','','',NULL,0,_binary '',_binary '',_binary '','','2023-01-28 04:28:22','','2023-01-28 04:28:22',_binary '\0'),(2447,'三方登录','',1,10,1,'social','fa:rocket','','',0,_binary '',_binary '',_binary '','1','2023-11-04 12:12:01','1','2024-02-29 01:14:05',_binary '\0'),(2448,'三方应用','',2,1,2447,'client','ep:set-up','system/social/client/index.vue','SocialClient',0,_binary '',_binary '',_binary '','1','2023-11-04 12:17:19','1','2024-05-04 19:09:54',_binary '\0'),(2449,'三方应用查询','system:social-client:query',3,1,2448,'','','','',0,_binary '',_binary '',_binary '','1','2023-11-04 12:43:12','1','2023-11-04 12:43:33',_binary '\0'),(2450,'三方应用创建','system:social-client:create',3,2,2448,'','','','',0,_binary '',_binary '',_binary '','1','2023-11-04 12:43:58','1','2023-11-04 12:43:58',_binary '\0'),(2451,'三方应用更新','system:social-client:update',3,3,2448,'','','','',0,_binary '',_binary '',_binary '','1','2023-11-04 12:44:27','1','2023-11-04 12:44:27',_binary '\0'),(2452,'三方应用删除','system:social-client:delete',3,4,2448,'','','','',0,_binary '',_binary '',_binary '','1','2023-11-04 12:44:43','1','2023-11-04 12:44:43',_binary '\0'),(2453,'三方用户','system:social-user:query',2,2,2447,'user','ep:avatar','system/social/user/index.vue','SocialUser',0,_binary '',_binary '',_binary '','1','2023-11-04 14:01:05','1','2023-11-04 14:01:05',_binary '\0'),(2525,'WebSocket','',2,5,2,'websocket','ep:connection','infra/webSocket/index','InfraWebSocket',0,_binary '',_binary '',_binary '','1','2023-11-23 19:41:55','1','2024-04-23 00:02:00',_binary '\0'),(2739,'消息中心','',1,7,1,'messages','ep:chat-dot-round','','',0,_binary '',_binary '',_binary '','1','2024-04-22 23:54:30','1','2024-04-23 09:36:35',_binary '\0'),(2740,'监控中心','',1,10,2,'monitors','ep:monitor','','',0,_binary '',_binary '',_binary '','1','2024-04-23 00:04:44','1','2024-04-23 00:04:44',_binary '\0'),(5010,'租户切换','system:tenant:visit',3,999,1138,'','','','',0,_binary '',_binary '',_binary '','1','2025-05-05 15:25:32','1','2025-05-05 15:25:32',_binary '\0'),(5049,'工作台','',1,-1,0,'/dashboard','lucide:layout-dashboard',NULL,NULL,0,_binary '',_binary '',_binary '','admin','2026-10-08 10:15:23','admin','2026-10-08 10:15:23',_binary '\0'),(5050,'工作台','',2,1,5049,'/workspace','carbon:workspace','dashboard/workspace/index','Workspace',0,_binary '',_binary '',_binary '','admin','2026-10-08 10:15:23','admin','2026-10-08 10:15:23',_binary '\0'),(5051,'数据分析','',2,2,5049,'/analytics','lucide:area-chart','dashboard/analytics/index','Analytics',0,_binary '',_binary '',_binary '','admin','2026-10-08 10:15:23','admin','2026-10-08 10:15:23',_binary '\0'),(5052,'我的首页','',2,3,5049,'/home','lucide:home','dashboard/home/index','DashboardHome',0,_binary '',_binary '',_binary '','admin','2026-10-08 10:15:23','admin','2026-10-08 10:15:23',_binary '\0'),(5053,'首页管理','system:home:query',2,4,5049,'/home/manage','lucide:layout-dashboard','dashboard/home/manage/index','HomePageManage',0,_binary '',_binary '',_binary '','admin','2026-10-08 10:15:23','admin','2026-10-08 10:15:23',_binary '\0'),(5054,'组件管理','system:home-component:query',2,5,5049,'/home/component','lucide:component','dashboard/home/component/index','HomeComponentManage',0,_binary '',_binary '',_binary '','admin','2026-10-08 10:15:23','admin','2026-10-08 10:15:23',_binary '\0'),(5055,'首页设计器','system:home:update',2,6,5049,'/home/designer','lucide:layout-dashboard','dashboard/home/designer/index','HomeDesigner',0,_binary '\0',_binary '',_binary '','admin','2026-10-08 10:15:23','admin','2026-10-08 10:15:23',_binary '\0');
/*!40000 ALTER TABLE `system_menu` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `system_notice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `system_notice` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '公告ID',
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '公告标题',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '公告内容',
  `type` tinyint NOT NULL COMMENT '公告类型，字典类型：system_notice_type（通知公告、公司动态、行业咨询、规章制度等）',
  `status` tinyint NOT NULL DEFAULT '0' COMMENT '公告状态（0正常 1关闭）',
  `is_important` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否重要通知（0否 1是）',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='通知公告表';
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `system_notice` WRITE;
/*!40000 ALTER TABLE `system_notice` DISABLE KEYS */;
INSERT INTO `system_notice` VALUES (1,'芋道的公众','<p>新版本内容133222</p>',1,0,_binary '\0','admin','2021-01-05 17:03:48','\"1\"','2025-08-31 09:38:22',_binary '\0',1),(2,'维护通知：2018-07-01 系统凌晨维护','<p><img src=\"http://test.yudao.iocoder.cn/b7cb3cf49b4b3258bf7309a09dd2f4e5.jpg\" alt=\"\" data-href=\"\">11112222<img src=\"http://test.yudao.iocoder.cn/fe44fc7bdb82ca421184b2eebbaee9e2148d4a1827479a4eb4521e11d2a062ba.png\" alt=\"image\" data-href=\"http://test.yudao.iocoder.cn/fe44fc7bdb82ca421184b2eebbaee9e2148d4a1827479a4eb4521e11d2a062ba.png\">3333</p>',2,1,_binary '\0','admin','2021-01-05 17:03:48','1','2025-04-18 23:56:40',_binary '\0',1),(4,'我是测试标题','<p>哈哈哈哈123</p>',1,0,_binary '\0','110','2022-02-22 01:01:25','110','2022-02-22 01:01:46',_binary '\0',121);
/*!40000 ALTER TABLE `system_notice` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `system_notice_read`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `system_notice_read` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `notice_id` bigint NOT NULL COMMENT '公告ID',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `read_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '阅读时间',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uk_notice_user` (`notice_id`,`user_id`,`deleted`) USING BTREE COMMENT '公告用户唯一索引',
  KEY `idx_notice_id` (`notice_id`) USING BTREE,
  KEY `idx_user_id` (`user_id`) USING BTREE,
  KEY `idx_tenant_id` (`tenant_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户公告已读关系表';
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `system_notice_read` WRITE;
/*!40000 ALTER TABLE `system_notice_read` DISABLE KEYS */;
/*!40000 ALTER TABLE `system_notice_read` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `system_notify_message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `system_notify_message` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `user_id` bigint NOT NULL COMMENT '用户id',
  `user_type` tinyint NOT NULL COMMENT '用户类型',
  `template_id` bigint NOT NULL COMMENT '模版编号',
  `template_code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '模板编码',
  `template_nickname` varchar(63) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '模版发送人名称',
  `template_content` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '模版内容',
  `template_type` int NOT NULL COMMENT '模版类型',
  `template_params` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '模版参数',
  `read_status` bit(1) NOT NULL COMMENT '是否已读',
  `read_time` datetime DEFAULT NULL COMMENT '阅读时间',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='站内信消息表';
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `system_notify_message` WRITE;
/*!40000 ALTER TABLE `system_notify_message` DISABLE KEYS */;
INSERT INTO `system_notify_message` VALUES (2,1,2,1,'test','123','我是 1，我开始 2 了',1,'{\"name\":\"1\",\"what\":\"2\"}',_binary '','2025-12-15 21:24:36','1','2023-01-28 11:44:08','1','2025-12-15 21:24:36',_binary '\0',1),(3,1,2,1,'test','123','我是 1，我开始 2 了',1,'{\"name\":\"1\",\"what\":\"2\"}',_binary '','2025-12-15 21:24:36','1','2023-01-28 11:45:04','1','2025-12-15 21:24:36',_binary '\0',1),(4,103,2,2,'register','系统消息','你好，欢迎 哈哈 加入大家庭！',2,'{\"name\":\"哈哈\"}',_binary '\0',NULL,'1','2023-01-28 21:02:20','1','2023-01-28 21:02:20',_binary '\0',1),(5,1,2,1,'test','123','我是 芋艿，我开始 写代码 了',1,'{\"name\":\"芋艿\",\"what\":\"写代码\"}',_binary '','2025-12-08 17:25:28','1','2023-01-28 22:21:42','1','2025-12-08 17:25:28',_binary '\0',1),(6,1,2,1,'test','123','我是 芋艿，我开始 写代码 了',1,'{\"name\":\"芋艿\",\"what\":\"写代码\"}',_binary '','2025-12-08 17:25:30','1','2023-01-28 22:22:07','1','2025-12-08 17:25:30',_binary '\0',1),(7,1,2,1,'test','123','我是 2，我开始 3 了',1,'{\"name\":\"2\",\"what\":\"3\"}',_binary '','2025-12-08 17:25:22','1','2023-01-28 23:45:21','1','2025-12-08 17:25:22',_binary '\0',1),(8,1,2,2,'register','系统消息','你好，欢迎 123 加入大家庭！',2,'{\"name\":\"123\"}',_binary '','2025-12-08 16:46:01','1','2023-01-28 23:50:21','1','2025-12-08 16:46:01',_binary '\0',1),(9,247,1,4,'brokerage_withdraw_audit_approve','system','您在2023-09-28 08:35:46提现￥0.09元的申请已通过审核',2,'{\"reason\":null,\"createTime\":\"2023-09-28 08:35:46\",\"price\":\"0.09\"}',_binary '\0',NULL,'1','2023-09-28 16:36:22','1','2023-09-28 16:36:22',_binary '\0',1),(10,247,1,4,'brokerage_withdraw_audit_approve','system','您在2023-09-30 20:59:40提现￥1.00元的申请已通过审核',2,'{\"reason\":null,\"createTime\":\"2023-09-30 20:59:40\",\"price\":\"1.00\"}',_binary '\0',NULL,'1','2023-10-03 12:11:34','1','2023-10-03 12:11:34',_binary '\0',1);
/*!40000 ALTER TABLE `system_notify_message` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `system_notify_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `system_notify_template` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(63) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '模板名称',
  `code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '模版编码',
  `nickname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '发送人名称',
  `content` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '模版内容',
  `type` tinyint NOT NULL COMMENT '类型',
  `params` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '参数数组',
  `status` tinyint NOT NULL COMMENT '状态',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='站内信模板表';
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `system_notify_template` WRITE;
/*!40000 ALTER TABLE `system_notify_template` DISABLE KEYS */;
/*!40000 ALTER TABLE `system_notify_template` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `system_oauth2_access_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `system_oauth2_access_token` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `user_id` bigint NOT NULL COMMENT '用户编号',
  `user_type` tinyint NOT NULL COMMENT '用户类型',
  `user_info` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户信息',
  `access_token` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '访问令牌',
  `refresh_token` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '刷新令牌',
  `client_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '客户端编号',
  `scopes` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '授权范围',
  `expires_time` datetime NOT NULL COMMENT '过期时间',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_access_token` (`access_token`) USING BTREE,
  KEY `idx_refresh_token` (`refresh_token`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=47630 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='OAuth2 访问令牌';
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `system_oauth2_access_token` WRITE;
/*!40000 ALTER TABLE `system_oauth2_access_token` DISABLE KEYS */;
/*!40000 ALTER TABLE `system_oauth2_access_token` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `system_oauth2_approve`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `system_oauth2_approve` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `user_id` bigint NOT NULL COMMENT '用户编号',
  `user_type` tinyint NOT NULL COMMENT '用户类型',
  `client_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '客户端编号',
  `scope` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '授权范围',
  `approved` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否接受',
  `expires_time` datetime NOT NULL COMMENT '过期时间',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=84 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='OAuth2 批准表';
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `system_oauth2_approve` WRITE;
/*!40000 ALTER TABLE `system_oauth2_approve` DISABLE KEYS */;
/*!40000 ALTER TABLE `system_oauth2_approve` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `system_oauth2_client`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `system_oauth2_client` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `client_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '客户端编号',
  `secret` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '客户端密钥',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '应用名',
  `logo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '应用图标',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '应用描述',
  `status` tinyint NOT NULL COMMENT '状态',
  `access_token_validity_seconds` int NOT NULL COMMENT '访问令牌的有效期',
  `refresh_token_validity_seconds` int NOT NULL COMMENT '刷新令牌的有效期',
  `redirect_uris` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '可重定向的 URI 地址',
  `authorized_grant_types` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '授权类型',
  `scopes` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '授权范围',
  `auto_approve_scopes` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '自动通过的授权范围',
  `authorities` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '权限',
  `resource_ids` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '资源',
  `additional_information` varchar(4096) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '附加信息',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='OAuth2 客户端表';
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `system_oauth2_client` WRITE;
/*!40000 ALTER TABLE `system_oauth2_client` DISABLE KEYS */;
INSERT INTO `system_oauth2_client` VALUES (1,'default','admin123','芋道源码','http://test.yudao.iocoder.cn/20250502/sort2_1746189740718.png','我是描述',0,1800,2592000,'[\"https://www.iocoder.cn\",\"https://doc.iocoder.cn\"]','[\"password\",\"authorization_code\",\"implicit\",\"refresh_token\",\"client_credentials\"]','[\"user.read\",\"user.write\"]','[]','[\"user.read\",\"user.write\"]','[]','{}','1','2022-05-11 21:47:12','1','2025-12-07 20:07:09',_binary '\0'),(40,'test','test2','biubiu','http://test.yudao.iocoder.cn/20251227/javayuanma_1766829882970.jpg','啦啦啦啦',0,1800,43200,'[\"https://www.iocoder.cn\"]','[\"password\",\"authorization_code\",\"implicit\"]','[\"user_info\",\"projects\"]','[\"user_info\"]','[]','[]','{}','1','2022-05-12 00:28:20','1','2025-12-27 18:04:44',_binary '\0'),(41,'yudao-sso-demo-by-code','test','基于授权码模式，如何实现 SSO 单点登录？','http://test.yudao.iocoder.cn/it/20250502/sign_1746181948685.png',NULL,0,1800,43200,'[\"http://127.0.0.1:18080\"]','[\"authorization_code\",\"refresh_token\"]','[\"user.read\",\"user.write\"]','[]','[]','[]',NULL,'1','2022-09-29 13:28:31','1','2025-05-02 18:32:30',_binary '\0'),(42,'yudao-sso-demo-by-password','test','基于密码模式，如何实现 SSO 单点登录？','http://test.yudao.iocoder.cn/20251025/images (3)_1761360515810.jpeg',NULL,0,1800,43200,'[\"http://127.0.0.1:18080\"]','[\"password\",\"refresh_token\"]','[\"user.read\",\"user.write\"]','[]','[]','[]',NULL,'1','2022-10-04 17:40:16','1','2025-10-25 10:49:40',_binary '\0');
/*!40000 ALTER TABLE `system_oauth2_client` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `system_oauth2_code`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `system_oauth2_code` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `user_id` bigint NOT NULL COMMENT '用户编号',
  `user_type` tinyint NOT NULL COMMENT '用户类型',
  `code` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '授权码',
  `client_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '客户端编号',
  `scopes` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '授权范围',
  `expires_time` datetime NOT NULL COMMENT '过期时间',
  `redirect_uri` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '可重定向的 URI 地址',
  `state` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '状态',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=155 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='OAuth2 授权码表';
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `system_oauth2_code` WRITE;
/*!40000 ALTER TABLE `system_oauth2_code` DISABLE KEYS */;
/*!40000 ALTER TABLE `system_oauth2_code` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `system_oauth2_refresh_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `system_oauth2_refresh_token` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `user_id` bigint NOT NULL COMMENT '用户编号',
  `refresh_token` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '刷新令牌',
  `user_type` tinyint NOT NULL COMMENT '用户类型',
  `client_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '客户端编号',
  `scopes` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '授权范围',
  `expires_time` datetime NOT NULL COMMENT '过期时间',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2501 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='OAuth2 刷新令牌';
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `system_oauth2_refresh_token` WRITE;
/*!40000 ALTER TABLE `system_oauth2_refresh_token` DISABLE KEYS */;
/*!40000 ALTER TABLE `system_oauth2_refresh_token` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `system_operate_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `system_operate_log` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '日志主键',
  `trace_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '链路追踪编号',
  `user_id` bigint NOT NULL COMMENT '用户编号',
  `user_type` tinyint NOT NULL DEFAULT '0' COMMENT '用户类型',
  `type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '操作模块类型',
  `sub_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '操作名',
  `biz_id` bigint NOT NULL COMMENT '操作数据模块编号',
  `action` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '操作内容',
  `success` bit(1) NOT NULL DEFAULT b'1' COMMENT '操作结果',
  `extra` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '拓展字段',
  `request_method` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '请求方法名',
  `request_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '请求地址',
  `user_ip` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '用户 IP',
  `user_agent` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '浏览器 UA',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=9193 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='操作日志记录 V2 版本';
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `system_operate_log` WRITE;
/*!40000 ALTER TABLE `system_operate_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `system_operate_log` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `system_post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `system_post` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '岗位ID',
  `code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '岗位编码',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '岗位名称',
  `sort` int NOT NULL COMMENT '显示顺序',
  `status` tinyint NOT NULL COMMENT '状态（0正常 1停用）',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='岗位信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `system_post` WRITE;
/*!40000 ALTER TABLE `system_post` DISABLE KEYS */;
INSERT INTO `system_post` VALUES (2,'se','项目经理',2,0,'','admin','2021-01-05 17:03:48','1','2025-12-15 22:38:43',_binary '\0',1),(4,'user','普通员工',4,0,'111222','admin','2021-01-05 17:03:48','1','2025-03-24 21:32:40',_binary '\0',1),(5,'HR','人力资源',5,0,'`','1','2024-03-24 20:45:40','1','2025-03-29 19:08:10',_binary '\0',1),(7,'test','测试',10,0,NULL,'1','2025-09-02 08:45:57','1','2025-09-02 08:45:57',_binary '\0',1);
/*!40000 ALTER TABLE `system_post` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `system_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `system_role` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '角色名称',
  `code` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '角色权限字符串',
  `sort` int NOT NULL COMMENT '显示顺序',
  `data_scope` tinyint NOT NULL DEFAULT '1' COMMENT '数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限）',
  `data_scope_dept_ids` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '数据范围(指定部门数组)',
  `status` tinyint NOT NULL COMMENT '角色状态（0正常 1停用）',
  `type` tinyint NOT NULL COMMENT '角色类型',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=160 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='角色信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `system_role` WRITE;
/*!40000 ALTER TABLE `system_role` DISABLE KEYS */;
INSERT INTO `system_role` VALUES (1,'超级管理员','super_admin',1,1,'',0,1,'超级管理员','admin','2021-01-05 17:03:48','','2022-02-22 05:08:21',_binary '\0',1),(2,'普通角色','common',2,2,'',0,1,'普通角色','admin','2021-01-05 17:03:48','','2022-02-22 05:08:20',_binary '\0',1),(3,'CRM 管理员','crm_admin',2,1,'',0,1,'CRM 专属角色','1','2024-02-24 10:51:13','1','2024-02-24 02:51:32',_binary '\0',1),(109,'租户管理员','tenant_admin',0,1,'',0,1,'系统自动生成','1','2022-02-22 00:56:14','1','2022-02-22 00:56:14',_binary '\0',121),(111,'租户管理员','tenant_admin',0,1,'',0,1,'系统自动生成','1','2022-03-07 21:37:58','1','2022-03-07 21:37:58',_binary '\0',122),(155,'测试数据权限1','test-dp',4,2,'[112,100,102,103,104,105,107,108]',0,2,'1111','1','2025-03-31 14:58:06','1','2025-12-04 23:29:40',_binary '\0',1);
/*!40000 ALTER TABLE `system_role` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `system_role_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `system_role_menu` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '自增编号',
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `menu_id` bigint NOT NULL COMMENT '菜单ID',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6409 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='角色和菜单关联表';
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `system_role_menu` WRITE;
/*!40000 ALTER TABLE `system_role_menu` DISABLE KEYS */;
INSERT INTO `system_role_menu` VALUES (263,109,1,'1','2022-02-22 00:56:14','1','2022-02-22 00:56:14',_binary '\0',121),(434,2,1,'1','2022-02-22 13:09:12','1','2022-02-22 13:09:12',_binary '\0',1),(454,2,1093,'1','2022-02-22 13:09:12','1','2022-02-22 13:09:12',_binary '\0',1),(455,2,1094,'1','2022-02-22 13:09:12','1','2022-02-22 13:09:12',_binary '\0',1),(460,2,1100,'1','2022-02-22 13:09:12','1','2022-02-22 13:09:12',_binary '\0',1),(467,2,1107,'1','2022-02-22 13:09:12','1','2022-02-22 13:09:12',_binary '\0',1),(477,2,100,'1','2022-02-22 13:09:12','1','2022-02-22 13:09:12',_binary '\0',1),(478,2,101,'1','2022-02-22 13:09:12','1','2022-02-22 13:09:12',_binary '\0',1),(479,2,102,'1','2022-02-22 13:09:12','1','2022-02-22 13:09:12',_binary '\0',1),(481,2,103,'1','2022-02-22 13:09:12','1','2022-02-22 13:09:12',_binary '\0',1),(483,2,104,'1','2022-02-22 13:09:12','1','2022-02-22 13:09:12',_binary '\0',1),(485,2,105,'1','2022-02-22 13:09:12','1','2022-02-22 13:09:12',_binary '\0',1),(488,2,107,'1','2022-02-22 13:09:12','1','2022-02-22 13:09:12',_binary '\0',1),(490,2,108,'1','2022-02-22 13:09:12','1','2022-02-22 13:09:12',_binary '\0',1),(492,2,109,'1','2022-02-22 13:09:12','1','2022-02-22 13:09:12',_binary '\0',1),(498,2,1138,'1','2022-02-22 13:09:12','1','2022-02-22 13:09:12',_binary '\0',1),(523,2,1224,'1','2022-02-22 13:09:12','1','2022-02-22 13:09:12',_binary '\0',1),(524,2,1225,'1','2022-02-22 13:09:12','1','2022-02-22 13:09:12',_binary '\0',1),(541,2,500,'1','2022-02-22 13:09:12','1','2022-02-22 13:09:12',_binary '\0',1),(543,2,501,'1','2022-02-22 13:09:12','1','2022-02-22 13:09:12',_binary '\0',1),(675,2,2,'1','2022-02-22 13:16:57','1','2022-02-22 13:16:57',_binary '\0',1),(689,2,1077,'1','2022-02-22 13:16:57','1','2022-02-22 13:16:57',_binary '\0',1),(690,2,1078,'1','2022-02-22 13:16:57','1','2022-02-22 13:16:57',_binary '\0',1),(692,2,1083,'1','2022-02-22 13:16:57','1','2022-02-22 13:16:57',_binary '\0',1),(693,2,1084,'1','2022-02-22 13:16:57','1','2022-02-22 13:16:57',_binary '\0',1),(699,2,1090,'1','2022-02-22 13:16:57','1','2022-02-22 13:16:57',_binary '\0',1),(703,2,106,'1','2022-02-22 13:16:57','1','2022-02-22 13:16:57',_binary '\0',1),(705,2,111,'1','2022-02-22 13:16:57','1','2022-02-22 13:16:57',_binary '\0',1),(706,2,112,'1','2022-02-22 13:16:57','1','2022-02-22 13:16:57',_binary '\0',1),(707,2,113,'1','2022-02-22 13:16:57','1','2022-02-22 13:16:57',_binary '\0',1),(1296,110,1,'110','2022-02-23 00:23:55','110','2022-02-23 00:23:55',_binary '\0',121),(1578,111,1,'1','2022-03-07 21:37:58','1','2022-03-07 21:37:58',_binary '\0',122),(1729,109,100,'1','2022-09-21 22:08:51','1','2022-09-21 22:08:51',_binary '\0',121),(1730,109,101,'1','2022-09-21 22:08:51','1','2022-09-21 22:08:51',_binary '\0',121),(1731,109,1063,'1','2022-09-21 22:08:51','1','2022-09-21 22:08:51',_binary '\0',121),(1732,109,1064,'1','2022-09-21 22:08:51','1','2022-09-21 22:08:51',_binary '\0',121),(1733,109,1001,'1','2022-09-21 22:08:51','1','2022-09-21 22:08:51',_binary '\0',121),(1734,109,1065,'1','2022-09-21 22:08:51','1','2022-09-21 22:08:51',_binary '\0',121),(1735,109,1002,'1','2022-09-21 22:08:51','1','2022-09-21 22:08:51',_binary '\0',121),(1736,109,1003,'1','2022-09-21 22:08:51','1','2022-09-21 22:08:51',_binary '\0',121),(1737,109,1004,'1','2022-09-21 22:08:51','1','2022-09-21 22:08:51',_binary '\0',121),(1738,109,1005,'1','2022-09-21 22:08:51','1','2022-09-21 22:08:51',_binary '\0',121),(1739,109,1006,'1','2022-09-21 22:08:51','1','2022-09-21 22:08:51',_binary '\0',121),(1740,109,1007,'1','2022-09-21 22:08:51','1','2022-09-21 22:08:51',_binary '\0',121),(1741,109,1008,'1','2022-09-21 22:08:51','1','2022-09-21 22:08:51',_binary '\0',121),(1742,109,1009,'1','2022-09-21 22:08:51','1','2022-09-21 22:08:51',_binary '\0',121),(1743,109,1010,'1','2022-09-21 22:08:51','1','2022-09-21 22:08:51',_binary '\0',121),(1744,109,1011,'1','2022-09-21 22:08:51','1','2022-09-21 22:08:51',_binary '\0',121),(1745,109,1012,'1','2022-09-21 22:08:51','1','2022-09-21 22:08:51',_binary '\0',121),(1746,111,100,'1','2022-09-21 22:08:52','1','2022-09-21 22:08:52',_binary '\0',122),(1747,111,101,'1','2022-09-21 22:08:52','1','2022-09-21 22:08:52',_binary '\0',122),(1748,111,1063,'1','2022-09-21 22:08:52','1','2022-09-21 22:08:52',_binary '\0',122),(1749,111,1064,'1','2022-09-21 22:08:52','1','2022-09-21 22:08:52',_binary '\0',122),(1750,111,1001,'1','2022-09-21 22:08:52','1','2022-09-21 22:08:52',_binary '\0',122),(1751,111,1065,'1','2022-09-21 22:08:52','1','2022-09-21 22:08:52',_binary '\0',122),(1752,111,1002,'1','2022-09-21 22:08:52','1','2022-09-21 22:08:52',_binary '\0',122),(1753,111,1003,'1','2022-09-21 22:08:52','1','2022-09-21 22:08:52',_binary '\0',122),(1754,111,1004,'1','2022-09-21 22:08:52','1','2022-09-21 22:08:52',_binary '\0',122),(1755,111,1005,'1','2022-09-21 22:08:52','1','2022-09-21 22:08:52',_binary '\0',122),(1756,111,1006,'1','2022-09-21 22:08:52','1','2022-09-21 22:08:52',_binary '\0',122),(1757,111,1007,'1','2022-09-21 22:08:52','1','2022-09-21 22:08:52',_binary '\0',122),(1758,111,1008,'1','2022-09-21 22:08:52','1','2022-09-21 22:08:52',_binary '\0',122),(1759,111,1009,'1','2022-09-21 22:08:52','1','2022-09-21 22:08:52',_binary '\0',122),(1760,111,1010,'1','2022-09-21 22:08:52','1','2022-09-21 22:08:52',_binary '\0',122),(1761,111,1011,'1','2022-09-21 22:08:52','1','2022-09-21 22:08:52',_binary '\0',122),(1762,111,1012,'1','2022-09-21 22:08:52','1','2022-09-21 22:08:52',_binary '\0',122),(1763,109,100,'1','2022-09-21 22:08:53','1','2022-09-21 22:08:53',_binary '\0',121),(1764,109,101,'1','2022-09-21 22:08:53','1','2022-09-21 22:08:53',_binary '\0',121),(1765,109,1063,'1','2022-09-21 22:08:53','1','2022-09-21 22:08:53',_binary '\0',121),(1766,109,1064,'1','2022-09-21 22:08:53','1','2022-09-21 22:08:53',_binary '\0',121),(1767,109,1001,'1','2022-09-21 22:08:53','1','2022-09-21 22:08:53',_binary '\0',121),(1768,109,1065,'1','2022-09-21 22:08:53','1','2022-09-21 22:08:53',_binary '\0',121),(1769,109,1002,'1','2022-09-21 22:08:53','1','2022-09-21 22:08:53',_binary '\0',121),(1770,109,1003,'1','2022-09-21 22:08:53','1','2022-09-21 22:08:53',_binary '\0',121),(1771,109,1004,'1','2022-09-21 22:08:53','1','2022-09-21 22:08:53',_binary '\0',121),(1772,109,1005,'1','2022-09-21 22:08:53','1','2022-09-21 22:08:53',_binary '\0',121),(1773,109,1006,'1','2022-09-21 22:08:53','1','2022-09-21 22:08:53',_binary '\0',121),(1774,109,1007,'1','2022-09-21 22:08:53','1','2022-09-21 22:08:53',_binary '\0',121),(1775,109,1008,'1','2022-09-21 22:08:53','1','2022-09-21 22:08:53',_binary '\0',121),(1776,109,1009,'1','2022-09-21 22:08:53','1','2022-09-21 22:08:53',_binary '\0',121),(1777,109,1010,'1','2022-09-21 22:08:53','1','2022-09-21 22:08:53',_binary '\0',121),(1778,109,1011,'1','2022-09-21 22:08:53','1','2022-09-21 22:08:53',_binary '\0',121),(1779,109,1012,'1','2022-09-21 22:08:53','1','2022-09-21 22:08:53',_binary '\0',121),(1780,111,100,'1','2022-09-21 22:08:54','1','2022-09-21 22:08:54',_binary '\0',122),(1781,111,101,'1','2022-09-21 22:08:54','1','2022-09-21 22:08:54',_binary '\0',122),(1782,111,1063,'1','2022-09-21 22:08:54','1','2022-09-21 22:08:54',_binary '\0',122),(1783,111,1064,'1','2022-09-21 22:08:54','1','2022-09-21 22:08:54',_binary '\0',122),(1784,111,1001,'1','2022-09-21 22:08:54','1','2022-09-21 22:08:54',_binary '\0',122),(1785,111,1065,'1','2022-09-21 22:08:54','1','2022-09-21 22:08:54',_binary '\0',122),(1786,111,1002,'1','2022-09-21 22:08:54','1','2022-09-21 22:08:54',_binary '\0',122),(1787,111,1003,'1','2022-09-21 22:08:54','1','2022-09-21 22:08:54',_binary '\0',122),(1788,111,1004,'1','2022-09-21 22:08:54','1','2022-09-21 22:08:54',_binary '\0',122),(1789,111,1005,'1','2022-09-21 22:08:54','1','2022-09-21 22:08:54',_binary '\0',122),(1790,111,1006,'1','2022-09-21 22:08:54','1','2022-09-21 22:08:54',_binary '\0',122),(1791,111,1007,'1','2022-09-21 22:08:54','1','2022-09-21 22:08:54',_binary '\0',122),(1792,111,1008,'1','2022-09-21 22:08:54','1','2022-09-21 22:08:54',_binary '\0',122),(1793,111,1009,'1','2022-09-21 22:08:54','1','2022-09-21 22:08:54',_binary '\0',122),(1794,111,1010,'1','2022-09-21 22:08:54','1','2022-09-21 22:08:54',_binary '\0',122),(1795,111,1011,'1','2022-09-21 22:08:54','1','2022-09-21 22:08:54',_binary '\0',122),(1796,111,1012,'1','2022-09-21 22:08:54','1','2022-09-21 22:08:54',_binary '\0',122),(1797,109,100,'1','2022-09-21 22:08:55','1','2022-09-21 22:08:55',_binary '\0',121),(1798,109,101,'1','2022-09-21 22:08:55','1','2022-09-21 22:08:55',_binary '\0',121),(1799,109,1063,'1','2022-09-21 22:08:55','1','2022-09-21 22:08:55',_binary '\0',121),(1800,109,1064,'1','2022-09-21 22:08:55','1','2022-09-21 22:08:55',_binary '\0',121),(1801,109,1001,'1','2022-09-21 22:08:55','1','2022-09-21 22:08:55',_binary '\0',121),(1802,109,1065,'1','2022-09-21 22:08:55','1','2022-09-21 22:08:55',_binary '\0',121),(1803,109,1002,'1','2022-09-21 22:08:55','1','2022-09-21 22:08:55',_binary '\0',121),(1804,109,1003,'1','2022-09-21 22:08:55','1','2022-09-21 22:08:55',_binary '\0',121),(1805,109,1004,'1','2022-09-21 22:08:55','1','2022-09-21 22:08:55',_binary '\0',121),(1806,109,1005,'1','2022-09-21 22:08:55','1','2022-09-21 22:08:55',_binary '\0',121),(1807,109,1006,'1','2022-09-21 22:08:55','1','2022-09-21 22:08:55',_binary '\0',121),(1808,109,1007,'1','2022-09-21 22:08:55','1','2022-09-21 22:08:55',_binary '\0',121),(1809,109,1008,'1','2022-09-21 22:08:55','1','2022-09-21 22:08:55',_binary '\0',121),(1810,109,1009,'1','2022-09-21 22:08:55','1','2022-09-21 22:08:55',_binary '\0',121),(1811,109,1010,'1','2022-09-21 22:08:55','1','2022-09-21 22:08:55',_binary '\0',121),(1812,109,1011,'1','2022-09-21 22:08:55','1','2022-09-21 22:08:55',_binary '\0',121),(1813,109,1012,'1','2022-09-21 22:08:55','1','2022-09-21 22:08:55',_binary '\0',121),(1814,111,100,'1','2022-09-21 22:08:56','1','2022-09-21 22:08:56',_binary '\0',122),(1815,111,101,'1','2022-09-21 22:08:56','1','2022-09-21 22:08:56',_binary '\0',122),(1816,111,1063,'1','2022-09-21 22:08:56','1','2022-09-21 22:08:56',_binary '\0',122),(1817,111,1064,'1','2022-09-21 22:08:56','1','2022-09-21 22:08:56',_binary '\0',122),(1818,111,1001,'1','2022-09-21 22:08:56','1','2022-09-21 22:08:56',_binary '\0',122),(1819,111,1065,'1','2022-09-21 22:08:56','1','2022-09-21 22:08:56',_binary '\0',122),(1820,111,1002,'1','2022-09-21 22:08:56','1','2022-09-21 22:08:56',_binary '\0',122),(1821,111,1003,'1','2022-09-21 22:08:56','1','2022-09-21 22:08:56',_binary '\0',122),(1822,111,1004,'1','2022-09-21 22:08:56','1','2022-09-21 22:08:56',_binary '\0',122),(1823,111,1005,'1','2022-09-21 22:08:56','1','2022-09-21 22:08:56',_binary '\0',122),(1824,111,1006,'1','2022-09-21 22:08:56','1','2022-09-21 22:08:56',_binary '\0',122),(1825,111,1007,'1','2022-09-21 22:08:56','1','2022-09-21 22:08:56',_binary '\0',122),(1826,111,1008,'1','2022-09-21 22:08:56','1','2022-09-21 22:08:56',_binary '\0',122),(1827,111,1009,'1','2022-09-21 22:08:56','1','2022-09-21 22:08:56',_binary '\0',122),(1828,111,1010,'1','2022-09-21 22:08:56','1','2022-09-21 22:08:56',_binary '\0',122),(1829,111,1011,'1','2022-09-21 22:08:56','1','2022-09-21 22:08:56',_binary '\0',122),(1830,111,1012,'1','2022-09-21 22:08:56','1','2022-09-21 22:08:56',_binary '\0',122),(1831,109,103,'1','2022-09-21 22:43:23','1','2022-09-21 22:43:23',_binary '\0',121),(1832,109,1017,'1','2022-09-21 22:43:23','1','2022-09-21 22:43:23',_binary '\0',121),(1833,109,1018,'1','2022-09-21 22:43:23','1','2022-09-21 22:43:23',_binary '\0',121),(1834,109,1019,'1','2022-09-21 22:43:23','1','2022-09-21 22:43:23',_binary '\0',121),(1835,109,1020,'1','2022-09-21 22:43:23','1','2022-09-21 22:43:23',_binary '\0',121),(1836,111,103,'1','2022-09-21 22:43:24','1','2022-09-21 22:43:24',_binary '\0',122),(1837,111,1017,'1','2022-09-21 22:43:24','1','2022-09-21 22:43:24',_binary '\0',122),(1838,111,1018,'1','2022-09-21 22:43:24','1','2022-09-21 22:43:24',_binary '\0',122),(1839,111,1019,'1','2022-09-21 22:43:24','1','2022-09-21 22:43:24',_binary '\0',122),(1840,111,1020,'1','2022-09-21 22:43:24','1','2022-09-21 22:43:24',_binary '\0',122),(1841,109,1036,'1','2022-09-21 22:48:13','1','2022-09-21 22:48:13',_binary '\0',121),(1842,109,1037,'1','2022-09-21 22:48:13','1','2022-09-21 22:48:13',_binary '\0',121),(1843,109,1038,'1','2022-09-21 22:48:13','1','2022-09-21 22:48:13',_binary '\0',121),(1844,109,1039,'1','2022-09-21 22:48:13','1','2022-09-21 22:48:13',_binary '\0',121),(1845,109,107,'1','2022-09-21 22:48:13','1','2022-09-21 22:48:13',_binary '\0',121),(1846,111,1036,'1','2022-09-21 22:48:13','1','2022-09-21 22:48:13',_binary '\0',122),(1847,111,1037,'1','2022-09-21 22:48:13','1','2022-09-21 22:48:13',_binary '\0',122),(1848,111,1038,'1','2022-09-21 22:48:13','1','2022-09-21 22:48:13',_binary '\0',122),(1849,111,1039,'1','2022-09-21 22:48:13','1','2022-09-21 22:48:13',_binary '\0',122),(1850,111,107,'1','2022-09-21 22:48:13','1','2022-09-21 22:48:13',_binary '\0',122),(1991,2,1024,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0',1),(1992,2,1025,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0',1),(1993,2,1026,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0',1),(1994,2,1027,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0',1),(1995,2,1028,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0',1),(1996,2,1029,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0',1),(1997,2,1030,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0',1),(1998,2,1031,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0',1),(1999,2,1032,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0',1),(2000,2,1033,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0',1),(2001,2,1034,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0',1),(2002,2,1035,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0',1),(2003,2,1036,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0',1),(2004,2,1037,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0',1),(2005,2,1038,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0',1),(2006,2,1039,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0',1),(2007,2,1040,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0',1),(2008,2,1042,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0',1),(2009,2,1043,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0',1),(2010,2,1045,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0',1),(2011,2,1046,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0',1),(2012,2,1048,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0',1),(2018,2,1056,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0',1),(2019,2,1057,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0',1),(2020,2,1058,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0',1),(2021,2,2083,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0',1),(2022,2,1059,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0',1),(2023,2,1060,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0',1),(2024,2,1063,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0',1),(2025,2,1064,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0',1),(2026,2,1065,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0',1),(2027,2,1066,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0',1),(2028,2,1067,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0',1),(2036,2,1082,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0',1),(2037,2,1085,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0',1),(2038,2,1086,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0',1),(2040,2,1088,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0',1),(2041,2,1089,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0',1),(2042,2,1091,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0',1),(2043,2,1092,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0',1),(2044,2,1095,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0',1),(2045,2,1096,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0',1),(2046,2,1097,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0',1),(2047,2,1098,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0',1),(2048,2,1101,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0',1),(2049,2,1102,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0',1),(2050,2,1103,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0',1),(2051,2,1104,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0',1),(2052,2,1105,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0',1),(2053,2,1106,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0',1),(2054,2,1108,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0',1),(2055,2,1109,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0',1),(2072,2,114,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0',1),(2073,2,1139,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0',1),(2074,2,115,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0',1),(2075,2,1140,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0',1),(2076,2,116,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0',1),(2077,2,1141,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0',1),(2078,2,1142,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0',1),(2079,2,1143,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0',1),(2099,2,1226,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0',1),(2100,2,1227,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0',1),(2101,2,1228,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0',1),(2102,2,1229,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0',1),(2103,2,1237,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0',1),(2104,2,1238,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0',1),(2105,2,1239,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0',1),(2106,2,1240,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0',1),(2107,2,1241,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0',1),(2108,2,1242,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0',1),(2109,2,1243,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0',1),(2117,2,1255,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0',1),(2118,2,1256,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0',1),(2119,2,1257,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0',1),(2120,2,1258,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0',1),(2121,2,1259,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0',1),(2122,2,1260,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0',1),(2123,2,1261,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0',1),(2124,2,1263,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0',1),(2125,2,1264,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0',1),(2126,2,1265,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0',1),(2127,2,1266,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0',1),(2128,2,1267,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0',1),(2129,2,1001,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0',1),(2130,2,1002,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0',1),(2131,2,1003,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0',1),(2132,2,1004,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0',1),(2133,2,1005,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0',1),(2134,2,1006,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0',1),(2135,2,1007,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0',1),(2136,2,1008,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0',1),(2137,2,1009,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0',1),(2138,2,1010,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0',1),(2139,2,1011,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0',1),(2140,2,1012,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0',1),(2141,2,1013,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0',1),(2143,2,1015,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0',1),(2145,2,1017,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0',1),(2146,2,1018,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0',1),(2147,2,1019,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0',1),(2148,2,1020,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0',1),(2149,2,1021,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0',1),(2150,2,1022,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0',1),(2151,2,1023,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0',1),(2929,109,1224,'1','2023-12-02 23:19:40','1','2023-12-02 23:19:40',_binary '\0',121),(2930,109,1225,'1','2023-12-02 23:19:40','1','2023-12-02 23:19:40',_binary '\0',121),(2931,109,1226,'1','2023-12-02 23:19:40','1','2023-12-02 23:19:40',_binary '\0',121),(2932,109,1227,'1','2023-12-02 23:19:40','1','2023-12-02 23:19:40',_binary '\0',121),(2933,109,1228,'1','2023-12-02 23:19:40','1','2023-12-02 23:19:40',_binary '\0',121),(2934,109,1229,'1','2023-12-02 23:19:40','1','2023-12-02 23:19:40',_binary '\0',121),(2935,109,1138,'1','2023-12-02 23:19:40','1','2023-12-02 23:19:40',_binary '\0',121),(2936,109,1139,'1','2023-12-02 23:19:40','1','2023-12-02 23:19:40',_binary '\0',121),(2937,109,1140,'1','2023-12-02 23:19:40','1','2023-12-02 23:19:40',_binary '\0',121),(2938,109,1141,'1','2023-12-02 23:19:40','1','2023-12-02 23:19:40',_binary '\0',121),(2939,109,1142,'1','2023-12-02 23:19:40','1','2023-12-02 23:19:40',_binary '\0',121),(2940,109,1143,'1','2023-12-02 23:19:40','1','2023-12-02 23:19:40',_binary '\0',121),(2941,111,1224,'1','2023-12-02 23:19:40','1','2023-12-02 23:19:40',_binary '\0',122),(2942,111,1225,'1','2023-12-02 23:19:40','1','2023-12-02 23:19:40',_binary '\0',122),(2943,111,1226,'1','2023-12-02 23:19:40','1','2023-12-02 23:19:40',_binary '\0',122),(2944,111,1227,'1','2023-12-02 23:19:40','1','2023-12-02 23:19:40',_binary '\0',122),(2945,111,1228,'1','2023-12-02 23:19:40','1','2023-12-02 23:19:40',_binary '\0',122),(2946,111,1229,'1','2023-12-02 23:19:40','1','2023-12-02 23:19:40',_binary '\0',122),(2947,111,1138,'1','2023-12-02 23:19:40','1','2023-12-02 23:19:40',_binary '\0',122),(2948,111,1139,'1','2023-12-02 23:19:40','1','2023-12-02 23:19:40',_binary '\0',122),(2949,111,1140,'1','2023-12-02 23:19:40','1','2023-12-02 23:19:40',_binary '\0',122),(2950,111,1141,'1','2023-12-02 23:19:40','1','2023-12-02 23:19:40',_binary '\0',122),(2951,111,1142,'1','2023-12-02 23:19:40','1','2023-12-02 23:19:40',_binary '\0',122),(2952,111,1143,'1','2023-12-02 23:19:40','1','2023-12-02 23:19:40',_binary '\0',122),(2993,109,2,'1','2023-12-02 23:41:02','1','2023-12-02 23:41:02',_binary '\0',121),(2994,109,1031,'1','2023-12-02 23:41:02','1','2023-12-02 23:41:02',_binary '\0',121),(2995,109,1032,'1','2023-12-02 23:41:02','1','2023-12-02 23:41:02',_binary '\0',121),(2996,109,1033,'1','2023-12-02 23:41:02','1','2023-12-02 23:41:02',_binary '\0',121),(2997,109,1034,'1','2023-12-02 23:41:02','1','2023-12-02 23:41:02',_binary '\0',121),(2998,109,1035,'1','2023-12-02 23:41:02','1','2023-12-02 23:41:02',_binary '\0',121),(3004,109,1056,'1','2023-12-02 23:41:02','1','2023-12-02 23:41:02',_binary '\0',121),(3005,109,1057,'1','2023-12-02 23:41:02','1','2023-12-02 23:41:02',_binary '\0',121),(3006,109,1058,'1','2023-12-02 23:41:02','1','2023-12-02 23:41:02',_binary '\0',121),(3007,109,1059,'1','2023-12-02 23:41:02','1','2023-12-02 23:41:02',_binary '\0',121),(3008,109,1060,'1','2023-12-02 23:41:02','1','2023-12-02 23:41:02',_binary '\0',121),(3009,109,1066,'1','2023-12-02 23:41:02','1','2023-12-02 23:41:02',_binary '\0',121),(3010,109,1067,'1','2023-12-02 23:41:02','1','2023-12-02 23:41:02',_binary '\0',121),(3014,109,1077,'1','2023-12-02 23:41:02','1','2023-12-02 23:41:02',_binary '\0',121),(3015,109,1078,'1','2023-12-02 23:41:02','1','2023-12-02 23:41:02',_binary '\0',121),(3016,109,1082,'1','2023-12-02 23:41:02','1','2023-12-02 23:41:02',_binary '\0',121),(3017,109,1083,'1','2023-12-02 23:41:02','1','2023-12-02 23:41:02',_binary '\0',121),(3018,109,1084,'1','2023-12-02 23:41:02','1','2023-12-02 23:41:02',_binary '\0',121),(3019,109,1085,'1','2023-12-02 23:41:02','1','2023-12-02 23:41:02',_binary '\0',121),(3020,109,1086,'1','2023-12-02 23:41:02','1','2023-12-02 23:41:02',_binary '\0',121),(3022,109,1088,'1','2023-12-02 23:41:02','1','2023-12-02 23:41:02',_binary '\0',121),(3023,109,1089,'1','2023-12-02 23:41:02','1','2023-12-02 23:41:02',_binary '\0',121),(3024,109,1090,'1','2023-12-02 23:41:02','1','2023-12-02 23:41:02',_binary '\0',121),(3025,109,1091,'1','2023-12-02 23:41:02','1','2023-12-02 23:41:02',_binary '\0',121),(3026,109,1092,'1','2023-12-02 23:41:02','1','2023-12-02 23:41:02',_binary '\0',121),(3027,109,106,'1','2023-12-02 23:41:02','1','2023-12-02 23:41:02',_binary '\0',121),(3029,109,111,'1','2023-12-02 23:41:02','1','2023-12-02 23:41:02',_binary '\0',121),(3030,109,112,'1','2023-12-02 23:41:02','1','2023-12-02 23:41:02',_binary '\0',121),(3031,109,113,'1','2023-12-02 23:41:02','1','2023-12-02 23:41:02',_binary '\0',121),(3032,109,114,'1','2023-12-02 23:41:02','1','2023-12-02 23:41:02',_binary '\0',121),(3033,109,115,'1','2023-12-02 23:41:02','1','2023-12-02 23:41:02',_binary '\0',121),(3034,109,116,'1','2023-12-02 23:41:02','1','2023-12-02 23:41:02',_binary '\0',121),(3055,109,1237,'1','2023-12-02 23:41:02','1','2023-12-02 23:41:02',_binary '\0',121),(3056,109,1238,'1','2023-12-02 23:41:02','1','2023-12-02 23:41:02',_binary '\0',121),(3057,109,1239,'1','2023-12-02 23:41:02','1','2023-12-02 23:41:02',_binary '\0',121),(3058,109,1240,'1','2023-12-02 23:41:02','1','2023-12-02 23:41:02',_binary '\0',121),(3059,109,1241,'1','2023-12-02 23:41:02','1','2023-12-02 23:41:02',_binary '\0',121),(3060,109,1242,'1','2023-12-02 23:41:02','1','2023-12-02 23:41:02',_binary '\0',121),(3061,109,1243,'1','2023-12-02 23:41:02','1','2023-12-02 23:41:02',_binary '\0',121),(3062,109,2525,'1','2023-12-02 23:41:02','1','2023-12-02 23:41:02',_binary '\0',121),(3063,109,1255,'1','2023-12-02 23:41:02','1','2023-12-02 23:41:02',_binary '\0',121),(3064,109,1256,'1','2023-12-02 23:41:02','1','2023-12-02 23:41:02',_binary '\0',121),(3065,109,1257,'1','2023-12-02 23:41:02','1','2023-12-02 23:41:02',_binary '\0',121),(3066,109,1258,'1','2023-12-02 23:41:02','1','2023-12-02 23:41:02',_binary '\0',121),(3067,109,1259,'1','2023-12-02 23:41:02','1','2023-12-02 23:41:02',_binary '\0',121),(3068,109,1260,'1','2023-12-02 23:41:02','1','2023-12-02 23:41:02',_binary '\0',121),(3069,111,2,'1','2023-12-02 23:41:02','1','2023-12-02 23:41:02',_binary '\0',122),(3070,111,1031,'1','2023-12-02 23:41:02','1','2023-12-02 23:41:02',_binary '\0',122),(3071,111,1032,'1','2023-12-02 23:41:02','1','2023-12-02 23:41:02',_binary '\0',122),(3072,111,1033,'1','2023-12-02 23:41:02','1','2023-12-02 23:41:02',_binary '\0',122),(3073,111,1034,'1','2023-12-02 23:41:02','1','2023-12-02 23:41:02',_binary '\0',122),(3074,111,1035,'1','2023-12-02 23:41:02','1','2023-12-02 23:41:02',_binary '\0',122),(3080,111,1056,'1','2023-12-02 23:41:02','1','2023-12-02 23:41:02',_binary '\0',122),(3081,111,1057,'1','2023-12-02 23:41:02','1','2023-12-02 23:41:02',_binary '\0',122),(3082,111,1058,'1','2023-12-02 23:41:02','1','2023-12-02 23:41:02',_binary '\0',122),(3083,111,1059,'1','2023-12-02 23:41:02','1','2023-12-02 23:41:02',_binary '\0',122),(3084,111,1060,'1','2023-12-02 23:41:02','1','2023-12-02 23:41:02',_binary '\0',122),(3085,111,1066,'1','2023-12-02 23:41:02','1','2023-12-02 23:41:02',_binary '\0',122),(3086,111,1067,'1','2023-12-02 23:41:02','1','2023-12-02 23:41:02',_binary '\0',122),(3090,111,1077,'1','2023-12-02 23:41:02','1','2023-12-02 23:41:02',_binary '\0',122),(3091,111,1078,'1','2023-12-02 23:41:02','1','2023-12-02 23:41:02',_binary '\0',122),(3092,111,1082,'1','2023-12-02 23:41:02','1','2023-12-02 23:41:02',_binary '\0',122),(3093,111,1083,'1','2023-12-02 23:41:02','1','2023-12-02 23:41:02',_binary '\0',122),(3094,111,1084,'1','2023-12-02 23:41:02','1','2023-12-02 23:41:02',_binary '\0',122),(3095,111,1085,'1','2023-12-02 23:41:02','1','2023-12-02 23:41:02',_binary '\0',122),(3096,111,1086,'1','2023-12-02 23:41:02','1','2023-12-02 23:41:02',_binary '\0',122),(3098,111,1088,'1','2023-12-02 23:41:02','1','2023-12-02 23:41:02',_binary '\0',122),(3099,111,1089,'1','2023-12-02 23:41:02','1','2023-12-02 23:41:02',_binary '\0',122),(3100,111,1090,'1','2023-12-02 23:41:02','1','2023-12-02 23:41:02',_binary '\0',122),(3101,111,1091,'1','2023-12-02 23:41:02','1','2023-12-02 23:41:02',_binary '\0',122),(3102,111,1092,'1','2023-12-02 23:41:02','1','2023-12-02 23:41:02',_binary '\0',122),(3103,111,106,'1','2023-12-02 23:41:02','1','2023-12-02 23:41:02',_binary '\0',122),(3105,111,111,'1','2023-12-02 23:41:02','1','2023-12-02 23:41:02',_binary '\0',122),(3106,111,112,'1','2023-12-02 23:41:02','1','2023-12-02 23:41:02',_binary '\0',122),(3107,111,113,'1','2023-12-02 23:41:02','1','2023-12-02 23:41:02',_binary '\0',122),(3108,111,114,'1','2023-12-02 23:41:02','1','2023-12-02 23:41:02',_binary '\0',122),(3109,111,115,'1','2023-12-02 23:41:02','1','2023-12-02 23:41:02',_binary '\0',122),(3110,111,116,'1','2023-12-02 23:41:02','1','2023-12-02 23:41:02',_binary '\0',122),(3131,111,1237,'1','2023-12-02 23:41:02','1','2023-12-02 23:41:02',_binary '\0',122),(3132,111,1238,'1','2023-12-02 23:41:02','1','2023-12-02 23:41:02',_binary '\0',122),(3133,111,1239,'1','2023-12-02 23:41:02','1','2023-12-02 23:41:02',_binary '\0',122),(3134,111,1240,'1','2023-12-02 23:41:02','1','2023-12-02 23:41:02',_binary '\0',122),(3135,111,1241,'1','2023-12-02 23:41:02','1','2023-12-02 23:41:02',_binary '\0',122),(3136,111,1242,'1','2023-12-02 23:41:02','1','2023-12-02 23:41:02',_binary '\0',122),(3137,111,1243,'1','2023-12-02 23:41:02','1','2023-12-02 23:41:02',_binary '\0',122),(3138,111,2525,'1','2023-12-02 23:41:02','1','2023-12-02 23:41:02',_binary '\0',122),(3139,111,1255,'1','2023-12-02 23:41:02','1','2023-12-02 23:41:02',_binary '\0',122),(3140,111,1256,'1','2023-12-02 23:41:02','1','2023-12-02 23:41:02',_binary '\0',122),(3141,111,1257,'1','2023-12-02 23:41:02','1','2023-12-02 23:41:02',_binary '\0',122),(3142,111,1258,'1','2023-12-02 23:41:02','1','2023-12-02 23:41:02',_binary '\0',122),(3143,111,1259,'1','2023-12-02 23:41:02','1','2023-12-02 23:41:02',_binary '\0',122),(3144,111,1260,'1','2023-12-02 23:41:02','1','2023-12-02 23:41:02',_binary '\0',122),(3221,109,102,'1','2023-12-30 11:42:36','1','2023-12-30 11:42:36',_binary '\0',121),(3222,109,1013,'1','2023-12-30 11:42:36','1','2023-12-30 11:42:36',_binary '\0',121),(3223,109,1014,'1','2023-12-30 11:42:36','1','2023-12-30 11:42:36',_binary '\0',121),(3224,109,1015,'1','2023-12-30 11:42:36','1','2023-12-30 11:42:36',_binary '\0',121),(3225,109,1016,'1','2023-12-30 11:42:36','1','2023-12-30 11:42:36',_binary '\0',121),(3226,111,102,'1','2023-12-30 11:42:36','1','2023-12-30 11:42:36',_binary '\0',122),(3227,111,1013,'1','2023-12-30 11:42:36','1','2023-12-30 11:42:36',_binary '\0',122),(3228,111,1014,'1','2023-12-30 11:42:36','1','2023-12-30 11:42:36',_binary '\0',122),(3229,111,1015,'1','2023-12-30 11:42:36','1','2023-12-30 11:42:36',_binary '\0',122),(3230,111,1016,'1','2023-12-30 11:42:36','1','2023-12-30 11:42:36',_binary '\0',122),(5779,2,2739,'1','2024-07-07 20:39:38','1','2024-07-07 20:39:38',_binary '\0',1),(5780,2,2740,'1','2024-07-07 20:39:38','1','2024-07-07 20:39:38',_binary '\0',1),(5789,109,2739,'1','2024-07-13 22:37:24','1','2024-07-13 22:37:24',_binary '\0',121),(5790,109,2740,'1','2024-07-13 22:37:24','1','2024-07-13 22:37:24',_binary '\0',121),(5791,111,2739,'1','2024-07-13 22:37:24','1','2024-07-13 22:37:24',_binary '\0',122),(5792,111,2740,'1','2024-07-13 22:37:24','1','2024-07-13 22:37:24',_binary '\0',122);
/*!40000 ALTER TABLE `system_role_menu` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `system_schedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `system_schedule` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '日程ID',
  `title` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '标题',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '内容',
  `schedule_date` date NOT NULL COMMENT '日程日期',
  `start_time` time DEFAULT NULL COMMENT '开始时间',
  `end_time` time DEFAULT NULL COMMENT '结束时间',
  `schedule_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '日程类型（字典：schedule_type）',
  `schedule_category` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '日程分类（字典：schedule_category）',
  `creator_id` bigint NOT NULL COMMENT '创建人ID',
  `creator_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '创建人姓名',
  `is_pushed` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否推送（0否 1是）',
  `status` tinyint NOT NULL DEFAULT '0' COMMENT '状态（0开启 1关闭）',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`),
  KEY `idx_schedule_date` (`schedule_date`,`deleted`) USING BTREE,
  KEY `idx_creator_id` (`creator_id`,`deleted`) USING BTREE,
  KEY `idx_tenant_id` (`tenant_id`,`deleted`) USING BTREE,
  KEY `idx_status` (`status`,`deleted`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='日程管理表';
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `system_schedule` WRITE;
/*!40000 ALTER TABLE `system_schedule` DISABLE KEYS */;
/*!40000 ALTER TABLE `system_schedule` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `system_schedule_receiver`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `system_schedule_receiver` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `schedule_id` bigint NOT NULL COMMENT '日程ID',
  `receiver_id` bigint NOT NULL COMMENT '接收人ID',
  `receiver_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '接收人姓名',
  `read_status` tinyint NOT NULL DEFAULT '0' COMMENT '已读状态（0未读 1已读）',
  `read_time` datetime DEFAULT NULL COMMENT '已读时间',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_schedule_receiver` (`schedule_id`,`receiver_id`,`deleted`) USING BTREE,
  KEY `idx_schedule_id` (`schedule_id`,`deleted`) USING BTREE,
  KEY `idx_receiver_id` (`receiver_id`,`deleted`) USING BTREE,
  KEY `idx_tenant_id` (`tenant_id`,`deleted`) USING BTREE,
  KEY `idx_read_status` (`read_status`,`deleted`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='日程接收人关系表';
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `system_schedule_receiver` WRITE;
/*!40000 ALTER TABLE `system_schedule_receiver` DISABLE KEYS */;
/*!40000 ALTER TABLE `system_schedule_receiver` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `system_sms_channel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `system_sms_channel` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `signature` varchar(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '短信签名',
  `code` varchar(63) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '渠道编码',
  `status` tinyint NOT NULL COMMENT '开启状态',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  `api_key` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '短信 API 的账号',
  `api_secret` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '短信 API 的秘钥',
  `callback_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '短信发送回调 URL',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='短信渠道';
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `system_sms_channel` WRITE;
/*!40000 ALTER TABLE `system_sms_channel` DISABLE KEYS */;
INSERT INTO `system_sms_channel` VALUES (2,'Ballcat','ALIYUN',0,'你要改哦，只有我可以用！！！！','LTAI5tCnKso2uG3kJ5gRav88','fGJ5SNXL7P1NHNRmJ7DJaMJGPyE55C',NULL,'','2021-03-31 11:53:10','1','2024-08-04 08:53:26',_binary '\0'),(4,'测试渠道','DEBUG_DING_TALK',0,'123','696b5d8ead48071237e4aa5861ff08dbadb2b4ded1c688a7b7c9afc615579859','SEC5c4e5ff888bc8a9923ae47f59e7ccd30af1f14d93c55b4e2c9cb094e35aeed67',NULL,'1','2021-04-13 00:23:14','1','2022-03-27 20:29:49',_binary '\0'),(7,'mock腾讯云','TENCENT',0,'123','1 2','2 3','','1','2024-09-30 08:53:45','1','2025-12-20 11:30:18',_binary '\0');
/*!40000 ALTER TABLE `system_sms_channel` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `system_sms_code`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `system_sms_code` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `mobile` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '手机号',
  `code` varchar(6) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '验证码',
  `create_ip` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '创建 IP',
  `scene` tinyint NOT NULL COMMENT '发送场景',
  `today_index` tinyint NOT NULL COMMENT '今日发送的第几条',
  `used` tinyint NOT NULL COMMENT '是否使用',
  `used_time` datetime DEFAULT NULL COMMENT '使用时间',
  `used_ip` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '使用 IP',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_mobile` (`mobile`) USING BTREE COMMENT '手机号'
) ENGINE=InnoDB AUTO_INCREMENT=690 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='手机验证码';
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `system_sms_code` WRITE;
/*!40000 ALTER TABLE `system_sms_code` DISABLE KEYS */;
/*!40000 ALTER TABLE `system_sms_code` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `system_sms_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `system_sms_log` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `channel_id` bigint NOT NULL COMMENT '短信渠道编号',
  `channel_code` varchar(63) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '短信渠道编码',
  `template_id` bigint NOT NULL COMMENT '模板编号',
  `template_code` varchar(63) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '模板编码',
  `template_type` tinyint NOT NULL COMMENT '短信类型',
  `template_content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '短信内容',
  `template_params` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '短信参数',
  `api_template_id` varchar(63) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '短信 API 的模板编号',
  `mobile` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '手机号',
  `user_id` bigint DEFAULT NULL COMMENT '用户编号',
  `user_type` tinyint DEFAULT NULL COMMENT '用户类型',
  `send_status` tinyint NOT NULL DEFAULT '0' COMMENT '发送状态',
  `send_time` datetime DEFAULT NULL COMMENT '发送时间',
  `api_send_code` varchar(63) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '短信 API 发送结果的编码',
  `api_send_msg` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '短信 API 发送失败的提示',
  `api_request_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '短信 API 发送返回的唯一请求 ID',
  `api_serial_no` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '短信 API 发送返回的序号',
  `receive_status` tinyint NOT NULL DEFAULT '0' COMMENT '接收状态',
  `receive_time` datetime DEFAULT NULL COMMENT '接收时间',
  `api_receive_code` varchar(63) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'API 接收结果的编码',
  `api_receive_msg` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'API 接收结果的说明',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1549 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='短信日志';
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `system_sms_log` WRITE;
/*!40000 ALTER TABLE `system_sms_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `system_sms_log` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `system_sms_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `system_sms_template` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `type` tinyint NOT NULL COMMENT '模板类型',
  `status` tinyint NOT NULL COMMENT '开启状态',
  `code` varchar(63) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '模板编码',
  `name` varchar(63) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '模板名称',
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '模板内容',
  `params` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '参数数组',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  `api_template_id` varchar(63) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '短信 API 的模板编号',
  `channel_id` bigint NOT NULL COMMENT '短信渠道编号',
  `channel_code` varchar(63) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '短信渠道编码',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='短信模板';
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `system_sms_template` WRITE;
/*!40000 ALTER TABLE `system_sms_template` DISABLE KEYS */;
INSERT INTO `system_sms_template` VALUES (2,1,0,'test_01','测试验证码短信','正在进行登录操作{operation}，您的验证码是{code}','[\"operation\",\"code\"]','测试备注','4383920',4,'DEBUG_DING_TALK','','2021-03-31 10:49:38','1','2024-08-18 11:57:18',_binary '\0'),(3,1,0,'test_02','公告通知','您的验证码{code}，该验证码5分钟内有效，请勿泄漏于他人！','[\"code\"]',NULL,'SMS_207945135',2,'ALIYUN','','2021-03-31 11:56:30','1','2021-04-10 01:22:02',_binary '\0'),(6,3,0,'test-01','测试模板','哈哈哈 {name}','[\"name\"]','f哈哈哈','4383920',4,'DEBUG_DING_TALK','1','2021-04-10 01:07:21','1','2024-08-18 11:57:07',_binary '\0'),(7,3,0,'test-04','测试下','老鸡{name}，牛逼{code}','[\"name\",\"code\"]','哈哈哈哈','suibian',7,'DEBUG_DING_TALK','1','2021-04-13 00:29:53','1','2024-09-30 00:56:24',_binary '\0'),(8,1,0,'user-sms-login','前台用户短信登录','您的验证码是{code}','[\"code\"]',NULL,'4372216',4,'DEBUG_DING_TALK','1','2021-10-11 08:10:00','1','2024-08-18 11:57:06',_binary '\0'),(9,2,0,'bpm_task_assigned','【工作流】任务被分配','您收到了一条新的待办任务：{processInstanceName}-{taskName}，申请人：{startUserNickname}，处理链接：{detailUrl}','[\"processInstanceName\",\"taskName\",\"startUserNickname\",\"detailUrl\"]',NULL,'suibian',4,'DEBUG_DING_TALK','1','2022-01-21 22:31:19','1','2022-01-22 00:03:36',_binary '\0'),(10,2,0,'bpm_process_instance_reject','【工作流】流程被不通过','您的流程被审批不通过：{processInstanceName}，原因：{reason}，查看链接：{detailUrl}','[\"processInstanceName\",\"reason\",\"detailUrl\"]',NULL,'suibian',4,'DEBUG_DING_TALK','1','2022-01-22 00:03:31','1','2022-05-01 12:33:14',_binary '\0'),(11,2,0,'bpm_process_instance_approve','【工作流】流程被通过','您的流程被审批通过：{processInstanceName}，查看链接：{detailUrl}','[\"processInstanceName\",\"detailUrl\"]',NULL,'suibian',4,'DEBUG_DING_TALK','1','2022-01-22 00:04:31','1','2022-03-27 20:32:21',_binary '\0'),(12,2,0,'demo','演示模板','我就是测试一下下','[]',NULL,'biubiubiu',4,'DEBUG_DING_TALK','1','2022-04-10 23:22:49','1','2024-08-18 11:57:04',_binary '\0'),(14,1,0,'user-update-mobile','会员用户 - 修改手机','您的验证码{code}，该验证码 5 分钟内有效，请勿泄漏于他人！','[\"code\"]','','null',4,'DEBUG_DING_TALK','1','2023-08-19 18:58:01','1','2023-08-19 11:34:04',_binary '\0'),(15,1,0,'user-update-password','会员用户 - 修改密码','您的验证码{code}，该验证码 5 分钟内有效，请勿泄漏于他人！','[\"code\"]','','null',4,'DEBUG_DING_TALK','1','2023-08-19 18:58:01','1','2023-08-19 11:34:18',_binary '\0'),(16,1,0,'user-reset-password','会员用户 - 重置密码','您的验证码{code}，该验证码 5 分钟内有效，请勿泄漏于他人！','[\"code\"]','','null',4,'DEBUG_DING_TALK','1','2023-08-19 18:58:01','1','2023-12-02 22:35:27',_binary '\0'),(17,2,0,'bpm_task_timeout','【工作流】任务审批超时','您收到了一条超时的待办任务：{processInstanceName}-{taskName}，处理链接：{detailUrl}','[\"processInstanceName\",\"taskName\",\"detailUrl\"]','','X',4,'DEBUG_DING_TALK','1','2024-08-16 21:59:15','1','2024-08-16 21:59:34',_binary '\0'),(18,1,0,'admin-reset-password','后台用户 - 忘记密码','您的验证码{code}，该验证码 5 分钟内有效，请勿泄漏于他人！','[\"code\"]','','null',4,'DEBUG_DING_TALK','1','2025-03-16 14:19:34','1','2025-03-16 14:19:45',_binary '\0'),(19,1,0,'admin-sms-login','后台用户短信登录','您的验证码是{code}','[\"code\"]','','4372216',4,'DEBUG_DING_TALK','1','2025-04-08 09:36:03','1','2025-04-08 09:36:17',_binary '\0');
/*!40000 ALTER TABLE `system_sms_template` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `system_social_client`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `system_social_client` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '应用名',
  `social_type` tinyint NOT NULL COMMENT '社交平台的类型',
  `user_type` tinyint NOT NULL COMMENT '用户类型',
  `client_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '客户端编号',
  `client_secret` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '客户端密钥',
  `agent_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '代理编号',
  `public_key` varchar(2048) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'publicKey 公钥',
  `status` tinyint NOT NULL COMMENT '状态',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='社交客户端表';
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `system_social_client` WRITE;
/*!40000 ALTER TABLE `system_social_client` DISABLE KEYS */;
INSERT INTO `system_social_client` VALUES (1,'钉钉',20,2,'dingvrnreaje3yqvzhxg','i8E6iZyDvZj51JIb0tYsYfVQYOks9Cq1lgryEjFRqC79P3iJcrxEwT6Qk2QvLrLI',NULL,NULL,0,'','2023-10-18 11:21:18','1','2023-12-20 21:28:26',_binary '',1),(2,'钉钉（王土豆）',20,2,'dingtsu9hpepjkbmthhw','FP_bnSq_HAHKCSncmJjw5hxhnzs6vaVDSZZn3egj6rdqTQ_hu5tQVJyLMpgCakdP',NULL,NULL,0,'','2023-10-18 11:21:18','','2023-12-20 21:28:26',_binary '',121),(3,'微信公众号',31,1,'wx5b23ba7a5589ecbb','2a7b3b20c537e52e74afd395eb85f61f',NULL,NULL,0,'','2023-10-18 16:07:46','1','2023-12-20 21:28:23',_binary '',1),(43,'微信小程序',34,1,'wx63c280fe3248a3e7','6f270509224a7ae1296bbf1c8cb97aed',NULL,NULL,0,'','2023-10-19 13:37:41','1','2023-12-20 21:28:25',_binary '',1),(44,'1',10,1,'2','3',NULL,NULL,0,'1','2025-04-06 20:36:28','1','2025-04-06 20:43:12',_binary '',1),(45,'1',10,1,'2','3',NULL,NULL,1,'1','2025-09-06 20:26:15','1','2025-09-06 20:27:55',_binary '',1),(46,'1',10,1,'2','3',NULL,NULL,0,'1','2025-11-29 16:04:23','1','2025-11-29 16:04:26',_binary '',1),(47,'123',10,1,'1','2','3',NULL,0,'1','2025-12-21 10:27:02','1','2025-12-21 10:27:20',_binary '',1);
/*!40000 ALTER TABLE `system_social_client` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `system_social_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `system_social_user` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键(自增策略)',
  `type` tinyint NOT NULL COMMENT '社交平台的类型',
  `openid` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '社交 openid',
  `token` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '社交 token',
  `raw_token_info` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '原始 Token 数据，一般是 JSON 格式',
  `nickname` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户昵称',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '用户头像',
  `raw_user_info` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '原始用户数据，一般是 JSON 格式',
  `code` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '最后一次的认证 code',
  `state` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '最后一次的认证 state',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='社交用户表';
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `system_social_user` WRITE;
/*!40000 ALTER TABLE `system_social_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `system_social_user` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `system_social_user_bind`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `system_social_user_bind` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键(自增策略)',
  `user_id` bigint NOT NULL COMMENT '用户编号',
  `user_type` tinyint NOT NULL COMMENT '用户类型',
  `social_type` tinyint NOT NULL COMMENT '社交平台的类型',
  `social_user_id` bigint NOT NULL COMMENT '社交用户的编号',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=165 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='社交绑定表';
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `system_social_user_bind` WRITE;
/*!40000 ALTER TABLE `system_social_user_bind` DISABLE KEYS */;
/*!40000 ALTER TABLE `system_social_user_bind` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `system_tenant`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `system_tenant` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '租户编号',
  `name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '租户名',
  `contact_user_id` bigint DEFAULT NULL COMMENT '联系人的用户编号',
  `contact_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '联系人',
  `contact_mobile` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '联系手机',
  `status` tinyint NOT NULL DEFAULT '0' COMMENT '租户状态',
  `websites` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '绑定域名数组',
  `package_id` bigint NOT NULL COMMENT '租户套餐编号',
  `expire_time` datetime NOT NULL COMMENT '过期时间',
  `account_count` int NOT NULL COMMENT '账号数量',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=162 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='租户表';
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `system_tenant` WRITE;
/*!40000 ALTER TABLE `system_tenant` DISABLE KEYS */;
INSERT INTO `system_tenant` VALUES (1,'芋道源码',NULL,'芋艿','17321315478',0,'www.iocoder.cn,127.0.0.1:3000,wxc4598c446f8a9cb3',0,'2099-02-19 17:14:16',9999,'1','2021-01-05 17:03:47','1','2025-08-19 05:18:41',_binary '\0'),(121,'小租户',110,'小王2','15601691300',0,'zsxq.iocoder.cn,123321',111,'2026-07-10 00:00:00',30,'1','2022-02-22 00:56:14','1','2025-08-19 21:19:29',_binary '\0'),(122,'测试租户',113,'芋道','15601691300',0,'test.iocoder.cn,222,333',111,'2023-04-29 00:00:00',50,'1','2022-03-07 21:37:58','1','2025-12-21 09:50:00',_binary '\0');
/*!40000 ALTER TABLE `system_tenant` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `system_tenant_package`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `system_tenant_package` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '套餐编号',
  `name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '套餐名',
  `status` tinyint NOT NULL DEFAULT '0' COMMENT '租户状态（0正常 1停用）',
  `remark` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '备注',
  `menu_ids` varchar(4096) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '关联的菜单编号',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=113 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='租户套餐表';
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `system_tenant_package` WRITE;
/*!40000 ALTER TABLE `system_tenant_package` DISABLE KEYS */;
INSERT INTO `system_tenant_package` VALUES (111,'普通套餐',0,'小功能','[1,2,5,1031,1032,1033,1034,1035,1036,1037,1038,1039,1050,1051,1052,1053,1054,1056,1057,1058,1059,1060,1063,1064,1065,1066,1067,1070,1075,1077,1078,1082,1083,1084,1085,1086,1087,1088,1089,1090,1091,1092,1117,1118,1119,1120,100,101,102,1126,103,1127,1128,1129,106,1130,107,1132,1133,110,1134,111,1135,112,1136,113,1137,2161,114,1138,1139,115,1140,116,1141,1142,1143,1150,1161,1162,1166,1173,1174,2713,2714,1178,2715,2716,2717,2718,2720,2721,1185,2722,1186,1187,2723,1188,2724,1189,2725,1190,2726,1191,2727,1192,2728,2729,1193,1194,2730,1195,2731,2732,1197,2733,1198,2734,1199,2735,1200,1201,1202,2739,2740,1207,1208,1209,2745,1210,2746,1211,2747,1212,2748,1213,1215,1216,1217,1218,1219,1220,2756,1221,2757,1222,1224,1225,1226,1227,1228,1229,1237,1238,2262,1239,1240,1241,1242,1243,2275,2276,2277,1255,1256,1257,2281,1258,2282,1259,2283,1260,2284,2285,2287,2288,2293,2294,2297,2300,2301,2302,2317,2318,2319,2320,2321,2322,2323,2324,2325,2326,2327,2328,2329,2330,2331,2332,2333,2334,2335,2363,2364,5011,5012,2472,2478,2479,2480,2481,2482,2483,2484,2485,2486,2487,2488,2489,2490,2491,2492,2493,2494,2495,2497,2525,1001,1002,1003,1004,1005,1006,1007,1008,1009,1010,1011,1012,1013,2549,1014,2550,1015,2551,1016,2552,1017,2553,1018,2554,1019,2555,1020,2556,2557,2558,2559]','1','2022-02-22 00:54:00','1','2025-09-06 20:52:25',_binary '\0');
/*!40000 ALTER TABLE `system_tenant_package` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `system_user_home_page`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `system_user_home_page` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '关联ID',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `page_id` bigint NOT NULL COMMENT '首页ID',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_user_id` (`user_id`,`deleted`) USING BTREE,
  KEY `idx_page_id` (`page_id`,`deleted`) USING BTREE,
  KEY `idx_tenant_id` (`tenant_id`,`deleted`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户首页关联表';
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `system_user_home_page` WRITE;
/*!40000 ALTER TABLE `system_user_home_page` DISABLE KEYS */;
/*!40000 ALTER TABLE `system_user_home_page` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `system_user_post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `system_user_post` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `user_id` bigint NOT NULL DEFAULT '0' COMMENT '用户ID',
  `post_id` bigint NOT NULL DEFAULT '0' COMMENT '岗位ID',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=130 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户岗位表';
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `system_user_post` WRITE;
/*!40000 ALTER TABLE `system_user_post` DISABLE KEYS */;
INSERT INTO `system_user_post` VALUES (112,1,1,'admin','2022-05-02 07:25:24','admin','2022-05-02 07:25:24',_binary '\0',1),(113,100,1,'admin','2022-05-02 07:25:24','admin','2022-05-02 07:25:24',_binary '\0',1),(115,104,1,'1','2022-05-16 19:36:28','1','2022-05-16 19:36:28',_binary '\0',1),(116,117,2,'1','2022-07-09 17:40:26','1','2022-07-09 17:40:26',_binary '\0',1),(117,118,1,'1','2022-07-09 17:44:44','1','2022-07-09 17:44:44',_binary '\0',1),(119,114,5,'1','2024-03-24 20:45:51','1','2024-03-24 20:45:51',_binary '\0',1),(123,115,1,'1','2024-04-04 09:37:14','1','2024-04-04 09:37:14',_binary '\0',1),(124,115,2,'1','2024-04-04 09:37:14','1','2024-04-04 09:37:14',_binary '\0',1),(125,1,2,'1','2024-07-13 22:31:39','1','2024-07-13 22:31:39',_binary '\0',1),(128,139,2,'1','2025-12-05 21:43:27','1','2025-12-05 21:43:27',_binary '\0',1),(129,139,4,'1','2025-12-05 21:43:27','1','2025-12-05 21:43:27',_binary '\0',1);
/*!40000 ALTER TABLE `system_user_post` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `system_user_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `system_user_role` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '自增编号',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) DEFAULT b'0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户和角色关联表';
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `system_user_role` WRITE;
/*!40000 ALTER TABLE `system_user_role` DISABLE KEYS */;
INSERT INTO `system_user_role` VALUES (1,1,1,'','2022-01-11 13:19:45','','2022-05-12 12:35:17',_binary '\0',1),(2,2,2,'','2022-01-11 13:19:45','','2022-05-12 12:35:13',_binary '\0',1),(5,100,1,'','2022-01-11 13:19:45','','2022-05-12 12:35:12',_binary '\0',1),(6,100,2,'','2022-01-11 13:19:45','','2022-05-12 12:35:11',_binary '\0',1),(10,103,1,'1','2022-01-11 13:19:45','1','2022-01-11 13:19:45',_binary '\0',1),(14,110,109,'1','2022-02-22 00:56:14','1','2022-02-22 00:56:14',_binary '\0',121),(15,111,110,'110','2022-02-23 13:14:38','110','2022-02-23 13:14:38',_binary '\0',121),(16,113,111,'1','2022-03-07 21:37:58','1','2022-03-07 21:37:58',_binary '\0',122),(18,1,2,'1','2022-05-12 20:39:29','1','2022-05-12 20:39:29',_binary '\0',1),(22,115,2,'1','2022-07-21 22:08:30','1','2022-07-21 22:08:30',_binary '\0',1),(35,112,1,'1','2024-03-15 20:00:24','1','2024-03-15 20:00:24',_binary '\0',1),(36,118,1,'1','2024-03-17 09:12:08','1','2024-03-17 09:12:08',_binary '\0',1),(46,117,1,'1','2024-10-02 10:16:11','1','2024-10-02 10:16:11',_binary '\0',1),(47,104,2,'1','2025-01-04 10:40:33','1','2025-01-04 10:40:33',_binary '\0',1),(48,100,155,'1','2025-04-04 10:41:14','1','2025-04-04 10:41:14',_binary '\0',1),(49,142,1,'1','2025-07-23 09:11:42','1','2025-07-23 09:11:42',_binary '\0',1),(50,142,2,'1','2025-10-07 20:50:37','1','2025-10-07 20:50:37',_binary '\0',1),(51,139,1,'1','2025-12-05 22:36:57','1','2025-12-05 22:36:57',_binary '\0',1),(52,139,2,'1','2025-12-05 22:37:00','1','2025-12-05 22:37:00',_binary '\0',1),(53,114,2,'1','2026-01-04 18:15:40','1','2026-01-04 18:15:40',_binary '\0',1),(54,114,3,'1','2026-01-04 18:16:19','1','2026-01-04 18:16:19',_binary '\0',1);
/*!40000 ALTER TABLE `system_user_role` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `system_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `system_users` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `username` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户账号',
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '密码',
  `nickname` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户昵称',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  `dept_id` bigint DEFAULT NULL COMMENT '部门ID',
  `post_ids` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '岗位编号数组',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '用户邮箱',
  `mobile` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '手机号码',
  `sex` tinyint DEFAULT '0' COMMENT '用户性别',
  `avatar` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '头像地址',
  `status` tinyint NOT NULL DEFAULT '0' COMMENT '帐号状态（0正常 1停用）',
  `login_ip` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '最后登录IP',
  `login_date` datetime DEFAULT NULL COMMENT '最后登录时间',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=145 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `system_users` WRITE;
/*!40000 ALTER TABLE `system_users` DISABLE KEYS */;
INSERT INTO `system_users` VALUES (1,'admin','$2a$04$.vd8nPeLwxt6hnSzmAoAyul8BOLX7Cib6QhcxRe30rfvrIPQHH1OG','芋道源码','管理员',103,'[1,2]','13aoteman@126.com','18818260272',1,'http://test.yudao.iocoder.cn/user/avatar/20251220/blob_1766215463801.jpg',0,'0:0:0:0:0:0:0:1','2026-02-14 09:07:33','admin','2021-01-05 17:03:47',NULL,'2026-02-14 09:07:33',_binary '\0',1),(100,'yudao','$2a$04$h.aaPKgO.odHepnk5PCsWeEwKdojFWdTItxGKfx1r0e1CSeBzsTJ6','芋道','不要吓我',104,'[1]','yudao@iocoder.cn','15601691300',1,NULL,0,'0:0:0:0:0:0:0:1','2025-12-15 21:47:26','','2021-01-07 09:07:17',NULL,'2025-12-15 21:47:26',_binary '\0',1),(103,'yuanma','$2a$04$fUBSmjKCPYAUmnMzOb6qE.eZCGPhHi1JmAKclODbfS/O7fHOl2bH6','源码',NULL,106,NULL,'yuanma@iocoder.cn','15601701300',0,NULL,0,'0:0:0:0:0:0:0:1','2024-08-11 17:48:12','','2021-01-13 23:50:35','1','2025-07-09 23:41:58',_binary '\0',1),(104,'test','$2a$04$BrwaYn303hjA/6TnXqdGoOLhyHOAA0bVrAFu6.1dJKycqKUnIoRz2','测试号',NULL,107,'[1,2]','111@qq.com','15601691200',1,NULL,0,'0:0:0:0:0:0:0:1','2026-01-04 18:09:54','','2021-01-21 02:13:53',NULL,'2026-01-04 18:09:54',_binary '\0',1),(107,'admin107','$2a$10$dYOOBKMO93v/.ReCqzyFg.o67Tqk.bbc2bhrpyBGkIw9aypCtr2pm','芋艿',NULL,NULL,NULL,'','15601691300',0,NULL,0,'',NULL,'1','2022-02-20 22:59:33','1','2025-04-21 14:23:08',_binary '\0',118),(108,'admin108','$2a$10$y6mfvKoNYL1GXWak8nYwVOH.kCWqjactkzdoIDgiKl93WN3Ejg.Lu','芋艿',NULL,NULL,NULL,'','15601691300',0,NULL,0,'',NULL,'1','2022-02-20 23:00:50','1','2025-04-21 14:23:08',_binary '\0',119),(109,'admin109','$2a$10$JAqvH0tEc0I7dfDVBI7zyuB4E3j.uH6daIjV53.vUS6PknFkDJkuK','芋艿',NULL,NULL,NULL,'','15601691300',0,NULL,0,'',NULL,'1','2022-02-20 23:11:50','1','2025-04-21 14:23:08',_binary '\0',120),(110,'admin110','$2a$10$mRMIYLDtRHlf6.9ipiqH1.Z.bh/R9dO9d5iHiGYPigi6r5KOoR2Wm','小王',NULL,NULL,NULL,'','15601691300',0,NULL,0,'0:0:0:0:0:0:0:1','2024-07-20 22:23:17','1','2022-02-22 00:56:14',NULL,'2025-04-21 14:23:08',_binary '\0',121),(111,'test','$2a$10$mRMIYLDtRHlf6.9ipiqH1.Z.bh/R9dO9d5iHiGYPigi6r5KOoR2Wm','测试用户',NULL,NULL,'[]','','',0,NULL,0,'0:0:0:0:0:0:0:1','2023-12-30 11:42:17','110','2022-02-23 13:14:33',NULL,'2025-04-21 14:23:08',_binary '\0',121),(112,'newobject','$2a$04$dB0z8Q819fJWz0hbaLe6B.VfHCjYgWx6LFfET5lyz3JwcqlyCkQ4C','新对象',NULL,100,'[]','','15601691235',1,NULL,0,'0:0:0:0:0:0:0:1','2024-03-16 23:11:38','1','2022-02-23 19:08:03',NULL,'2025-04-21 14:23:08',_binary '\0',1),(113,'aoteman','$2a$10$0acJOIk2D25/oC87nyclE..0lzeu9DtQ/n3geP4fkun/zIVRhHJIO','芋道1',NULL,NULL,NULL,'','15601691300',0,NULL,0,'127.0.0.1','2022-03-19 18:38:51','1','2022-03-07 21:37:58','1','2025-05-05 15:30:53',_binary '\0',122),(114,'hrmgr','$2a$10$TR4eybBioGRhBmDBWkqWLO6NIh3mzYa8KBKDDB5woiGYFVlRAi.fu','hr 小姐姐',NULL,NULL,'[5]','','15601691236',1,NULL,0,'0:0:0:0:0:0:0:1','2026-01-04 18:16:01','1','2022-03-19 21:50:58',NULL,'2026-01-04 18:16:01',_binary '\0',1),(115,'aotemane','$2a$04$GcyP0Vyzb2F2Yni5PuIK9ueGxM0tkZGMtDwVRwrNbtMvorzbpNsV2','阿呆','11222',102,'[1,2]','7648@qq.com','15601691229',2,NULL,0,'',NULL,'1','2022-04-30 02:55:43','1','2025-04-21 14:23:08',_binary '\0',1),(117,'admin123','$2a$04$sEtimsHu9YCkYY4/oqElHem2Ijc9ld20eYO6lN.g/21NfLUTDLB9W','测试号02','1111',100,'[2]','','15601691234',1,NULL,0,'0:0:0:0:0:0:0:1','2024-10-02 10:16:20','1','2022-07-09 17:40:26','1','2025-05-14 09:56:04',_binary '\0',1),(118,'goudan','$2a$04$3suGZjnA6rM5bErf38u1felbgqbsPHGdRG3l9NkxPCEt2ah9Y6aJi','狗蛋',NULL,103,'[1]','','15601691239',1,NULL,0,'0:0:0:0:0:0:0:1','2025-11-23 15:28:25','1','2022-07-09 17:44:43',NULL,'2025-11-23 15:28:25',_binary '\0',1),(139,'wwbwwb','$2a$04$FJLIyg8lbPytP29pbZaiU.LesJvCsYfEaHqQfB0pGQhK3e9BeZmLy','小秃头','123',108,'[2,4]','','',1,NULL,0,'0:0:0:0:0:0:0:1','2024-09-10 21:03:58',NULL,'2024-09-10 21:03:58','1','2025-12-15 22:38:15',_binary '\0',1),(141,'admin1','$2a$04$oj6F6d7HrZ70kYVD3TNzEu.m3TPUzajOVuC66zdKna8KRerK1FmVa','新用户',NULL,NULL,NULL,'','',0,'',0,'0:0:0:0:0:0:0:1','2025-04-08 13:09:07','1','2025-04-08 13:09:07','1','2025-05-14 19:11:48',_binary '\0',1),(142,'test01','$2a$04$4bCYWZkjxxOC4QE0LY2M9uEEKWeJbLfs489NFtQoyidL5I0FndRaO','test01','',NULL,'[]','','19021719925',1,'',0,'0:0:0:0:0:0:0:1','2025-07-29 19:47:17','1','2025-07-09 21:07:10',NULL,'2025-12-02 13:23:11',_binary '\0',1),(143,'a00001','$2a$04$GhVHFviOw/SsTmiQtifHJesDYFlHMeGK7OWh7aGCCjGGVCmbHVAwa','a00001',NULL,104,NULL,'','',0,'',0,'0:0:0:0:0:0:0:1','2025-12-01 16:10:13',NULL,'2025-12-01 16:10:13','1','2025-12-05 21:34:05',_binary '\0',1),(144,'aoteman001','$2a$04$omQOmhz8OyUFBKw77nr8KOtMp6xdvoQ1gWStjk9r8.OYT3Bv6oEYe','aoteman001',NULL,116,NULL,'','',0,'',1,'0:0:0:0:0:0:0:1','2025-12-01 17:05:27','1','2025-12-01 17:05:27','1','2025-12-15 15:55:54',_binary '\0',1);
/*!40000 ALTER TABLE `system_users` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `yudao_demo01_contact`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `yudao_demo01_contact` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '名字',
  `sex` tinyint(1) NOT NULL COMMENT '性别',
  `birthday` datetime NOT NULL COMMENT '出生年',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '简介',
  `avatar` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '头像',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='示例联系人表';
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `yudao_demo01_contact` WRITE;
/*!40000 ALTER TABLE `yudao_demo01_contact` DISABLE KEYS */;
INSERT INTO `yudao_demo01_contact` VALUES (1,'土豆',2,'2023-11-07 00:00:00','<p>天蚕土豆！呀</p>','http://127.0.0.1:48080/admin-api/infra/file/4/get/46f8fa1a37db3f3960d8910ff2fe3962ab3b2db87cf2f8ccb4dc8145b8bdf237.jpeg','1','2023-11-15 23:34:30','1','2023-11-15 23:47:39',_binary '\0',1);
/*!40000 ALTER TABLE `yudao_demo01_contact` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `yudao_demo02_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `yudao_demo02_category` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '名字',
  `parent_id` bigint NOT NULL COMMENT '父级编号',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='示例分类表';
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `yudao_demo02_category` WRITE;
/*!40000 ALTER TABLE `yudao_demo02_category` DISABLE KEYS */;
INSERT INTO `yudao_demo02_category` VALUES (1,'土豆',0,'1','2023-11-15 23:34:30','1','2023-11-16 20:24:23',_binary '\0',1),(2,'番茄',0,'1','2023-11-16 20:24:00','1','2023-11-16 20:24:15',_binary '\0',1),(3,'怪怪',0,'1','2023-11-16 20:24:32','1','2023-11-16 20:24:32',_binary '\0',1),(4,'小番茄',2,'1','2023-11-16 20:24:39','1','2023-11-16 20:24:39',_binary '\0',1),(5,'大番茄',2,'1','2023-11-16 20:24:46','1','2023-11-16 20:24:46',_binary '\0',1),(6,'11',3,'1','2023-11-24 19:29:34','1','2023-11-24 19:29:34',_binary '\0',1),(7,'1',0,'1','2025-10-01 09:19:20','1','2025-10-01 09:19:20',_binary '\0',1);
/*!40000 ALTER TABLE `yudao_demo02_category` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `yudao_demo03_course`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `yudao_demo03_course` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `student_id` bigint NOT NULL COMMENT '学生编号',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '名字',
  `score` tinyint NOT NULL COMMENT '分数',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='学生课程表';
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `yudao_demo03_course` WRITE;
/*!40000 ALTER TABLE `yudao_demo03_course` DISABLE KEYS */;
INSERT INTO `yudao_demo03_course` VALUES (2,2,'语文',66,'1','2023-11-16 23:21:49','1','2024-09-17 10:55:30',_binary '',1),(3,2,'数学',22,'1','2023-11-16 23:21:49','1','2024-09-17 10:55:30',_binary '',1),(6,5,'体育',23,'1','2023-11-16 23:22:46','1','2023-11-16 15:44:40',_binary '',1),(7,5,'计算机',11,'1','2023-11-16 23:22:46','1','2023-11-16 15:44:40',_binary '',1),(8,5,'体育',23,'1','2023-11-16 23:22:46','1','2023-11-16 15:47:09',_binary '',1),(9,5,'计算机',11,'1','2023-11-16 23:22:46','1','2023-11-16 15:47:09',_binary '',1),(10,5,'体育',23,'1','2023-11-16 23:22:46','1','2024-09-17 10:55:28',_binary '',1),(11,5,'计算机',11,'1','2023-11-16 23:22:46','1','2024-09-17 10:55:28',_binary '',1),(12,2,'电脑',33,'1','2023-11-17 00:20:42','1','2023-11-16 16:20:45',_binary '',1),(13,9,'滑雪',12,'1','2023-11-17 13:13:20','1','2024-09-17 10:55:26',_binary '',1),(14,9,'滑雪',12,'1','2023-11-17 13:13:20','1','2024-09-17 10:55:49',_binary '',1),(15,5,'体育',23,'1','2023-11-16 23:22:46','1','2024-09-17 18:55:29',_binary '\0',1),(16,5,'计算机',11,'1','2023-11-16 23:22:46','1','2024-09-17 18:55:29',_binary '\0',1),(17,2,'语文',66,'1','2023-11-16 23:21:49','1','2024-09-17 18:55:31',_binary '\0',1),(18,2,'数学',22,'1','2023-11-16 23:21:49','1','2024-09-17 18:55:31',_binary '\0',1),(19,9,'滑雪',12,'1','2023-11-17 13:13:20','1','2025-04-19 02:49:03',_binary '',1),(20,9,'滑雪',12,'1','2023-11-17 13:13:20','1','2025-04-19 10:49:04',_binary '\0',1);
/*!40000 ALTER TABLE `yudao_demo03_course` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `yudao_demo03_grade`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `yudao_demo03_grade` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `student_id` bigint NOT NULL COMMENT '学生编号',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '名字',
  `teacher` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '班主任',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='学生班级表';
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `yudao_demo03_grade` WRITE;
/*!40000 ALTER TABLE `yudao_demo03_grade` DISABLE KEYS */;
INSERT INTO `yudao_demo03_grade` VALUES (7,2,'三年 2 班','周杰伦','1','2023-11-16 23:21:49','1','2024-09-17 18:55:31',_binary '\0',1),(8,5,'华为','遥遥领先','1','2023-11-16 23:22:46','1','2024-09-17 18:55:29',_binary '\0',1),(9,9,'小图','小娃111','1','2023-11-17 13:10:23','1','2025-04-19 10:49:04',_binary '\0',1);
/*!40000 ALTER TABLE `yudao_demo03_grade` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `yudao_demo03_student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `yudao_demo03_student` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '名字',
  `sex` tinyint NOT NULL COMMENT '性别',
  `birthday` datetime NOT NULL COMMENT '出生日期',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '简介',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='学生表';
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `yudao_demo03_student` WRITE;
/*!40000 ALTER TABLE `yudao_demo03_student` DISABLE KEYS */;
INSERT INTO `yudao_demo03_student` VALUES (2,'小白',1,'2023-11-16 00:00:00','<p>厉害</p>','1','2023-11-16 23:21:49','1','2024-09-17 18:55:31',_binary '\0',1),(5,'大黑',2,'2023-11-13 00:00:00','<p>你在教我做事?</p>','1','2023-11-16 23:22:46','1','2024-09-17 18:55:29',_binary '\0',1),(9,'小花',1,'2023-11-07 00:00:00','<p>哈哈哈</p>','1','2023-11-17 00:04:47','1','2025-04-19 10:49:04',_binary '\0',1);
/*!40000 ALTER TABLE `yudao_demo03_student` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

