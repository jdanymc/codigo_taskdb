import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBAdmin {
  Database? myDatabase;

  //Singleton
  static final DBAdmin db = DBAdmin._();
  DBAdmin._();

  Future<Database?> checkDatabase() async {
    //print(myDatabase);
    // if (myDatabase != null) {
    //   return myDatabase;
    // }
    myDatabase = await initDatabase(); //crear base de datos
    return myDatabase;
  }

  Future<void> deleteDatabase(String path) =>
      databaseFactory.deleteDatabase(path);

  Future<Database> initDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, "TaskDB.db");

    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database dbx, int version) async {
      await dbx.execute(
          "CREATE TABLE TASK (id INTEGER PRIMARY KEY AUTOINCREMENT,title TEXT, description TEXT, status TEXT)");
    });
  }

  insertRawTask() async {
    Database? db = await checkDatabase();
    int res = await db!.rawInsert(
        "INSERT INTO TASK(title, description,status) values('Ir de compras','Tenemos que ir a Totfus','false')");
    print(res);
  }

  insertTask() async {
    /* Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, "TaskDB.db");
    deleteDatabase(path);*/

    Database? db = await checkDatabase();
    int res = await db!.insert("TASK", {
      "title": "Comparar el nuevo disco",
      "description": "Nuevo disco de Epica",
      "status": "false",
    });

    print(res);
  }

  getRawTasks() async {
    Database? db = await checkDatabase();
    List tasks = await db!.rawQuery("SELECT * FROM Task");

    print(tasks);
  }

  Future<List<Map<String, dynamic>>> getTasks() async {
    Database? db = await checkDatabase();
    List<Map<String, dynamic>> tasks = await db!.query("Task");
    return tasks;
  }

  updateRawTask() async {
    Database? db = await checkDatabase();
    db!.rawUpdate("UPDATE TASK SET title = ',description='', status=''");
  }

  updateTask() async {
    Database? db = await checkDatabase();
    int res = await db!.update(
        "task",
        {
          "title": "Ir al cine",
          "description": "Es el viernes en la tarde",
          "status": "false",
        },
        where: "id=2");
  }

  deleteRawTask() async {
    Database? db = await checkDatabase();
    int res = await db!.rawDelete("DELETE FROM Task WHERE id=2");
    print(res);
  }

  deleteTask() async {
    Database? db = await checkDatabase();
    int res = await db!.delete("TASK", where: "id=3");
    print(res);
  }
}
