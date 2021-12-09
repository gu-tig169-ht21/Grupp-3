import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model.dart';
import 'addtaskview.dart';

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
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddTaskView(
                      TaskItem(title: '', deadline: '', description: ''))));
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
      title: Text(task.title),
    );
  }
}
