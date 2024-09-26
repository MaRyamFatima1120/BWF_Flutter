//For Signup and login Screen
import 'package:flutter/material.dart';

class TextFormField1 extends StatelessWidget {

   const TextFormField1({
    super.key,
    required this.label,
    this.controller,
    this.keyboardType,
    this.validator,
    this.obscureText = false,
    this.iconButton
  });

  final String label;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final bool obscureText;
  final IconButton? iconButton;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
     obscureText: obscureText,

     // style:const TextStyle(color:Colors.white),
      decoration: InputDecoration(
        label: Text(
          label.toUpperCase(),
          style: const TextStyle(
              fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
        ),
          suffixIcon: iconButton,

        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
            width: 3,
          ),
        ),
        focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.white,
          width: 3,
        ),
      ),
        errorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.redAccent,
            width: 3,
          ),
        ),
        focusedErrorBorder: const UnderlineInputBorder(

          borderSide: BorderSide(
            color: Colors.white,
            width: 3,
          ),
        ),
      ),
    );
  }
}
