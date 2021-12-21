import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model.dart';
import 'addtaskview.dart';
import 'dart:math';
import 'descriptionview.dart';

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
                  builder: (context) => AddTaskView(TaskItem(
                      id: '', title: '', deadline: '', description: ''))));
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
    return ChangeNotifierProvider<MyState>(
      create: (context) => MyState(),
      child: Consumer<MyState>(builder: (context, task, child) {
        return StreamBuilder(
            stream: task.getTasks(),
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
      }),
    );
  }
}

Widget _taskItem(context, TaskItem task) {
  var state = Provider.of<MyState>(context, listen: false);
  return ListTile(
    leading: Icon(
      Icons.group_work_rounded,
      size: 30,
      color: Colors.orange,
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
