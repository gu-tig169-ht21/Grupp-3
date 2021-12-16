import 'model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseServices {
  static final FirebaseFirestore _fireStoreDataBase =
      FirebaseFirestore.instance;

  static Stream<List<TaskItem>> getTasks() {
    return _fireStoreDataBase.collection('TaskItem').snapshots().map(
        (snapShot) => snapShot.docs
            .map((document) => TaskItem.fromJson(document.data()))
            .toList());
  }

  Future<void> addTask() {
    var addTaskData = Map<String, dynamic>();
    addTaskData['title'] = '';
    addTaskData['deadline'] = '';
    addTaskData['description'] = '';
    return _fireStoreDataBase.collection('TaskItem').add(addTaskData);
  }
}
