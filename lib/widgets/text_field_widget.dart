import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final String? hint;
  final String? initialValue;
  final TextInputType? textInputType;
  final bool obscureText;
  final TextEditingController? controller;

  const TextFieldWidget({
    super.key,
    this.initialValue,
    this.hint,
    this.textInputType,
    this.obscureText = false,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue ?? "",
      controller: controller,
      obscureText: true,
      keyboardType: textInputType ?? TextInputType.text,
      decoration: InputDecoration(
        hintText: hint ?? "",
        hintStyle: TextStyle(fontSize: 15),
        filled: true,
        fillColor:const Color.fromARGB(255, 226, 230, 236),
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
