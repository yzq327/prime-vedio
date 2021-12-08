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

  //收藏夹表语句
  static final String createTableSqlCollectionsRecords = '''
    CREATE TABLE IF NOT EXISTS my_collections (
    id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,
    create_time DateTime,
    collect_name TEXT(50),
    img TEXT(300));
    ''';

  //收藏夹详情表语句
  static final String createTableSqlCollectionsDetailRecords = '''
    CREATE TABLE IF NOT EXISTS collection_detail (
    id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,
    create_time DateTime,
    collect_id INTEGER,
    vod_id INTEGER,
    vod_name TEXT(50),
    vod_pic TEXT(300),
    FOREIGN KEY(collect_id) REFERENCES my_collections(id)
    );
    ''';

  Map<String, String> getAllTables() {
    Map<String, String> map = Map<String, String>();
    map['search_records'] = createTableSqlSearchRecords;
    map['video_play_record'] = createTableSqlVideoPlayRecords;
    map['my_collections'] = createTableSqlCollectionsRecords;
    map['collection_detail'] = createTableSqlCollectionsDetailRecords;
    return map;
  }
}
