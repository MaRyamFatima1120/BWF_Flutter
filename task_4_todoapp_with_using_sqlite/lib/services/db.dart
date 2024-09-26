import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:task_4_todoapp_with_using_sqlite/views/model.dart';

class DBHelper {
  static Database? _db;

  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDatabase();
    return null;
  }

  initDatabase() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'Todo.db');
    var db = await openDatabase(path, version: 1, onCreate: _createDatabase);
    return db;
  }

  _createDatabase(Database db, int version) async {
    //creating  table in database
    await db.execute(
      "CREATE TABLE mytodo(id INTEGER PRIMARY KEY AUTOINCREMENT,title TEXT NOT NULL,desc TEXT NOT NULL,dateandTime TEXT NOT NULL)",
    );

  }

  //inserting data
  Future<TodoModel> insert (TodoModel todoModel) async{
    var dbClient =await db;
    await dbClient?.insert('mytodo', todoModel.toMap());
    return todoModel;
  }

  Future<List<TodoModel>> getDataList() async{
    await db;
    final List<Map <String,Object?>> QueryResult =await _db!.rawQuery('SELECT * FROM mytodo'
        );
    return QueryResult.map((e)=>TodoModel.fromMap(e)).toList();
  }

  Future<int>delete(int id) async{
    var dbClient =await db;
    return await dbClient!.delete('mytodo',where: 'id = ? ',whereArgs: [id]);

  }

  Future<int> update(TodoModel todoModel) async{
    var dbClient =await db;
  return await dbClient!.update('mytodo', todoModel.toMap(),where:'id=?',whereArgs: [todoModel.id]);
}


}
