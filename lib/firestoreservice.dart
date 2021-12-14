import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'model.dart';

class FireStoreService {
  FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addTask(TaskItem task) {
    return _db.collection('TaskItem').add({
      'title': task.title,
      'deadline': task.deadline,
      'description': task.description
    });
  }

  Stream<List<TaskItem>> getTasks() {
    return _db.collection('TaskItem').snapshots().map((snapshot) => snapshot
        .docs
        .map((document) => TaskItem.fromFirestore(document.data()))
        .toList());
  }

  Future<void> removeTask(TaskItem task) {
    return _db.collection('TaskItem').doc(task.toString()).delete();
  }
}
