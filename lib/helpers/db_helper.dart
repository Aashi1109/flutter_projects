import 'package:sqflite/sqflite.dart' as sqlite;
import 'package:path/path.dart' as path;

class DbHelper {
  static Future<sqlite.Database> getDatabase() async {
    final dbPath = await sqlite.getDatabasesPath();
    return sqlite.openDatabase(
      path.join(dbPath, 'places.db'),
      version: 1,
      onCreate: (db, version) => db.execute(
        'CREATE TABLE Places (id TEXT PRIMARY KEY, title TEXT, image TEXT, loc_lat REAL, loc_long REAL, address TEXT)',
      ),
    );
  }

  static Future<void> insertData(String table, Map<String, Object> data) async {
    final sqlDb = await DbHelper.getDatabase();

    await sqlDb.insert(
      table,
      data,
      conflictAlgorithm: sqlite.ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, Object?>>> fetchData(String table) async {
    final sqlDb = await DbHelper.getDatabase();
    return sqlDb.query(table);
  }
}
