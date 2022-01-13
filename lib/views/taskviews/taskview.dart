import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../model.dart';
import 'addtaskview.dart';
import 'descriptionview.dart';

//Första sidan för uppgifter
class TaskView extends StatelessWidget {
  const TaskView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Assignments'),
      ),
      body: Consumer<MyState>(
        builder: (context, state, child) => TaskList(state.list),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add, color: Colors.white, size: 40),
        backgroundColor: Colors.blue.shade800,
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

//Hämtar och visar listan över alla uppgifter från Firebase
class TaskList extends StatelessWidget {
  final List<TaskItem> list;

  const TaskList(this.list);

  @override
  Widget build(BuildContext context) {
    return Consumer<MyState>(builder: (context, task, child) {
      return StreamBuilder(
          stream: task.getTasks(),
          builder:
              (BuildContext context, AsyncSnapshot<List<TaskItem>> snapshot) {
            if (snapshot.data != null) {
              return ListView(
                children: snapshot.data!.map((TaskItem item) {
                  return Center(
                    child: _taskItem(context, item),
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

//Uppbyggnaden för varje uppgiftsrad i listan
Widget _taskItem(context, TaskItem task) {
  var state = Provider.of<MyState>(context, listen: false);
  return ListTile(
    leading: Icon(
      Icons.note_alt_sharp,
      size: 30,
      color: Colors.blue.shade800,
    ),
    onTap: () => Navigator.push(context,
        MaterialPageRoute(builder: (context) => DescriptionView(task))),
    title: Text(task.title),
    subtitle: Text(task.deadline),
    trailing: IconButton(
      icon: const Icon(Icons.delete),
      onPressed: () {
        state.removeTask(task);
      },
    ),
  );
}
