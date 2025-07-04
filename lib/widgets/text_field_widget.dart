import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final String? hint;
  final String? initialValue;
  final TextInputType? textInputType;
  final bool obscureText;
  final TextEditingController? controller;

   TextFieldWidget({
    Key? key,
    this.initialValue,
    this.hint,
    this.textInputType,
    this.obscureText = false,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      initialValue: controller == null ? initialValue ?? "" : null,
      obscureText: obscureText,
      keyboardType: textInputType ?? TextInputType.text,
      decoration: InputDecoration(
        hintText: hint ?? "",
        hintStyle: TextStyle(fontSize: 15),
        filled: true,
        fillColor:  Color.fromARGB(255, 226, 230, 236),

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
