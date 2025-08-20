import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String image;
  final String email;
  final String name;
  final DateTime createdAt;

  UserModel({
    required this.uid,
    required this.image,
    required this.email,
    required this.name,
    required this.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'] ?? '',
      email: json['email'] ?? '',
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      createdAt: (json['createdAt'] is DateTime)
          ? json['createdAt']
          : (json['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'image': image,
      'createdAt': createdAt,
    };
  }
}