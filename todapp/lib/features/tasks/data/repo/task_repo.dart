import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/task_model.dart';

class TaskRepo {
  final _taskCollection = FirebaseFirestore.instance.collection('tasks');

  Future<void> addTask(TaskModel task) async {
    await _taskCollection.add(task.toJson());
  }

  Future<void> updateTask(TaskModel task) async {
    await _taskCollection.doc(task.id).update(task.toJson());
  }

  Future<void> deleteTask(String id) async {
    await _taskCollection.doc(id).delete();
  }

  Stream<List<TaskModel>> getTasks(String userId) {
    return _taskCollection
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => TaskModel.fromJson(doc.data(), doc.id))
            .toList());
  }
}
