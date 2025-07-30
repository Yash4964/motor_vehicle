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
  final passwordRegExp = RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d).{4,}$');
  //final licenceno=RegExp(r'^GJ[0-9]{2}[0-9]{4}[0-9]{6}$');
  // final carvali = RegExp(r'^[A-Z]{2}[0-9]{2}[A-Z]{2}[0-9]{1,4}$');
   final carvali = RegExp(r'^\d{4}$');


   TextFieldWidget({
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
            if (inputTypeMode == InputTypeMode.password) {
              if (value == null || value.isEmpty)
              {
                return "Password is required";
              }
              else if (value.length < 4)
              {
                return "Minimum length 4 characters";
              }
              else if (!passwordRegExp.hasMatch(value))
              {
                return "Must include uppercase, lowercase, number";
              }
            }
            if(inputTypeMode == InputTypeMode.age)
              {
                final age = int.tryParse(value);
                if (age == null)
                {
                  return "Please enter a valid number";
                }
                else if (age < 18)
                {
                  return "Age must be 18+ or above";
                }
              }
            if(inputTypeMode == InputTypeMode.licenceno)
            {
              if(value == null || value.length != 16) {
                return "Please enter a valid 16-digit phone number";
              }
            }
            if(inputTypeMode == InputTypeMode.carno )
              {
                if(value == null || value.length != 4 ) {
                  return "Please enter valid 4-digit number";
                }
                else if(!carvali.hasMatch(value) ){
                  return "Invalide Car No";
                }
              }
            if(inputTypeMode == InputTypeMode.modelno )
            {
              if(value == null || value.length != 4) {
                return "Please enter valid 4-digit number";
              }
              else if(!carvali.hasMatch(value) ){
                return "Invalide model No";
              }
            }
            if(inputTypeMode == InputTypeMode.days)
              {
                final day = int.tryParse(value);
                if(day == null)
                  {
                    return "Not null days";
                  }
                else if(day < 1 || day > 30)
                  {
                    return "Range 1 - 30 days";
                  }
              }
            if(inputTypeMode == InputTypeMode.km)
            {
              final km = int.tryParse(value);
              if(km == null)
              {
                return "Not null days";
              }
              else if(km < 5 || km > 10)
              {
                return "Range 5 - 10 km";
              }
            }
            return null;
          },
    );
  }
}
