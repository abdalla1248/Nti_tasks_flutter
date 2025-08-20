import 'package:cloud_firestore/cloud_firestore.dart';

class TaskModel {
  final String id;
  final String title;
  final String description;
  final bool isDone;
  final String userId;
  final Timestamp createdAt;

  TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.isDone,
    required this.userId,
    required this.createdAt,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json, String docId) {
    return TaskModel(
      id: docId,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      isDone: json['isDone'] ?? false,
      userId: json['userId'] ?? '',
      createdAt: json['createdAt'] ?? Timestamp.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'isDone': isDone,
      'userId': userId,
      'createdAt': createdAt,
    };
  }
}
