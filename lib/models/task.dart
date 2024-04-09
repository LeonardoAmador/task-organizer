class Task {
  static const String _tableName = 'tasks';
  static const String _colId = 'id';
  static const String _colDescription = 'description';
  static const String _colRating = 'rating';
  static const String _colImage = 'image';

  static const String createTableQuery =
      'CREATE TABLE $_tableName($_colId INTEGER PRIMARY KEY, $_colDescription TEXT, $_colRating INTEGER DEFAULT 0, $_colImage TEXT)';

  save(Task task) async {}

  Future<List<Task>> findAll() async {}

  Future<List<Task>> find(String taskName) async {}

  delete(String taskName) async {}
}
