import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MultipleAppTextField extends StatelessWidget {
  const MultipleAppTextField(
      {super.key,
      required this.controller,
      required this.label,
      this.obscureText = false});

  final TextEditingController controller;
  final String label;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      controller: controller,
      validator: emptyValidator,
      maxLines: null,
      keyboardType: TextInputType.multiline,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }

  String? emptyValidator(String? value) {
    if (value?.trim().isEmpty == true) {
      return "обязательное поле";
    }
    return null;
  }
}
