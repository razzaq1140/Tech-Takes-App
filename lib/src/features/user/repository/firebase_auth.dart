import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthServices {
  static FirebaseAuth auth = FirebaseAuth.instance;
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static Future<void> userSignUp(String email, String password) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // User registered successfully
      log("User registered successfully: ${userCredential.user?.email}");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        log('The email address is already in use by another account.');
        Get.snackbar(
          "Teck Takes App",
          "The email address is already in use by another account.",
          snackPosition: SnackPosition.TOP,
        );
        return; // Exit on error
      } else if (e.code == 'weak-password') {
        log('The password provided is too weak.');
        Get.snackbar(
          "Teck Takes App",
          "The password provided is too weak.",
          snackPosition: SnackPosition.TOP,
        );
        return; // Exit on error
      } else if (e.code == 'invalid-email') {
        log('The email address is not valid.');
        Get.snackbar(
          "Teck Takes App",
          "The email address is not valid.",
          snackPosition: SnackPosition.TOP,
        );
        return; // Exit on error
      } else {
        log('Error: ${e.message}');
        Get.snackbar(
          "Teck Takes App",
          "Registration failed: ${e.message}",
          snackPosition: SnackPosition.TOP,
        );
        return; // Exit on error
      }
    } catch (e) {
      log('Unknown error occurred: $e');
      Get.snackbar(
        "Teck Takes App",
        "An unexpected error occurred. Please try again later.",
        snackPosition: SnackPosition.TOP,
      );
      return; // Exit on error
    }
  }
}
