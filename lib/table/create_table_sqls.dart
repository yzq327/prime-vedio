///数据表定义
class CreateTableSqls {
  //搜索记录表语句
  static final String createTableSqlSearchRecords = '''
    CREATE TABLE IF NOT EXISTS search_records (
    id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE, 
    create_time DateTime,
    content TEXT(100));
    ''';

  //播放历史记录表语句
  static final String createTableSqlVideoPlayRecords = '''
    CREATE TABLE IF NOT EXISTS video_play_record (
    id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,
    create_time DateTime,
    vod_id INTEGER,
    vod_name TEXT(50),
    vod_pic TEXT(300),
    vod_epo TEXT(50),
    watched_duration INTEGER,
    total TEXT(50));
    ''';

  Map<String, String> getAllTables() {
    Map<String, String> map = Map<String, String>();
    map['search_records'] = createTableSqlSearchRecords;
    map['video_play_record'] = createTableSqlVideoPlayRecords;
    return map;
  }
}
