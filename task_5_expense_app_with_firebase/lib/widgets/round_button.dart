import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final bool loading;

  const RoundButton(
      {super.key, required this.title, required this.onTap, this.loading = false });


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 300,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(10.0),

        ),
        child: Center(child: loading
            ? const CircularProgressIndicator(strokeWidth:2,color: Colors.white,)
            : Text(title, style: const TextStyle(
            color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),)),
      ),
    );
  }
}
