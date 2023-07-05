import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserCredential?> registerWithEmailAndPassword(
      String userEmail, String userPassword) async {
    try {
      UserCredential? result = await _auth.createUserWithEmailAndPassword(
          email: userEmail, password: userPassword);
      return result;
    } catch (error) {
      log('Registration error: $error');
      return null;
    }
  }

  Future<UserCredential?> logInWithEmailAndPassword(
      String userEmail, String userPassword) async {
    try {
      UserCredential? result = await _auth.signInWithEmailAndPassword(
          email: userEmail, password: userPassword);
      return result;
    } catch (error) {
      log('Login error: $error');
      return null;
    }
  }

  addUserToFirestore(
      String role, User user, email, password, firstName, lastName) async {
    await _firestore.collection('food_app_users').doc(user.uid).set({
      'role': role,
      'email': email,
      'password': password,
      'first_name' : firstName,
      'last_name' : lastName,
    });
  }

  Future<String?> getUserRoleFromDatabase(String userId) async {
    try {
      // Get the user document from Firestore using the user ID
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('food_app_users')
          .doc(userId)
          .get();

      if (snapshot.exists) {
        // Retrieve the user's role from the document data
        Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
        String role = data['role'];
        return role;
      } else {
        // User document does not exist
        return null;
      }
    } catch (error) {
      print('Error getting user role: $error');
      return null;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
