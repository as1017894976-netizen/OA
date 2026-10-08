#!/usr/bin/env bash
# 把主脚本 + 各模块 SQL 按 files.txt 的顺序导入一个全新的库，校验表结构，再导出为一个完整的初始化脚本。
#
# 用法: script/db-init/build.sh [输出文件]
# 环境变量: MYSQL（默认 "mysql -h127.0.0.1 -uroot -p123456"）、MYSQLDUMP、DB（默认 ruoyi-office-build）
set -euo pipefail
cd "$(dirname "$0")/../.."

MYSQL=${MYSQL:-"mysql -h127.0.0.1 -P3306 -uroot -p123456"}
MYSQLDUMP=${MYSQLDUMP:-"mysqldump -h127.0.0.1 -P3306 -uroot -p123456"}
DB=${DB:-ruoyi-office-build}
OUT=${1:-sql/mysql/ruoyi-office-init.sql}
LOG=$(mktemp)

$MYSQL -e "DROP DATABASE IF EXISTS \`$DB\`; CREATE DATABASE \`$DB\` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;" 2>/dev/null

grep -vE '^\s*(#|$)' script/db-init/files.txt | while read -r line; do
  # "? 文件" 表示增量变更脚本：其中的字段/索引可能已包含在建表语句里，
  # 允许"重复字段(1060)/重复索引(1061)/字段不存在(1091)"错误，其它错误仍然中止。
  tolerant=0; f=$line
  if [[ $line == "? "* ]]; then tolerant=1; f=${line#? }; fi
  echo ">> $f"
  # 部分脚本写死了库名 `ruoyi-office`.，去掉后统一导入到 $DB
  if [[ $tolerant == 1 ]]; then
    sed 's/`ruoyi-office`\.//g' "$f" | $MYSQL --force --default-character-set=utf8mb4 "$DB" >/dev/null 2>"$LOG.err" || true
    if grep -E '^ERROR' "$LOG.err" | grep -vqE '^ERROR (1060|1061|1091) '; then
      grep -v 'Using a password' "$LOG.err" >&2; echo "执行失败: $f" >&2; exit 1
    fi
  elif ! sed 's/`ruoyi-office`\.//g' "$f" | $MYSQL --default-character-set=utf8mb4 "$DB" >/dev/null 2>"$LOG.err"; then
    grep -v 'Using a password' "$LOG.err" >&2; echo "执行失败: $f" >&2; exit 1
  fi
done

echo ">> 校验实体类与表结构"
$MYSQL -N -e "SELECT table_name, column_name, is_nullable = 'NO' AND column_default IS NULL AND extra NOT LIKE '%auto_increment%'
  FROM information_schema.columns WHERE table_schema='$DB'" 2>/dev/null > "$LOG.cols"
python3 -I script/db-init/do_schema.py \
  yudao-framework yudao-module-system yudao-module-infra yudao-module-bpm yudao-module-oa \
  yudao-module-hrm yudao-module-asset yudao-module-wms --check "$LOG.cols"

echo ">> 导出到 $OUT"
{
  echo "-- RuoYi Office（开源版）完整初始化脚本，由 script/db-init/build.sh 生成，请勿手工修改。"
  echo "-- 包含：系统/基建/流程/OA/人力/资产/仓储模块的表结构、菜单与字典。"
  echo "-- 用法：CREATE DATABASE \`ruoyi-office\` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci; 然后导入本文件。"
  $MYSQLDUMP --default-character-set=utf8mb4 --skip-dump-date --skip-comments --single-transaction \
    --set-gtid-purged=OFF --no-tablespaces "$DB" 2>/dev/null
} > "$OUT"
rm -f "$LOG" "$LOG.err" "$LOG.cols"
echo "完成: $OUT ($(wc -c < "$OUT") 字节)"
