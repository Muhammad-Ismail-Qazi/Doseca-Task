import 'dart:io';

import 'package:duseca_task/app/modules/home/home_model/home_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../constants/firebase.dart';

class HomeController extends GetxController {
  final textController = TextEditingController();
  var imagePath = ''.obs;


  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    textController.dispose();
    super.onClose();
  }

  void clearData() {
    textController.clear();
    imagePath.value = '';

  }

  Future<void> pickImage(ImageSource imageSource) async {
    XFile? pickImage = await ImagePicker().pickImage(source: imageSource);
    if (pickImage != null) {
      imagePath.value = pickImage.path;
    } else {
      Get.snackbar('Error', "No image selected");
    }
  }

  Future<void> uploadData() async {
    try {
      final user = firebaseAuthInstance.currentUser;
      if (user != null) {
        final homeModel = HomeModel(
          text: textController.text,
          userId: user.uid,
        );
        userDataCollection.add(homeModel.toMap()).then((value) {
          Get.snackbar('Success', 'User data is saved successfully');
          clearData();
          print('Data is saved');
        });
      } else {
        Get.snackbar('Error', 'No user logged in');
      }
    } catch (exception) {
      Get.snackbar('Fail', exception.toString());
      print(exception);
    }
  }

  void logout() {
    firebaseAuthInstance.signOut().then((value) => Get.offAllNamed('/login'));
  }
}