import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../model/task_model.dart';

class TaskRepo {
  // Singleton
  TaskRepo._privateConstructor();
  static final TaskRepo _instance = TaskRepo._privateConstructor();
  factory TaskRepo() => _instance;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  CollectionReference get _tasksCollection =>
      _firestore.collection('tasks');

  /// Add Task
  Future<Either<String, TaskModel>> addTask(TaskModel task) async {
    try {
      final user = _auth.currentUser;
      if (user == null) return const Left("No user logged in");

      // دايماً نضيف userId
      final taskWithUser = task.copyWith(userId: user.uid);

      final docRef = await _tasksCollection.add(taskWithUser.toJson());
      final newTask = taskWithUser.copyWith(id: docRef.id);
      return Right(newTask);
    } catch (e) {
      return Left(e.toString());
    }
  }

  /// Get User Tasks
  Future<Either<String, List<TaskModel>>> getTasks(String userId) async {
    try {
      final snapshot =
          await _tasksCollection.where('userId', isEqualTo: userId).get();

      final tasks = snapshot.docs
          .map((doc) => TaskModel.fromJson(
                doc.data() as Map<String, dynamic>,
                doc.id,
              ))
          .toList();

      return Right(tasks);
    } catch (e) {
      return Left(e.toString());
    }
  }

  /// Update Task
  Future<Either<String, Unit>> updateTask(TaskModel task) async {
    try {
      await _tasksCollection.doc(task.id).update(task.toJson());
      return const Right(unit);
    } catch (e) {
      return Left(e.toString());
    }
  }

  /// Delete Task
  Future<Either<String, Unit>> deleteTask(String taskId) async {
    try {
      await _tasksCollection.doc(taskId).delete();
      return const Right(unit);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
