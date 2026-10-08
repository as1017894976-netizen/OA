# 数据库初始化

开源版的主脚本 `sql/mysql/ruoyi-vue-pro.sql` 只有系统、基建的 48 张表，流程（BPM）、OA、人力、资产、仓储的表和菜单
散落在各模块的 `src/main/resources/sql/` 里，部分还缺失或有错。这里把它们整理成一个可直接导入的完整脚本。

## 新装：直接导入

```sql
CREATE DATABASE `ruoyi-office` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
```

```bash
mysql -uroot -p --default-character-set=utf8mb4 ruoyi-office < sql/mysql/ruoyi-office-init.sql
```

导入后用 `admin / admin123` 登录。流程引擎 Flowable 的 `ACT_*` 表在后端首次启动时自动创建
（`flowable.database-schema-update: true`）。用车、用印、会议室、人事单据的审批流程需要在
「工作流程 → 流程模型」里按 `OaBillTypeEnum` 等枚举中的流程 key（如 `oa_car_apply_bill`）建模并发布。

## 重新生成

改了任何模块的 SQL 后，重新生成 `ruoyi-office-init.sql`：

```bash
script/db-init/build.sh            # 需要本机 MySQL 8（默认 127.0.0.1:3306 root/123456），会重建 ruoyi-office-build 库
```

`build.sh` 会：

1. 按 `script/db-init/files.txt` 的顺序导入主脚本、本目录的补丁和各模块 SQL；
2. 用 `script/db-init/do_schema.py --check` 对比所有 `*DO.java` 与数据库，缺表或缺字段即报错；
3. 用 `mysqldump` 导出为 `sql/mysql/ruoyi-office-init.sql`。

## 本目录的补丁

| 文件 | 内容 | 来源 |
|---|---|---|
| `01_bpm_tables.sql` | 流程分类、表单、流程定义扩展、抄送、用户组、监听器、表达式等 8 张表 | `script/db-init/pdma_to_mysql.py` 从 `sql/ruoyi-office/ruoyi-office.pdma.json` 生成 |
| `02_oa_car_tables.sql` | 车辆、用车申请单、还车申请单 | 同上 |
| `03_asset_wms_tables.sql` | 资产、仓储 10 张表（仓库里没有任何建表语句） | `script/db-init/do_schema.py --ddl` 从实体类生成，字段类型是推断的 |
| `04_common_attachment.sql` | 通用附件表 | 取自 `common_attachment_migration.sql` 第 1 步 |
| `80_missing_columns.sql` | 实体类有、建表脚本漏掉的 6 个字段 | 手写 |
| `90_menu_fixup.sql` | 按前端页面路径重建「OA协同办公」「人力资源管理」菜单（id 6000~6299） | `script/db-init/gen_menu_fixup.py` 生成 |
