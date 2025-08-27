import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import '../model/task_model.dart';

class TaskRepo {
  // Singleton
  TaskRepo._privateConstructor();
  static final TaskRepo _instance = TaskRepo._privateConstructor();
  factory TaskRepo() => _instance;

  final CollectionReference _tasksCollection =
      FirebaseFirestore.instance.collection('tasks');

  Future<Either<String, TaskModel>> addTask(TaskModel task) async {
    try {
      final docRef = await _tasksCollection.add(task.toJson());
      final newTask = task.copyWith(id: docRef.id);
      return Right(newTask);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, List<TaskModel>>> getTasks(String userId) async {
    try {
      final snapshot =
          await _tasksCollection.where('userId', isEqualTo: userId).get();
      final tasks = snapshot.docs
          .map((doc) => TaskModel.fromJson(doc.data() as Map<String, dynamic>, doc.id))
          .toList();
      return Right(tasks);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, Unit>> updateTask(TaskModel task) async {
    try {
      await _tasksCollection.doc(task.id).update(task.toJson());
      return const Right(unit);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, Unit>> deleteTask(String taskId) async {
    try {
      await _tasksCollection.doc(taskId).delete();
      return const Right(unit);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
