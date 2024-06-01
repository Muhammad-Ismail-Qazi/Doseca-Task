import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController textFieldController;
  final String hint;
  final TextInputType keyboardType;
  final FormFieldValidator<String>? validator;
  final IconButton? suffixIcon;
  final bool visibility;

  const CustomTextField({
    Key? key,
    required this.textFieldController,
    required this.hint,
    required this.keyboardType,
    this.validator,
    required this.visibility,
    this.suffixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: visibility,
      controller: textFieldController,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        suffixIcon:suffixIcon,
        hintText: hint,
      ),
      validator: validator,
    );
  }
}