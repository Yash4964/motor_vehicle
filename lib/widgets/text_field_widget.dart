import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor_vehicle/utils/app_enum.dart';

class TextFieldWidget extends StatelessWidget {
  final String? hint;
  final String? initialValue;
  final TextInputType? textInputType;
  final bool obscureText;
  final InputTypeMode inputTypeMode;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;

  const TextFieldWidget({
    Key? key,
    this.initialValue,
    this.hint,
    this.textInputType,
    this.obscureText = false,
    this.controller,
    this.validator,
    this.inputTypeMode = InputTypeMode.normal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      initialValue: controller == null ? initialValue ?? "" : null,
      obscureText: obscureText,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: textInputType ?? TextInputType.text,
      decoration: InputDecoration(
        hintText: hint ?? "",
        hintStyle: const TextStyle(fontSize: 15),
        filled: true,
        fillColor: const Color(0xFFF3F4F6),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
      validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please Enter Value';
            }else
            if(inputTypeMode == InputTypeMode.email){
              if(!GetUtils.isEmail(value)){
                return "Please enter valid email";
              }
            }
            if(inputTypeMode == InputTypeMode.phone){

                if(!GetUtils.isPhoneNumber(value) || value.length != 10)
                  {
                    return "Please enter a valid 10-digit phone number";
                  }
            }
            if(inputTypeMode == InputTypeMode.pincode)
            {
              if(value.length != 6)
              {
                return "Please enter a valid 6-digit phone number";
              }
            }
            return null;
          },
    );
  }
}
