import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';

class TaskItem {
  // String id;   //varje task behöver ett id
  String title; //varje task behöver en title
  String deadline; //varje task behöver en deadline
  String? description;

  TaskItem({required this.title, required this.deadline, this.description});

  Map<String, dynamic> createMap() {
    return {'title': title, 'deadline': deadline, 'description': description};
  }

  TaskItem.fromJson(Map<String, dynamic> parsedJSON)
      : title = parsedJSON['title'],
        deadline = parsedJSON['deadline'],
        description = parsedJSON['description'];
}

class MyState extends ChangeNotifier {
  List<TaskItem> _list = [];

  List<TaskItem> get list => _list;

  Stream<List<TaskItem>> getTasks() {
    return FirebaseFirestore.instance.collection('TaskItem').snapshots().map(
        (snapShot) => snapShot.docs
            .map((document) => TaskItem.fromJson(document.data()))
            .toList());
  }

  void addTask(TaskItem task) {
    FirebaseFirestore.instance.collection('TaskItem').add({
      'title': task.title,
      'deadline': task.deadline,
      'description': task.description
    });
  }

  void removeTask(TaskItem task) {
    //fixa
    _list.remove(task);
    notifyListeners();
  }
}
