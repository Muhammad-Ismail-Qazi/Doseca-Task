import 'package:duseca_task/app/constants/firebase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  GlobalKey<FormState> SignupFormKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordVisibility = false.obs;

  void togglePasswordVisibility() {
    passwordVisibility.value = !passwordVisibility.value;
  }

  void signUp(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      Get.snackbar('Alert', 'Please provide all the information');
    } else {
      try {
        await firebaseAuthInstance
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) {
          Get.snackbar('Success', 'Registration successful');
          clearFields();
          Get.toNamed("/login");
        });
      } on FirebaseAuthException catch (error) {
        print(error);
        Get.snackbar('Error', error.message ?? 'Unknown error');
      }
    }
  }
  @override
  void clearFields() {
    emailController.clear();
    passwordController.clear();
  }
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }


}