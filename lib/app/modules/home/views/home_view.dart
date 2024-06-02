import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import '../../../components/button.dart';
import '../../../components/textfield.dart';
import '../../../constants/spaces.dart';
import '../../../constants/fonts.dart';
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
              visibility: false,
            ),
            Spaces.y1,
            Obx(() => controller.imagePath.value == ''
                ? const Text("No Image selected")
                : SizedBox(
                    height: 30.h,
                    width: double.infinity,
                    child: Image(
                        image: FileImage(File(controller.imagePath.value))))),
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
                const SizedBox(
                  width: 12,
                ),
                ElevatedButton(
                    onPressed: () => controller.pickPDFFile(),
                    child: const Text("File Picker")),
              ],
            ),
            CustomButton(
              text: 'Save',
              onPressed: () {
                if (controller.pickedFile.value != null) {
                  // Case: PDF file selected
                  print("inside1");
                  if (controller.imagePath.value.isNotEmpty &&
                      controller.textController.text.isNotEmpty) {
                    // Case: Text with PDF file
                    print("inside2");
                    controller.uploadTextImagePDF();

                  }  else if(controller.textController.text.isNotEmpty){
                    // case: Both with pdf
                    print("inside3");
                    controller.uploadTextPDF();
                  } else {
                    // Case: Only PDF file
                    print("inside4");
                    controller.uploadPDF();
                  }
                }
                else if (controller.imagePath.value.isNotEmpty) {
                  // Case: Image selected
                  if (controller.textController.text.isNotEmpty & controller.imagePath.value.isNotEmpty) {
                    // Case: Text with image
                    controller.uploadTextImage();
                  } else {
                    // Case: Only image
                    controller.uploadImage();
                  }
                }
                else if (controller.textController.text.isNotEmpty) {
                  // Case: Only text;
                  controller.uploadText();
                } else {
                  // Case: No data to upload
                  Get.snackbar('Error', 'No data to upload');
                }
              },
            ),
            Obx(() {
              if (controller.pickedFile.value == null) {
                return const Text('No file selected');
              } else {
                final file = File(controller.pickedFile.value!.path!);
                if (controller.pickedFile.value!.extension == 'pdf') {
                  return Container(
                    color: Colors.blue[100],
                    child: Text(
                        'PDF file selected: ${controller.pickedFile.value!.name}'),
                  );
                } else {
                  return Container(
                    color: Colors.blue[100],
                    child: Image.file(
                      file,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  );
                }
              }
            }),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(12.0),
        child: CustomButton(
          onPressed: () =>Get.toNamed('/view-user-data'),
          text: 'view data',
        ),
      ),
    );
  }
}