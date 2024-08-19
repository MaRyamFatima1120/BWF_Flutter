import 'dart:ui';

import 'package:ecommerce_app/screen/login_screen.dart';
import 'package:ecommerce_app/screen/widget/text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final _formKey =GlobalKey<FormState>();
  final _email =TextEditingController();
  final auth =FirebaseAuth.instance;

  String? validateEmail(String? value){
    if(value == null || value.isEmpty) {
      return "Please Enter Email";
    }
    if(!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)){
      return "Please Enter a valid email address";
    }
    return null;
  }

  void forgetPassword() async {
    try{
      await auth.sendPasswordResetEmail(
          email: _email.text.toString());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Password reset email sent. Please check your inbox."),
      backgroundColor: Colors.green,));
    }catch (e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("'Failed to send password reset email. Please try again."),
      backgroundColor: Colors.redAccent,));
      print('Error: $e');
    }

  }

  @override
  Widget build(BuildContext context) {
    var screenWidth =MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(


      body: SingleChildScrollView(
        child: Container(
          //height:double.infinity,
          width: screenWidth,
          height: screenHeight,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/1.jpg"),
              fit: BoxFit.fill,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaY: 4.0,
                  sigmaX: 4.0,
                ),
                child: Container(
                  color: Colors.black,
                ),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    "Forget Password",
                    style: GoogleFonts.yellowtail(
                        textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 50,
                        )),
                  ),
                ),
              ),
              SizedBox(
                  height: screenHeight * 0.01
              ),
              Expanded(
                flex:2,
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1, vertical: screenHeight * 0.01),
                        child: TextFormField1(
                          keyboardType: TextInputType.emailAddress,
                          label: 'Email',
                          controller: _email,
                          validator: validateEmail,
                        ),
                      ),
                      SizedBox(
                          height: screenHeight * 0.05,
                      ),
                      InkWell(
                        onTap: forgetPassword,


                        child: Container(
                          width: screenWidth * 0.7,
                          height: screenHeight * 0.07,
                          decoration: BoxDecoration(
                            color: Colors.white,

                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Center(
                            child: Text(
                              "Forget Password".toUpperCase(),
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                ),
              ),


            ],
          ),
        ),
      ),
    );
  }
}
