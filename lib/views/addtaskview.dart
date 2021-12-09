import 'package:flutter/material.dart';

import '../model.dart';

class AddTaskView extends StatefulWidget {
  final TaskItem task;

  const AddTaskView(this.task);

  @override
  State<StatefulWidget> createState() {
    return AddTaskViewState(task);
  }
}

class AddTaskViewState extends State<AddTaskView> {
  String title = '';
  String deadline = '';
  String description = '';

  TextEditingController titleEditingController = TextEditingController();
  TextEditingController deadlineEditingController = TextEditingController();
  TextEditingController descriptionEditingController = TextEditingController();

  AddTaskViewState(TaskItem task) {
    this.title = task.title;

    titleEditingController.addListener(() {
      setState(() {
        title = titleEditingController.text;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //lägg till spara-knapp för att spara nya uppgifter
        centerTitle: true,
        title: const Text('Lägg till uppgift'),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(
                  context,
                  TaskItem(
                      title: title,
                      deadline: deadline,
                      description: description));
            },
            child: Text('Spara', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(height: 30),
            titleBox(),
            Container(height: 20),
            deadlineBox(),
            Container(height: 20),
            descriptionBox(),
          ],
        ),
      ),
    );
  }

  Widget titleBox() {
    return TextField(
      controller: titleEditingController,
      decoration: const InputDecoration(
          border: OutlineInputBorder(), hintText: 'Add new task'),
    );
  }

  Widget deadlineBox() {
    return TextField(
      controller: deadlineEditingController,
      decoration: const InputDecoration(
          border: OutlineInputBorder(), hintText: 'Add new deadline'),
    );
  }

  Widget descriptionBox() {
    return TextField(
      controller: descriptionEditingController,
      decoration: const InputDecoration(
          border: OutlineInputBorder(), hintText: 'Add new description'),
    );
  }
}
