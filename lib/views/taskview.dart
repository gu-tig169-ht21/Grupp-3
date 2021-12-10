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
    return ListView(
        children: list.map((task) => _taskItem(context, task)).toList());
  }

//hur varje task i todo-listan ska se ut, titeln är toDoText, längst till vänster
//finns ett kryss för att ta bort en task, och längst till höger en checkbox som
//kan få olika värde beroende på om den är icheckad eller ej
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
}
