"""从 *DO.java 解析出每张表应有的列，用于校验数据库或生成建表语句。"""
import os
import re
import sys

BASE_FIELDS = {
    'BaseDO': [('create_time', 'LocalDateTime'), ('update_time', 'LocalDateTime'),
               ('creator', 'String'), ('updater', 'String'), ('deleted', 'Boolean')],
}
BASE_FIELDS['TenantBaseDO'] = BASE_FIELDS['BaseDO'] + [('tenant_id', 'Long')]


def snake(name):
    return re.sub(r'(?<=[a-z0-9])([A-Z])', r'_\1', name).lower()


def parse_do(path):
    src = open(path, encoding='utf-8').read()
    m = re.search(r'@TableName\(\s*(?:value\s*=\s*)?"([A-Za-z0-9_]+)"', src)
    if not m:
        return None
    table = m.group(1)
    cls = re.search(r'class\s+(\w+)(?:<[^>]*>)?(?:\s+extends\s+(\w+))?', src)
    parent = cls.group(2) if cls else None
    body = src[cls.end():]
    body = re.sub(r'/\*.*?\*/', '', body, flags=re.S)
    body = re.sub(r'//[^\n]*', '', body)
    cols, pk = [], None
    pending = ''
    for line in body.split('\n'):
        s = line.strip()
        if s.startswith('@'):
            pending += ' ' + s
            continue
        fm = re.match(r'private\s+(?!static)(?!final)(?:transient\s+)?([\w.<>, ?\[\]]+?)\s+(\w+)\s*(=[^;]*)?;', s)
        if fm:
            ann = pending
            pending = ''
            if 'exist = false' in ann or 'exist=false' in ann or 'transient' in s:
                continue
            jt, name = fm.group(1).strip(), fm.group(2)
            cm = re.search(r'@TableField\(\s*(?:value\s*=\s*)?"`?(\w+)`?"', ann)
            col = cm.group(1) if cm else snake(name)
            handler = 'typeHandler' in ann
            if '@TableId' in ann:
                pk = col
            cols.append((col, jt, handler))
        elif s and not s.startswith('@'):
            pending = ''
    return {'table': table, 'parent': parent, 'cols': cols, 'pk': pk or 'id', 'path': path}


def scan(roots):
    out = {}
    for root in roots:
        for d, _, files in os.walk(root):
            if '/test/' in d:
                continue
            for f in files:
                if f.endswith('DO.java'):
                    info = parse_do(os.path.join(d, f))
                    if info:
                        for c, t in BASE_FIELDS.get(info['parent'], []):
                            if c not in [x[0] for x in info['cols']]:
                                info['cols'].append((c, t, False))
                        out[info['table']] = info
    return out


JAVA_TO_MYSQL = {
    'Long': 'BIGINT', 'Integer': 'INT', 'Short': 'SMALLINT', 'Byte': 'TINYINT',
    'Boolean': "BIT(1)", 'BigDecimal': 'DECIMAL(24,6)', 'Double': 'DOUBLE', 'Float': 'FLOAT',
    'LocalDateTime': 'DATETIME', 'LocalDate': 'DATE', 'LocalTime': 'TIME', 'Date': 'DATETIME',
    'String': 'VARCHAR(255)',
}
BASE_COL_DDL = {
    'creator': "VARCHAR(64) NULL DEFAULT '' COMMENT '创建者'",
    'create_time': "DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间'",
    'updater': "VARCHAR(64) NULL DEFAULT '' COMMENT '更新者'",
    'update_time': "DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间'",
    'deleted': "BIT(1) NOT NULL DEFAULT b'0' COMMENT '是否删除'",
    'tenant_id': "BIGINT NOT NULL DEFAULT 0 COMMENT '租户编号'",
}


def ddl(info):
    lines = []
    for col, jt, handler in info['cols']:
        if col == info['pk']:
            lines.append(f"  `{col}` BIGINT NOT NULL AUTO_INCREMENT COMMENT '编号'")
        elif col in BASE_COL_DDL:
            lines.append(f"  `{col}` {BASE_COL_DDL[col]}")
        else:
            t = 'VARCHAR(2000)' if handler or '<' in jt else JAVA_TO_MYSQL.get(jt, 'VARCHAR(255)')
            lines.append(f"  `{col}` {t} NULL")
    lines.append(f"  PRIMARY KEY (`{info['pk']}`)")
    return (f"DROP TABLE IF EXISTS `{info['table']}`;\nCREATE TABLE `{info['table']}` (\n" + ',\n'.join(lines)
            + "\n) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;\n")


def main():
    import argparse
    ap = argparse.ArgumentParser()
    ap.add_argument('roots', nargs='+', help='模块目录，如 yudao-module-oa')
    ap.add_argument('--ddl', nargs='*', help='为这些表生成建表语句')
    ap.add_argument('--check', help='数据库列清单文件（每行: 表名<TAB>列名[<TAB>是否必填且无默认值 1/0]），'
                                    '输出缺失的表和列，以及实体类里没有、插入时必然报错的必填列')
    a = ap.parse_args()
    tables = scan(a.roots)
    if a.ddl is not None:
        print('SET NAMES utf8mb4;\n')
        for t in a.ddl:
            print(ddl(tables[t]))
    elif a.check:
        db, required = {}, {}
        for line in open(a.check, encoding='utf-8'):
            if '\t' in line:
                t, c, *flag = line.rstrip('\n').split('\t')
                db.setdefault(t, set()).add(c.lower())
                if flag and flag[0] == '1':
                    required.setdefault(t, []).append(c.lower())
        bad = 0
        for t, i in sorted(tables.items()):
            if t not in db:
                print(f'缺表  {t}  ({i["path"]})')
                bad += 1
                continue
            miss = [c for c, _, _ in i['cols'] if c.lower() not in db[t]]
            if miss:
                print(f'缺列  {t}: {", ".join(miss)}')
                bad += 1
            cols = {c.lower() for c, _, _ in i['cols']}
            extra = [c for c in required.get(t, []) if c not in cols]
            if extra:
                print(f'必填列实体类里没有（插入会报 doesn\'t have a default value）  {t}: {", ".join(extra)}')
                bad += 1
        print(f'共 {len(tables)} 张表，{bad} 张有问题')
        sys.exit(1 if bad else 0)
    else:
        for t, i in sorted(tables.items()):
            print(t, i['parent'], ','.join(c for c, _, _ in i['cols']))


if __name__ == '__main__':
    main()
