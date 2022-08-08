// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_codigo_taskdb/db/db_admin.dart';
import 'package:path/path.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  showDialogForm(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                Text("Agregar Tarea"),
                TextField(
                  maxLines: 1,
                  decoration: InputDecoration(hintText: "Titulo"),
                ),
                SizedBox(
                  height: 6.0,
                ),
                TextField(
                  maxLines: 2,
                  decoration: InputDecoration(hintText: "Descripcion"),
                ),
                SizedBox(
                  height: 6.0,
                ),
                Row(
                  children: [
                    Text("Estado"),
                    Checkbox(value: true, onChanged: (value) {})
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("Cancelar")),
                    SizedBox(
                      width: 10.0,
                    ),
                    ElevatedButton(onPressed: () {}, child: Text("Aceptar")),
                  ],
                )
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialogForm(context);
          },
          child: const Icon(Icons.add)),
      // ignore: prefer_const_constructors
      body: FutureBuilder(
          future: DBAdmin.db.getTasks(),
          builder: (BuildContext context, AsyncSnapshot snap) {
            //para obtener si hay conexion
            //print(snap.connectionState);

            //para saber si hay data=>true
            //print(snap.hasData);

            //para obtener la data
            //print(snap.hasData)

            if (snap.hasData) {
              List<Map<String, dynamic>> lista = snap.data;
              print(lista);
              return ListView.builder(
                  itemCount: lista.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(lista[index]["title"]),
                      subtitle: Text(lista[index]["descripcion"]),
                      trailing: Text(lista[index]["status"]),
                    );
                  });
            }
            //widget para la espera
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}


 //Ejemplos de verificar
          /*child: Column(
              children: [
                ElevatedButton(
                    onPressed: () {
                      DBAdmin.db.getTasks();
                      // DBAdmin.db.initDataBase();
                    },
                    child: Text("mostrar Data")),
                ElevatedButton(
                    onPressed: () {
                      // DBAdmin.db.insertRawTask();
                      DBAdmin.db.insertTask();
                    },
                    child: Text("Insertar Tarea")),
                ElevatedButton(
                    onPressed: () {
                      //   DBAdmin.db.updatetask();
                      DBAdmin.db.updatetask();
                    },
                    child: Text("Actualizar Tarea")),
                ElevatedButton(
                    onPressed: () {
                      // DBAdmin.db.deleteTask();
                      DBAdmin.db.deleteRawTask();
                    },
                    child: Text("Eliminar Data"))
              ],
            ),*/