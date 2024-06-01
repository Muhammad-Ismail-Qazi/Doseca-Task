import 'package:duseca_task/app/components/button.dart';
import 'package:duseca_task/app/constants/validater.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../../../components/textfield.dart';
import '../../../constants/fonts.dart';
import '../../../constants/spaces.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Login",
              style: CustomFontStyle.heading,
            ),
            Spaces.y2,
            CustomTextField(
              textFieldController: controller.emailController,
              hint: 'Email',
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
              text: 'Login',
              onPressed: () {
                controller.login(
                  controller.emailController.text,
                  controller.passwordController.text,
                );
              },
            ),
            Spaces.y2,
            RichText(
              text: TextSpan(
                text: "Don't have an account? ",
                style: CustomFontStyle.normal,
                children: <TextSpan>[
                  TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => Get.offAndToNamed('/signup'),
                    text: 'Sign Up',
                    style: CustomFontStyle.medium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}