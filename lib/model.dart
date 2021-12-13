import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';

class TaskItem {
  // String id;   //varje task behöver ett id
  String title; //varje task behöver en title
  String deadline; //varje task behöver en deadline
  String? description;

  TaskItem({required this.title, required this.deadline, this.description});
}

class MyState extends ChangeNotifier {
  List<TaskItem> _list = [];

  List<TaskItem> get list => _list;

  final databaseRef = FirebaseDatabase.instance.ref();

  void addTask(TaskItem task) {
    _list.add(task);
    notifyListeners();
    //databaseRef.push().set({task});
    FirebaseFirestore.instance
        .collection('TaskItem')
        .add({'title': '', 'deadline': '', 'description': ''});
  }

  void removeTask(TaskItem task) {
    _list.remove(task);
    notifyListeners();
  }
/*
  void getTask() {
    databaseRef.once().then(( snapshot) {
      print('Data : ${snapshot.value}');
    });
  }*/
}
