import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todapp/core/network/api_helper.dart';
import 'package:todapp/core/network/api_response.dart';
import 'package:todapp/core/network/end_points.dart';

class AuthRepo {
  // Singleton pattern
  AuthRepo._();
  static final AuthRepo instance = AuthRepo._();
  ApiHelper apiHelper = ApiHelper();
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  /// Get current user id
  String? getCurrentUserId() => _auth.currentUser?.uid;

  /// Register a new user
Future<Either<String, Unit>> register({
    required String phone,
    required String name,
    required String email,
    required String password,
    XFile? image
  })async
  {
    try {
      final Map<String, dynamic> data = {
        'name': name,
        'email': email,
        'password': password,
        'phone': phone,
      };

      // If image exists, attach as file
      if (image != null) {
        data['image'] = await MultipartFile.fromFile(
          image.path,
          filename: image.name,
        );
      }
      var response = await apiHelper.postRequest(
        endPoint: EndPoints.register,
        data: data
      );
      if(response.status)
      {
        return right(unit);
      }
      else
      {
        return left(response.message);
      }
    }
    catch (e) {
      print(e);
      return Left(ApiResponse.fromError(e).message);

    }
  }
  /// Login with auto-create Firestore profile if missing
Future<Map<String, dynamic>> login({
  required String email,
  required String password,
}) async {
  try {
    final credential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    final user = credential.user;
    if (user == null) throw Exception("Login failed");

    final docRef = _firestore.collection('users').doc(user.uid);
    final doc = await docRef.get();

    if (!doc.exists) {
      // ⚡ Now Firestore allows this, so we can safely set the correct name later
      final userData = {
        'uid': user.uid,
        'email': user.email,
        'name': user.displayName ?? user.email?.split('@')[0], // fallback
        'image': '',
        'createdAt': DateTime.now(),
      };
      await docRef.set(userData);
      return userData;
    } else {
      //  Get stored user name from Firestore
      return doc.data()!;
    }
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      throw Exception("No account found for this email.");
    } else if (e.code == 'wrong-password') {
      throw Exception("Incorrect password.");
    } else {
      throw Exception(e.message ?? "Login failed");
    }
  }
}



  /// Get user profile
  Future<Map<String, dynamic>?> getUser(String uid) async {
    final doc = await _firestore.collection('users').doc(uid).get();
    return doc.data();
  }
}
