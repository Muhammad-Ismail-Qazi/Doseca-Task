import 'dart:io';

import 'package:duseca_task/app/modules/home/home_model/home_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';


import '../../../constants/firebase.dart';

class HomeController extends GetxController {
  final textController = TextEditingController();
  var imagePath = ''.obs;

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> pickImage(ImageSource imageSource) async {
    XFile? pickImage = await ImagePicker().pickImage(source: imageSource);
    if (pickImage != null) {
      imagePath.value = pickImage.path;
    } else {
      Get.snackbar('Error', "No image selected");
    }
  }

  Future<void> uploadText() async {
    try {
      final user = firebaseAuthInstance.currentUser;
      if (user != null) {
        final homeModel = HomeModel(
          text: textController.text,
          userId: user.uid,

        );
        userDataCollection.add(homeModel.toMap()).then((value) {
          Get.snackbar('Success', 'Text is saved successfully');
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

  Future<void> uploadImage() async {
    try {
      final user = firebaseAuthInstance.currentUser;
      if (user != null) {
        final imageUrl = await uploadImageToStorage();
        final homeModel = HomeModel(
          userId: user.uid,
          imageUrl: imageUrl ?? '',
        );
        userDataCollection.add(homeModel.toMap()).then((value) {
          Get.snackbar('Success', 'Image is saved successfully');
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

  Future<String> uploadImageToStorage() async {
    final file = File(imagePath.value);
    final fileName = file.path.split('/').last;
    final Reference ref = firebaseStorageInstance.ref().child(fileName);
    final uploadTask = ref.putFile(file);
    await uploadTask.whenComplete(() => print('Image uploaded'));
    return ref.getDownloadURL();
  }

  Future<void> uploadTextImage() async {
    try {
      final user = firebaseAuthInstance.currentUser;
      if (user != null) {
        final imageUrl = await uploadImageToStorage();
        final homeModel = HomeModel(
          userId: user.uid,
          text: textController.text,
          imageUrl: imageUrl,
        );
        userDataCollection.add(homeModel.toMap()).then((value) {
          Get.snackbar('Success', 'Text & image is saved successfully');
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

  void clearData() {
    textController.clear();
    imagePath.value = '';
  }

  @override
  void onClose() {
    textController.dispose();
    super.onClose();
  }

}