import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../firebase_services.dart';
import '../model.dart';
import 'addtaskview.dart';
import 'dart:math';
import 'descriptionview.dart';
import '../firebase_services.dart';

class TaskView extends StatelessWidget {
  const TaskView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Uppgifter'),
      ),
      body: Consumer<MyState>(
        builder: (context, state, child) => TaskList(state.list),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          var newItem = await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddTaskView(
                      TaskItem(title: '', deadline: '', description: ''))));
          if (newItem != null) {
            Provider.of<MyState>(context, listen: false).addTask(newItem);
          }
        },
      ),
    );
  }
}

class TaskList extends StatelessWidget {
  final List<TaskItem> list;

  TaskList(this.list);

  @override
  Widget build(BuildContext context) {
    return Consumer<Stream<List<TaskItem>>>(
        builder: (context, Stream<List<TaskItem>> tasks, child) {
      return StreamBuilder(
          stream: tasks,
          builder:
              (BuildContext context, AsyncSnapshot<List<TaskItem>> snapshot) {
            if (snapshot.data != null) {
              return ListView(
                children: snapshot.data!.map((TaskItem item) {
                  return Container(
                    child: Center(
                      child: _taskItem(context, item),
                    ),
                  );
                }).toList(),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          });
    });
  }
}

/* FUNGERANDE TASKLIST PÅ SÄTTET SOM LOVISA FIXADE EFTER HANDLEDNING MED SEBASTIAN

    Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _taskStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;
              return ListTile(
                leading: Icon(
                  Icons.group_work_rounded,
                  size: 30,
                  color: Colors
                      .primaries[Random().nextInt(Colors.primaries.length)],
                ),
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            DescriptionView(TaskItem.fromJson(data)))),
                title: Text(data['title']),
                subtitle: Text(data['deadline']),
                trailing: IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {},
                ),
              );
            }).toList(),
          );
        });
  }
}*/

/*ListView(
        children: list.map((task) => _taskItem(context, task)).toList());*/

Widget _taskItem(context, TaskItem task) {
  var state = Provider.of<MyState>(context, listen: false);
  return ListTile(
    leading: Icon(
      Icons.group_work_rounded,
      size: 30,
      color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
    ),
    onTap: () => Navigator.push(context,
        MaterialPageRoute(builder: (context) => DescriptionView(task))),
    title: Text(task.title),
    subtitle: Text(task.deadline),
    trailing: IconButton(
      icon: Icon(Icons.delete),
      onPressed: () {
        state.removeTask(task);
      },
    ),
  );
}


/* List taskList = Provider.of<List<TaskItem>>(context);
    FirebaseServices firebaseServices = FirebaseServices();
    
    body: ListView.builder(
        itemCount: taskList.length,
        itemBuilder: (_, int index) => Padding(
          padding: EdgeInsets.all(10.0),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.amber,
            ),
            title: Text(
              taskList[index].title,
              style: TextStyle(
                color: Colors.black,
                fontSize: 20.0,
              ),
            ),
            subtitle: Text(
              taskList[index].deadline,
              style: TextStyle(
                fontSize: 25.0,
              ),
            ),
          ),
        ),
      ),*/