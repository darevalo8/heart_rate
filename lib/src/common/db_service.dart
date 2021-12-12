import 'package:path/path.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:sqflite/sqflite.dart';
//import 'package:global_configuration/global_configuration.dart';

class DBProvider {
  static Database? _database;
  static final DBProvider db = DBProvider._();
  DBProvider._();
  Future<Database?> get database async {
    if (_database != null) return _database;

    _database = await initDB();
    return _database;
  }

  // this opens the database (and creates it if it doesn't exist)
  initDB() async {
    String documentsDirectory = await getDatabasesPath();
    //   print(documentsDirectory);
    String path = join(documentsDirectory, 'heart_rate.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {


    await db.execute('''CREATE TABLE anomaly(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    status INTEGER(2) default 0, is_bradycardia INTEGER(2) default 0, 
    is_tachycardia INTEGER(2) default 0, 
    create_at  VARCHAR(50));
    ''');

    await db.execute('''CREATE TABLE anomaly_detail(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    tiene_marcapaso INTEGER(2) default 0, hormona_tirodea INTEGER(2) default 0, 
    tiene_fatiga INTEGER(2) default 0,anomalyid INTEGER,
    tiene_mareo INTEGER(2) default 0, tuvo_desmayo INTEGER(2) default 0, 
    tiene_ansiedad INTEGER(2) default 0, tuvo_angustia INTEGER(2) default 0, 
    bebe_cafina INTEGER(2) default 0, bebe_alcohol INTEGER(2) default 0, 
    fuma INTEGER(2) default 0, dolor_pecho INTEGER(2) default 0, 
    dificultad_respirar INTEGER(2) default 0, hace_ejericio INTEGER(2) default 0, 
    create_at  VARCHAR(50),FOREIGN KEY(anomalyid) REFERENCES anomaly(id)
    );
    ''');
  }

  // Helper methods

  // Inserts a row in the database where each key in the Map is a column name
  // and the value is the column value. The return value is the id of the
  // inserted row.
  Future<int> insert(String table, Map<String, dynamic> row) async {
    final db = await database;
    return await db!.insert(table, row);
  }

  // All of the rows are returned as a list of maps, where each map is
  // a key-value list of columns.
  Future<List<Map<String, dynamic>>> queryAllRows(String table) async {
    final db = await database;
    return await db!.query(table);
  }

  Future<List<Map<String, dynamic>>> selectQuery(
      String table, String columnId, String id) async {
    final db = await database;
    final response =
        await db!.query(table, where: '$columnId = ?', whereArgs: [id]);
    return response;
  }

  // All of the methods (insert, query, update, delete) can also be done using
  // raw SQL commands. This method uses a raw query to give the row count.
  // Future<int> queryRowCount(String table) async {
  //   final db = await database;
  //   return Sqflite.firstIntValue(
  //       await db!.rawQuery('SELECT COUNT(*) FROM $table'));
  // }
  Future<List<Map<String, dynamic>>> selectFirstFive(String table) async {
    final db = await database;
    return await db!.rawQuery('SELECT * FROM $table order by fecha limit 5');
  }
  Future<List<Map<String, dynamic>>> selectOrderAll(String table) async {
    final db = await database;
    return await db!.rawQuery('SELECT * FROM $table order by create_at desc');
  }

  // We are assuming here that the id column in the map is set. The other
  // column values will be used to update the row.
  Future<int> update(
      String table, String columnId, Map<String, dynamic> row) async {
    final db = await database;
    final id = row[columnId];
    return await db!
        .update(table, row, where: '$columnId = ?', whereArgs: [id]);
  }

  // Deletes the row specified by the id. The number of affected rows is
  // returned. This should be 1 as long as the row exists.
  Future<int> delete(String table, String columnId, String id) async {
    final db = await database;
    return await db!.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> deleteAll(String table) async {
    final db = await database;
    return await db!.delete(table);
  }
}
