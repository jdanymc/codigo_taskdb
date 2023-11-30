import 'package:codigo_taskdb/db/db_admin.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                //DBAdmin.db.initDatabase();
                DBAdmin.db.getTasks();
              },
              child: Text("Mostrar Data"),
            ),
            ElevatedButton(
              onPressed: () {
                //DBAdmin.db.initDatabase();
                DBAdmin.db.insertTask();
              },
              child: Text("Insertar Tarea"),
            ),
            ElevatedButton(
              onPressed: () {
                //DBAdmin.db.updateRawTask();
                DBAdmin.db.updateTask();
              },
              child: Text("Actualizar Tarea"),
            ),
            ElevatedButton(
              onPressed: () {
                DBAdmin.db.deleteTask();
              },
              child: Text("Eliminar Tarea"),
            ),
          ],
        ),
      ),
    );
  }
}
