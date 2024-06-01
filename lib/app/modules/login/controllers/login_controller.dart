import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../constants/firebase.dart';

class LoginController extends GetxController {
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordVisibility = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    isUserLogin();
  }
  void togglePasswordVisibility() {
    passwordVisibility.value = !passwordVisibility.value;
  }

  void login(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      Get.snackbar('Alert', 'Please provide all the information');
    } else {
      try {
        await firebaseAuthInstance
            .signInWithEmailAndPassword(email: email, password: password)
            .then((value) {
          Get.snackbar('Success', 'Login successful');
          clearFields();
          Get.toNamed("/home");
        });
      } on FirebaseAuthException catch (error) {
        print(error);
        Get.snackbar('Error', error.message ?? 'Unknown error');
      }
    }
  }
  void clearFields() {
    emailController.clear();
    passwordController.clear();
  }
  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void isUserLogin() async {
    final currentUser = await FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      Get.toNamed('/login');
    } else {
      final String? userEmail = currentUser.email;
      final String userID = currentUser.uid;
        print("user is login with $userEmail and $userID");

      Get.toNamed('/home');
    }
  }


}