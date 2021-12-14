import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';

import 'firestoreservice.dart';

class TaskItem {
  // String id;   //varje task behöver ett id
  String title; //varje task behöver en title
  String deadline; //varje task behöver en deadline
  String? description;

  TaskItem({required this.title, required this.deadline, this.description});

  Map<String, dynamic> createMap() {
    return {'title': title, 'deadline': deadline, 'description': description};
  }

  TaskItem.fromFirestore(Map<String, dynamic> firestoreMap)
      : title = firestoreMap['title'],
        deadline = firestoreMap['deadline'],
        description = firestoreMap['description'];
}

class MyState extends ChangeNotifier {
  final service = FireStoreService();

  List<TaskItem> _list = [];

  List<TaskItem> get list => _list;

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
