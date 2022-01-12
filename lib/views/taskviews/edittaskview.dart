import 'package:flutter/material.dart';
import '../../model.dart';

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
    titleEditingController.text = task.title;
    deadlineEditingController.text = task.deadline;
    descriptionEditingController.text = task.description;

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
        title: const Text('Edit assignment'),
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
            child: const Text('Save',
                style: TextStyle(color: Colors.white, fontSize: 17)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 23),
                  margin: const EdgeInsets.only(top: 30),
                  child: const Text('Title',
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
                  child: const Text('Description',
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                ),
                editDescriptionBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget editTitleBox() {
    return Container(
      margin: const EdgeInsets.all(1),
      padding: const EdgeInsets.all(10),
      child: TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter title';
          }
          return null;
        },
        controller: titleEditingController,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 25.0, horizontal: 10.0),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.indigo, width: 1.0),
            borderRadius: BorderRadius.circular(20.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.indigo, width: 1.0),
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
      ),
    );
  }

  Widget editDeadlineBox() {
    return Container(
      margin: const EdgeInsets.all(1),
      padding: const EdgeInsets.all(10),
      child: TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter deadline';
          }
          return null;
        },
        controller: deadlineEditingController,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 25.0, horizontal: 10.0),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.indigo, width: 1.0),
            borderRadius: BorderRadius.circular(20.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.indigo, width: 1.0),
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
      ),
    );
  }

  Widget editDescriptionBox() {
    return Container(
      margin: const EdgeInsets.all(1),
      padding: const EdgeInsets.all(10),
      child: TextFormField(
        controller: descriptionEditingController,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 25.0, horizontal: 10.0),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.indigo, width: 1.0),
            borderRadius: BorderRadius.circular(20.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.indigo, width: 1.0),
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
      ),
    );
  }
}
