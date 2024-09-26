import 'package:flutter/material.dart';

class TextFormField1 extends StatelessWidget {
  final TextEditingController? controller;
  final TextInputType? keyboard;
  final String? hintText;
  final bool obscureText;
  final String? Function(String?)? validator;
  final Icon? icon;
  final IconButton? suffixIcon;

  //constructor with named parameter
  const TextFormField1(
      {super.key,
      this.controller,
      this.keyboard,
      this.hintText,
      this.obscureText = false,
      this.validator,
      this.icon,
      this.suffixIcon});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: controller,
        keyboardType: keyboard,
        validator: validator,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: Theme.of(context).textTheme.titleSmall?.copyWith(
            color: const Color(0xff909090)
          ),
          prefixIcon: icon,
          suffixIcon: suffixIcon,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(
                color: Color(0xff6A6A6A),
              )),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(
                color: Color(0xff6A6A6A),
              )),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(color: Colors.redAccent)),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(
                color: Color(0xff6A6A6A),
              )),
        ));
  }
}
