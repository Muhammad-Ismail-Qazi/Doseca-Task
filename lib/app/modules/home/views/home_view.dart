import 'dart:io';

import 'package:duseca_task/app/components/button.dart';
import 'package:duseca_task/app/components/textfield.dart';
import 'package:duseca_task/app/constants/fonts.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

import '../../../constants/spaces.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Upload Data',
          style: CustomFontStyle.heading,
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () => controller.logout(),
              icon: const Icon(Icons.logout))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextField(
                textFieldController: controller.textController,
                hint: 'Text',
                keyboardType: TextInputType.text,
                validator: null,
              visibility: false,),
            Spaces.y1,
            Obx(() => controller.imagePath.value == ''
                ? const Text("No Image selected")
                : SizedBox(
                height: 10*3.h,
                width: double.infinity,
                child: Image(image: FileImage(File(controller.imagePath.value))))),

            Spaces.y2,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () => controller.pickImage(ImageSource.gallery),
                    child: const Text("Gallery")),
                const SizedBox(
                  width: 12,
                ),
                ElevatedButton(
                    onPressed: () => controller.pickImage(ImageSource.camera),
                    child: const Text("Camera")),
              ],
            ),
            CustomButton(
              text: 'Save',
              onPressed: () => controller.uploadData(),
            )
          ],
        ),
      ),
    );
  }
}