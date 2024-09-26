import 'package:flutter/material.dart';


class CustomTextForm extends StatelessWidget {
  final String? hintText;
  final String? labelText;
  final TextEditingController? controller;
  final FormFieldValidator? validator;
  const CustomTextForm({super.key,this.hintText,this.labelText,this.controller,this.validator});


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
          hintText: hintText,
          labelText: labelText,

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide:const BorderSide(
              color: Color(0xFFfc4f84),
              width: 2,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(
              color: Colors.black,
              width: 2,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(
              color: Colors.redAccent,
              width: 2,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(
              color: Color(0xFFfc4f84) ,
              width: 2,
            ),

          ),
          errorStyle: const TextStyle(color: Colors.redAccent)
      ),
      controller: controller,
      validator: validator,
    );
  }
}
