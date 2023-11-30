import 'package:codigo_taskdb/db/db_admin.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
      ),
      body: FutureBuilder(
        future: DBAdmin.db.getTasks(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            List<Map<String, dynamic>> myTasks = snapshot.data;
            return ListView.builder(
                itemCount: myTasks.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(myTasks[index]["title"]),
                    subtitle: Text(myTasks[index]["description"]),
                    trailing: Text(myTasks[index]["id"].toString()),
                  );
                });
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
