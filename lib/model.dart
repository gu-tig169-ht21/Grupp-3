import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

//TaskItem definerar innehållet av en uppgift
class TaskItem {
  String id; //varje task behöver ett id
  String title; //varje task behöver en title
  String deadline; //varje task behöver en deadline
  String? description; //varje task kan ha en description men inget krav

  TaskItem(
      {required this.id,
      required this.title,
      required this.deadline,
      this.description});

  //Kopplar ihop vad olika värden mellan Dart och Firebase
  Map<String, dynamic> createMap() {
    return {
      'id': id,
      'title': title,
      'deadline': deadline,
      'description': description
    };
  }

  //Här konverteras värdet från JSON till Dart
  TaskItem.fromIdAndJson(String idFromFirebase, Map<String, dynamic> parsedJSON)
      : id = idFromFirebase,
        title = parsedJSON['title'],
        deadline = parsedJSON['deadline'],
        description = parsedJSON['description'];
}

//Funktioner för när states förändras
class MyState extends ChangeNotifier {
  final List<TaskItem> _list = [];

  List<TaskItem> get list => _list;

  //Hämtar tasks från Firebase
  Stream<List<TaskItem>> getTasks() {
    return FirebaseFirestore.instance
        .collection('TaskItem')
        .snapshots()
        .map((snapShot) => snapShot.docs.map((document) {
              print(document);
              return TaskItem.fromIdAndJson(document.id, document.data());
            }).toList());
  }

  //Lägger till ny task till Firebase
  void addTask(TaskItem task) {
    FirebaseFirestore.instance.collection('TaskItem').add({
      'title': task.title,
      'deadline': task.deadline,
      'description': task.description
    });
  }


  //Tar bort tasks från Firebase
  Future<void> removeTask(TaskItem task) {
    return FirebaseFirestore.instance
        .collection('TaskItem')
        .doc(task.id)
        .delete()
        .then((value) => print('Task deleted'))
        .catchError((error) => print('Failed to delete task: $error'));
  }

  //Uppdaterar tasks i Firebase
  Future<void> updateTask(TaskItem task) {
    return FirebaseFirestore.instance
        .collection('TaskItem')
        .doc(task.id)
        .update({
          'title': task.title,
          'deadline': task.deadline,
          'description': task.description
        })
        .then((value) => print('Task updated'))
        .catchError((error) => print('Failed to update task: $error'));
  }
}
