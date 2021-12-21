import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../model.dart';

class EditTaskView extends StatefulWidget {
  final TaskItem task;

  const EditTaskView(this.task);

  @override
  State<EditTaskView> createState() {
    return EditTaskViewState(task);
  }
}

class EditTaskViewState extends State<EditTaskView> {
  String title = '';
  String deadline = '';
  String? description = '';
  final _formKey = GlobalKey<FormState>();
  final task;

  TextEditingController titleEditingController = TextEditingController();
  TextEditingController deadlineEditingController = TextEditingController();
  TextEditingController descriptionEditingController = TextEditingController();

  EditTaskViewState(this.task) {
    this.title = task.title;
    this.deadline = task.deadline;
    this.description = task.description;

    titleEditingController.addListener(() {
      setState(() {
        title = titleEditingController.text;
      });
    });

    deadlineEditingController.addListener(() {
      setState(() {
        deadline = deadlineEditingController.text;
      });
    });

    descriptionEditingController.addListener(() {
      setState(() {
        description = descriptionEditingController.text;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Ändra Uppgift'),
        actions: [
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                Navigator.pop(
                    context,
                    TaskItem(
                        id: task.id,
                        title: title,
                        deadline: deadline,
                        description: description));
              }
            },
            child: Text('Spara Ändring', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(left: 23),
                margin: const EdgeInsets.only(top: 30),
                child: const Text('Titel',
                    style:
                        TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
              ),
              editTitleBox(),
              Container(
                padding: const EdgeInsets.only(left: 23),
                margin: const EdgeInsets.only(top: 20),
                child: const Text('Deadline',
                    style:
                        TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
              ),
              editDeadlineBox(),
              Container(
                padding: const EdgeInsets.only(left: 23),
                margin: const EdgeInsets.only(top: 20),
                child: const Text('Beskrivning',
                    style:
                        TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
              ),
              editDescriptionBox(),
            ],
          ),
        ),
      ),
    ); //Ändra editknapp
  }

  Widget editTitleBox() {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter title';
        }
        return null;
      },
      controller: titleEditingController,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        hintText: task.title,
      ),
    );
  }

  Widget editDeadlineBox() {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter deadline';
        }
        return null;
      },
      controller: deadlineEditingController,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        hintText: task.deadline,
      ),
    );
  }

  Widget editDescriptionBox() {
    return TextFormField(
      controller: descriptionEditingController,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        hintText: task.description,
      ),
    );
  }
}
