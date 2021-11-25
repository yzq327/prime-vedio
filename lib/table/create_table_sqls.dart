///数据表定义
class CreateTableSqls {
  //搜索记录表语句
  static final String createTableSql_search_records = '''
    CREATE TABLE IF NOT EXISTS search_records (
    id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE, 
    create_time DateTime,
    content TEXT(100));
    ''';

  Map<String, String> getAllTables() {
    Map<String, String> map = Map<String, String>();
    map['search_records'] = createTableSql_search_records;
    return map;
  }
}
