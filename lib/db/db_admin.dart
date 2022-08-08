import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class DBAdmin {
  Database? myDatabase;

  //singleton => utilizar la base de forma general
  static final DBAdmin db = DBAdmin._();
  DBAdmin._();
  //

  //gestior de construir a base de datos
  Future<Database?> checkDatabase() async {
    //si no existe la base de datos crear
    if (myDatabase != null) {
      return myDatabase;
    }
    //caso contrario que lo cree la base de datos
    //crear una base de datos
    myDatabase = await initDataBase();
    return myDatabase;
  }

  //otra funcion
  Future<Database> initDataBase() async {
    Directory directory = await getApplicationDocumentsDirectory();

    //crear la base de datos taskDB.db en directory
    String path = join(directory.path, "TaskDB.db");

    //crear la base de datos (video semana 9 ->3)
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database dbx, int version) async {
      //crear la table correspondiente
      await dbx.execute(
          "CREATE TABLE TASK(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, descripcion TEXT, status TEXT)");
    });
  }

//inserciones 1ra opcion
  insertRawTask() async {
    //1 chekear si existe base de datos
    Database? db = await checkDatabase();

    // no debe ser nulo =>db!.rawInsert
    int res = await db!.rawInsert(
        "INSERT INTO TASK(title,descripcion,status) values ('ir de compras','tenemos que ir a totus','false')");

    print(res);
  }

//inserciones 2da opcion

  insertTask() async {
    Database? db = await checkDatabase();
    int res = await db!.insert(
      "TASK",
      {
        "title": "Comprar el nuevo diicoddd",
        "descripcion": "Nuevo discoddd",
        "status": "fasedd"
      },
    );
    print(res);
  }

  //obtener datos

  // 1 ra foram
  getRawTasks() async {
    Database? db = await checkDatabase();
    List lista = await db!.rawQuery("SELECT * FROM TASK");

    print(lista);
  }

//2da forma

  Future<List<Map<String, dynamic>>> getTasks() async {
    Database? db = await checkDatabase();
    List<Map<String, dynamic>> listaTask = await db!.query("Task");
    return listaTask;
  }

//Actualizar
//1ra fomra
  updateRawTask() async {
    Database? db = await checkDatabase();
    db!.rawUpdate(
        "update TASK SET title ='hola',descripcion ='hola', status = 'hola'  WHERE id=2");
  }

//2da forma
  updatetask() async {
    Database? db = await checkDatabase();
    db!.update(
        "TASK",
        {
          "title": "ir al cine",
          "descripcion": "Es el viernes en la tarde",
          "status": "false"
        },
        where: "id=3");
  }

  //eliminar
  //1RA FORAM
  deleteRawTask() async {
    Database? db = await checkDatabase();

    db!.rawDelete("DELETE FROM TASK WHERE ID=2");
  }

  //2DA FORMA
  deleteTask() async {
    Database? db = await checkDatabase();
    int res = await db!.delete("TASK", where: "ID=3");
  }
}
