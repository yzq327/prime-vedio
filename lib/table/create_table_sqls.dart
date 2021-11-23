///数据表定义
class CreateTableSqls {
  //搜索记录表语句
  static final String createTableSql_search = '''
    CREATE TABLE IF NOT EXISTS search (
    id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE, 
    content TEXT(100));
    ''';

  Map<String, String> getAllTables() {
    Map<String, String> map = Map<String, String>();
    map['search'] = createTableSql_search;
    return map;
  }
}
