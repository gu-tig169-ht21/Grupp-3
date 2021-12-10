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

  void addTask(TaskItem task) {
    _list.add(task);
    notifyListeners();
  }

  void removeTask(TaskItem task) {
    _list.remove(task);
    notifyListeners();
  }
}
