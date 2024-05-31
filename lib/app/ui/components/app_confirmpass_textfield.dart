import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AppConfirmPasswordTextField extends StatelessWidget {
  const AppConfirmPasswordTextField({
    super.key,
    required this.controller,
    required this.confirmedController,
    required this.label,
    this.obscureText = false,
  });

  final TextEditingController controller;
  final TextEditingController confirmedController;
  final String label;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      controller: controller,
      maxLines: 1,
      validator: (value) {
        if (value?.isEmpty == true) {
          return 'обязательное поле';
        }
        if (value != confirmedController.text) {
          return 'Password should be the same';
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }

  String? emptyValidator(String? value) {
    if (value?.isEmpty == true) {
      return "обязательное поле";
    }
    return null;
  }
}
