import 'package:maintenance/domain/entities/notification.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

import '../../../utils/toast.dart';
import '../notify_repository.dart';

class DbHelper extends NotifyRepository {
  static Database? _database;
  static const int _version = 1;
  static const String _tableName = 'notifications';
  static initDb() async {
    if (_database != null) return;
    try {
      var dbPath = await getDatabasesPath();
      String path = p.join(dbPath, 'notification.db');
      _database = await openDatabase(
        path,
        version: _version,
        onCreate: (db, version) async {
          await db.execute('''
              CREATE TABLE $_tableName (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                careId STRING,
                memoName TEXT,
                dateTime STRING,
                seen INTEGER
              )
              ''');
        },
      );
    } catch (e) {
      toastInfo(msg: e.toString());
    }
  }

  @override
  Future<List<NotificationModel>> getAll() async {
    List<Map<String, dynamic>> notifys =
        await _database!.query(_tableName, orderBy: 'id DESC');
    var notifyList =
        notifys.map((data) => NotificationModel.fromJson(data)).toList();
    return notifyList;
  }

  @override
  Future<int?> insertNotify(NotificationModel? model) async {
    return await _database?.insert(_tableName, model!.toJson());
  }

  @override
  Future<int> updateSeen(int id) async {
    return await _database!.rawUpdate('''
        UPDATE $_tableName
        SET seen = ?
        WHERE id = ?
      ''', [
      1,
      id,
    ]);
  }
}
