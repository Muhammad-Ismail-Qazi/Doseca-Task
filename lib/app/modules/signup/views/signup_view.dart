import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../components/button.dart';
import '../../../components/textfield.dart';
import '../../../constants/fonts.dart';
import '../../../constants/spaces.dart';
import '../../../constants/validater.dart';
import '../controllers/signup_controller.dart';

class SignupView extends GetView<SignupController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Form(
        key: controller.SignupFormKey,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Registration",
                style: CustomFontStyle.heading,
              ),
              Spaces.y2,
              CustomTextField(
                textFieldController: controller.emailController,
                hint: 'Email',
                validator: (value) => validateEmail(value!),
                keyboardType: TextInputType.emailAddress,
                visibility: false,
              ),
              Spaces.y2,
              Obx(
                    () => CustomTextField(
                  textFieldController: controller.passwordController,
                  hint: 'Password',
                  keyboardType: TextInputType.text,
                  visibility: controller.passwordVisibility.value,
                  suffixIcon:IconButton(
                      onPressed:() => controller.togglePasswordVisibility(),
                      icon: controller.passwordVisibility.value ? const Icon(Icons.visibility_off)
                          : const Icon(Icons.visibility)),

                ) ,
              ),
              Spaces.y5,
              CustomButton(
                text: 'Signup',
                onPressed: () {
                  if(controller.SignupFormKey.currentState!.validate()){
                    controller.signUp(
                        controller.emailController.text,
                        controller.passwordController.text);
                  }

                },
              ),
              Spaces.y2,
              RichText(
                text: TextSpan(
                  text: "Already have an account? ",
                  style: CustomFontStyle.normal,
                  children: <TextSpan>[
                    TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => Get.offAndToNamed('/login'),
                      text: 'Login',
                      style: CustomFontStyle.medium,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}