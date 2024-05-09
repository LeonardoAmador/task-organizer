import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:task_organizer/models/task_dao.dart';

class TaskDatabase {
  static const String tableName = 'tasks';

  Future<Database> getDatabase() async {
    final String path = join(await getDatabasesPath(), 'task.db');

    return openDatabase(path, onCreate: (db, version) {
      db.execute(TaskDao.createTableQuery);
    }, version: 1);
  }
}