import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'create_table_sqls.dart';
import 'db_name.dart';

class TablesInit {
  late Database db;
  int _databaseVersion = 1;

  Future init() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, CommonDBText.DB_NAME);
    print('数据库存储路径path:' + path);
    CreateTableSqls sqlTables = CreateTableSqls();
    Map<String, String> allTableSqls = sqlTables.getAllTables();
    try {
      db = await openDatabase(path);
    } catch (e) {
      print('CreateTables init Error $e');
    }
    //检查需要生成的表
    List<String> noCreateTables = await getNoCreateTables(allTableSqls);
    print('noCreateTables:' + noCreateTables.toString());
    if (noCreateTables.length > 0) {
      //创建新表
      // 关闭上面打开的db，否则无法执行open
      db.close();
      db = await openDatabase(
          path,
          version: _databaseVersion,
          onCreate: (Database db, int version) async {
            print('db created version is $version');
          },
          onOpen: (Database db) async {
            noCreateTables.forEach((sql) async {
              await db.execute(allTableSqls[sql] ?? '');
            });
          },
          onConfigure: (Database db) async {
            await db.execute('PRAGMA foreign_keys = ON');
          });
    } else {
      print("表都存在，db已打开");
    }
    List tableMaps = await db.rawQuery(
        'SELECT name FROM sqlite_master WHERE type = "table"');
    db.close();
    print("db已关闭");
  }

  // 检查数据库中是否有所有有表,返回需要创建的表
  Future<List<String>> getNoCreateTables(Map<String, String> tableSqls) async {
    Iterable<String> tableNames = tableSqls.keys;
    List<String> existingTables = [];
    List<String> createTables = [];
    List tableMaps = await db.rawQuery(
        'SELECT name FROM sqlite_master WHERE type = "table"');
    print('tableMaps:' + tableMaps.toString());
    tableMaps.forEach((item) {
      existingTables.add(item['name']);
    });
    tableNames.forEach((tableName) {
      if (!existingTables.contains(tableName)) {
        createTables.add(tableName);
      }
    });
    return createTables;
  }

}
