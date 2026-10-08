"""把 sql/ruoyi-office/ruoyi-office.pdma.json 中指定的表导出为 MySQL 建表语句。

用法: python3 pdma_to_mysql.py <pdma.json> <表名前缀或表名>...
"""
import json
import sys

LEN_TYPES = {'VARCHAR', 'CHAR', 'VARBINARY', 'BINARY'}
SCALE_TYPES = {'DECIMAL', 'NUMERIC'}


MYSQL_ID = '29D1CE08-4C35-4D2D-AAA9-23D93305B52E'
DOMAINS, BASE_TYPES = {}, {}


def col_type(f):
    t, ln, sc = f.get('type'), f.get('len'), f.get('scale')
    if not t:
        # 字段未直接写类型时，按 domain -> baseType -> MySQL 映射解析
        dom = DOMAINS.get(f.get('domain') or '')
        base = f.get('baseType') or (dom or {}).get('applyFor')
        t = BASE_TYPES.get(base, 'VARCHAR')
        if ln in (None, '') and dom:
            ln = dom.get('len')
    t = t.upper()
    if t in LEN_TYPES:
        return f'{t}({ln or 255})'
    if t in SCALE_TYPES:
        return f'{t}({ln or 10},{sc if sc not in (None, "") else 2})'
    return t


def default_clause(f):
    dv = f.get('defaultValue')
    if dv in (None, ''):
        return ''
    dv = str(dv)
    if dv.upper() in ('NULL', 'CURRENT_TIMESTAMP') or dv.startswith("'") or dv.startswith("b'") or dv.replace('.', '', 1).lstrip('-').isdigit():
        return f' DEFAULT {dv}'
    if dv.upper().startswith('CURRENT_TIMESTAMP'):
        return f' DEFAULT {dv}'
    return " DEFAULT '" + dv.replace("'", "''") + "'"


def esc(s):
    return (s or '').replace("'", "''")


def ddl(e):
    lines, pks = [], []
    for f in e['fields']:
        s = f"  `{f['defKey']}` {col_type(f)}"
        # PDMA 里不少业务字段标了非空却没有默认值，而代码插入时并不总会赋值（例如流程分类的描述），
        # 这类字段按可空处理，避免 "Field 'xxx' doesn't have a default value"
        has_default = default_clause(f) != ''
        not_null = f.get('primaryKey') or (f.get('notNull') and has_default)
        s += ' NOT NULL' if not_null else ' NULL'
        if f.get('autoIncrement'):
            s += ' AUTO_INCREMENT'
        s += default_clause(f)
        comment = f.get('defName') or f.get('comment')
        if comment:
            s += f" COMMENT '{esc(comment)}'"
        lines.append(s)
        if f.get('primaryKey'):
            pks.append(f"`{f['defKey']}`")
    if pks:
        lines.append(f"  PRIMARY KEY ({', '.join(pks)})")
    name = e['defKey']
    return (f"DROP TABLE IF EXISTS `{name}`;\nCREATE TABLE `{name}` (\n" + ',\n'.join(lines)
            + f"\n) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='{esc(e.get('defName'))}';\n")


def main():
    pdma = json.load(open(sys.argv[1], encoding='utf-8'))
    wanted = sys.argv[2:]
    DOMAINS.update({d['id']: d for d in pdma['domains']})
    BASE_TYPES.update({m['id']: m[MYSQL_ID] for m in pdma['dataTypeMapping']['mappings']})
    print('SET NAMES utf8mb4;\n')
    for e in sorted(pdma['entities'], key=lambda x: x['defKey']):
        if any(e['defKey'] == w or (w.endswith('*') and e['defKey'].startswith(w[:-1])) for w in wanted):
            print(ddl(e))


if __name__ == '__main__':
    main()
