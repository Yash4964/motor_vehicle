import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final String? hint;
  final TextInputType? textInputType;
  final bool obscureText;
  final TextEditingController? controller;

  const TextFieldWidget({
    super.key,
    this.hint,
    this.textInputType,
    this.obscureText = false,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: textInputType ?? TextInputType.text,
      decoration: InputDecoration(
        hintText: hint ?? "",
        filled: true,
        fillColor: const Color.fromARGB(255, 241, 241, 241),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
