import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TaskModel {
  final String id;
  final String title;
  final String description;
  final String type;
  final bool isDone;
  final String userId;
  final Timestamp createdAt;
  final DateTime? date;
  final TimeOfDay? time;

  TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.isDone,
    required this.userId,
    required this.createdAt,
    this.date,
    this.time,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json, String docId) {
    return TaskModel(
      id: docId,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      type: json['type'] ?? 'Home',
      isDone: json['isDone'] ?? false,
      userId: json['userId'] ?? '',
      createdAt: json['createdAt'] ?? Timestamp.now(),
      date: json['date'] != null ? (json['date'] as Timestamp).toDate() : null,
      time: json['time'] != null
          ? TimeOfDay(
              hour: (json['time']['hour'] ?? 0),
              minute: (json['time']['minute'] ?? 0),
            )
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'type': type,
      'isDone': isDone,
      'userId': userId,
      'createdAt': createdAt,
      'date': date != null ? Timestamp.fromDate(date!) : null,
      'time': time != null ? {'hour': time!.hour, 'minute': time!.minute} : null,
    };
  }

  /// ✅ Computed property to combine `date` + `time` into a single DateTime
  DateTime get taskDateTime {
    if (date == null && time == null) return createdAt.toDate();
    if (date == null) return DateTime.now();
    if (time == null) return DateTime(date!.year, date!.month, date!.day);
    return DateTime(date!.year, date!.month, date!.day, time!.hour, time!.minute);
  }

  TaskModel copyWith({
    String? id,
    String? title,
    String? description,
    String? type,
    bool? isDone,
    String? userId,
    Timestamp? createdAt,
    DateTime? date,
    TimeOfDay? time,
  }) {
    return TaskModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      type: type ?? this.type,
      isDone: isDone ?? this.isDone,
      userId: userId ?? this.userId,
      createdAt: createdAt ?? this.createdAt,
      date: date ?? this.date,
      time: time ?? this.time,
    );
  }
}
