import 'package:myapp/Models/Device.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DeviceRepository {
  static const String tableName = 'devices';
  Future<Database> _openDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'devices_database.db');

    return openDatabase(path, onCreate: (db, version) {
      return db.execute('''
        create table $tableName(
          id integer primary key autoincrement,
          name text,
          number text,
          password text,
          moveTime integer,
          autoCloseTime integer
        )''');
    }, version: 1);
  }

  Future<int> insertDevice(Device device) async {
    final db = await _openDatabase();
    return await db.insert(tableName, device.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future getAllDevices() async {
    final db = await _openDatabase();

    final List<Map<String, dynamic>> maps = await db.query(tableName);

    return List.generate(maps.length, (i) {
      return Device.fromMap(maps[i]);
    });
  }

  Future<int> updateDevice(Device device) async {
    final db = await _openDatabase();

    return db.update(tableName, device.toMap(),
        where: 'id = ?', whereArgs: [device.id]);
  }

  Future<int> deleteDevice(int? id) async {
    final db = await _openDatabase();

    return db.delete(tableName, where: 'id = ?', whereArgs: [id]);
  }

  Future<Device?> getById(int? id) async {
    final db = await _openDatabase();

    final List<Map<String, dynamic>> results =
        await db.query(tableName, where: 'id=?', whereArgs: [id]);

    if (results.isNotEmpty) {
      return Device.fromMap(results.first);
    } else {
      return null;
    }
  }
}
