import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';

class TaskItem {
  String id; //varje task behöver ett id
  String title; //varje task behöver en title
  String deadline; //varje task behöver en deadline
  String? description;

  TaskItem(
      {required this.id,
      required this.title,
      required this.deadline,
      this.description});

  Map<String, dynamic> createMap() {
    return {
      'id': id,
      'title': title,
      'deadline': deadline,
      'description': description
    };
  }

  TaskItem.fromIdAndJson(String idFromFirebase, Map<String, dynamic> parsedJSON)
      : id = idFromFirebase,
        title = parsedJSON['title'],
        deadline = parsedJSON['deadline'],
        description = parsedJSON['description'];
}

class MyState extends ChangeNotifier {
  List<TaskItem> _list = [];

  List<TaskItem> get list => _list;

  Stream<List<TaskItem>> getTasks() {
    return FirebaseFirestore.instance
        .collection('TaskItem')
        .snapshots()
        .map((snapShot) => snapShot.docs.map((document) {
              print(document);
              return TaskItem.fromIdAndJson(document.id, document.data());
            }).toList());
  }

  void addTask(TaskItem task) {
    FirebaseFirestore.instance.collection('TaskItem').add({
      'title': task.title,
      'deadline': task.deadline,
      'description': task.description
    });
  }

  Future<void> removeTask(TaskItem task) {
    return FirebaseFirestore.instance
        .collection('TaskItem')
        .doc(task.id)
        .delete()
        .then((value) => print('Det togs bort'))
        .catchError((error) => print('Failed to delete task: $error'));
  }

/*  CollectionReference testing = FirebaseFirestore.instance.collection('testing');

Future<void> deleteDate() {
  return testing
      .doc('docId')
      .delete()
      .then((value) => print("User Deleted"))
      .catchError((error) => print("Failed to delete user: $error"));
}*/
}
