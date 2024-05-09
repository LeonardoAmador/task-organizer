import 'package:sqflite/sqflite.dart';
import 'package:task_organizer/data/task_database.dart';
import 'package:task_organizer/components/task.dart';

class TaskDao {
  static const String _tableName = 'tasks';
  static const String _colId = 'id';
  static const String _colDescription = 'description';
  static const String _colRating = 'rating';
  static const String _colImage = 'image';

  static const String createTableQuery =
      'CREATE TABLE $_tableName($_colId INTEGER PRIMARY KEY, $_colDescription TEXT, $_colRating INTEGER DEFAULT 0, $_colImage TEXT)';

  save(Task task) async {
    final Database db = await TaskDatabase().getDatabase();
    var itemExists = await find(task.taskName);
    Map<String, dynamic> taskMap = _toMap(task);

    if (itemExists.isEmpty) {
      return await db.insert(_tableName, taskMap);
    } else {
      return await db.update(
        _tableName,
        taskMap,
        where: '$_colDescription = ?',
        whereArgs: [task.taskName],
      );
    }
  }

  Future<List<Task>> findAll() async {
    final Database db = await TaskDatabase().getDatabase();
    final List<Map<String, dynamic>> result = await db.query(_tableName);

    return _toList(result);
  }

  Future<List<Task>> find(String taskName) async {
    final Database db = await TaskDatabase().getDatabase();
    final List<Map<String, dynamic>> result = await db.query(_tableName,
        where: '$_colDescription = ?', whereArgs: [taskName]);

    return _toList(result);
  }

  delete(String taskName) async {
    final Database db = await TaskDatabase().getDatabase();

    return db.delete(
      _tableName,
      where: '$_colDescription = ?',
      whereArgs: [taskName],
    );
  }

  List<Task> _toList(List<Map<String, dynamic>> taskList) {
    final List<Task> tasks = [];

    for (Map<String, dynamic> i in taskList) {
      final Task t = Task(
          taskName: i[_colDescription],
          imageUrl: i[_colImage],
          difficultyRating: i[_colRating]);

      tasks.add(t);
    }

    return tasks;
  }

  Map<String, dynamic> _toMap(Task task) {
    final Map<String, dynamic> taskMap = {};

    taskMap[_colDescription] = task.taskName;
    taskMap[_colRating] = task.difficultyRating;
    taskMap[_colImage] = task.imageUrl;

    return taskMap;
  }
}
