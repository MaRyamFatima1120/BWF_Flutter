import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/screen/login_screen.dart';
import 'package:ecommerce_app/screen/widget/text_field.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:google_fonts/google_fonts.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _obscureText = true;
  bool _isLoading =false;

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Please Enter Email";
    }
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return "Please Enter a valid email address";
    }
    return null;
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _createAccount() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isLoading = true;
      });
      try {
       UserCredential userCredential =await _auth.createUserWithEmailAndPassword(
            email: _email.text.toString(),
            password: _password.text.toString());
       String uid =userCredential.user!.uid;
       //Saver user details to FireStore
       await FirebaseFirestore.instance.collection('users').doc(uid).set({
         'name':_name.text.toString(),
         'email':_email.text.toString(),
         'role':'buyer'
       });


        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(
          content: Text(
            "User Account created successfully.",
            style: TextStyle(
                color: Colors.white, fontSize: 20),
          ),
          backgroundColor: Colors.redAccent,
        ));
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) =>
                const LoginScreen()));
      } on FirebaseAuthException catch (e) {
        String errorMessage;
        switch (e.code) {
          case "email-already-in-use":
            errorMessage =
            "The email is already in use by another account.";
            break;
          case "invalid-email":
            errorMessage =
            "The email address is not valid.";
            break;
          case "weak-password":
            errorMessage = "The password is too weak.";
            break;
          default:
            errorMessage = "An unknown error occurred.";
            break;
        }
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(
          content: Text(
            errorMessage,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.red,
        ));
      }
      finally{
        setState(() {
          _isLoading =false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
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
                    "Ecommerce App",
                    style: GoogleFonts.yellowtail(
                        textStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 50,
                    )),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.005),
              Expanded(
                flex: 2,
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.1,
                            vertical: screenHeight * 0.01),
                        child: TextFormField1(
                            keyboardType: TextInputType.text,
                            label: "Name",
                            controller: _name,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Name is required.";
                              }
                              return null;
                            }),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.1,
                            vertical: screenHeight * 0.01),
                        child: TextFormField1(
                          keyboardType: TextInputType.emailAddress,
                          label: 'Email',
                          controller: _email,
                          validator: validateEmail,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.1,
                            vertical: screenHeight * 0.01),
                        child: TextFormField1(
                          keyboardType: TextInputType.text,
                          label: 'Password',
                          obscureText: _obscureText,
                          iconButton: IconButton(
                              onPressed: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                              icon: Icon(
                                _obscureText
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.white,
                              )),
                          controller: _password,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please Enter Password";
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.1),
                      InkWell(
                        onTap: _createAccount,
                        child: Stack(
                          alignment:Alignment.center,
                          children: [
                            Center(
                              child: Container(
                                width: screenWidth * 0.7,
                                height: screenHeight * 0.07,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                child: Visibility(
                                  visible: !_isLoading,
                                  child: Center(
                                    child: Text(
                                      "Create Account".toUpperCase(),
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            if(_isLoading)
                             const Center(
                               child: CircularProgressIndicator(
                                 color: Colors.black,
                               ),
                             ),
                          ],
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
