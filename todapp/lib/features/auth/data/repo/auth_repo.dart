import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepo {
  // Singleton pattern
  AuthRepo._();
  static final AuthRepo instance = AuthRepo._();

  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  /// Get current user id
  String? getCurrentUserId() => _auth.currentUser?.uid;

  /// Register a new user
  Future<void> register({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = credential.user;
      if (user != null) {
        await _firestore.collection('users').doc(user.uid).set({
          'uid': user.uid,
          'email': email,
          'name': name,
          'image': '',
          'createdAt': FieldValue.serverTimestamp(),
        });
      }
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-email':
          throw Exception('The email format is invalid.');
        case 'weak-password':
          throw Exception('The password provided is too weak.');
        case 'email-already-in-use':
          throw Exception('An account already exists for that email.');
        case 'operation-not-allowed':
          throw Exception('Email/password accounts are not enabled.');
        default:
          throw Exception(e.message ?? 'Something went wrong during registration.');
      }
    } catch (e) {
      throw Exception(e.toString());
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
