import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/screen/buyer/buyer_screen.dart';
import 'package:ecommerce_app/screen/forget_password.dart';
import 'package:ecommerce_app/screen/seller/seller_screen.dart';
import 'package:ecommerce_app/screen/widget/text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _obscureText=true;
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

  Future<void> _SignInAccount() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isLoading = true;
      });
      try {
        UserCredential userCredential =await _auth.signInWithEmailAndPassword(
            email: _email.text.toString(),
            password: _password.text.toString());

        String uid =userCredential.user!.uid;

        //
        // Fetch user details from Firestore
        DocumentSnapshot userDoc =await FirebaseFirestore.instance.collection('users').doc(uid).get();

        String role  =userDoc ['role'];

        if(role=='seller'){
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const SellerScreen()),
          );
        }
        else{
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const BuyerScreen()));
        }
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "Login Successfully",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            backgroundColor: Colors.redAccent,
          ),
        );

      }on FirebaseAuthException catch (e) {
        String errorMessage = "An unknown error occurred.";
        if (e.code == 'invalid-email' || e.code == 'wrong-password') {
          errorMessage = "Invalid email or password.";
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              errorMessage,
              style: const TextStyle(fontSize: 20, color: Colors.white),
            ),
            backgroundColor: Colors.red,
          ),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    double getResponsiveSize(double baseSize, {double minSize = 12, double maxSize = 55}) {
      double scaleFactorWidth = screenWidth / 375.0; // base width
      double scaleFactorHeight = screenHeight / 812.0; // base height
      double scaleFactor = (scaleFactorWidth + scaleFactorHeight) / 2;

      double scaledSize = baseSize * scaleFactor;
      return scaledSize.clamp(minSize, maxSize);
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
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
              Text(
                "Ecommerce App",
                style: GoogleFonts.yellowtail(
                    textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: getResponsiveSize(50),
                )),
              ),
              SizedBox(
                height:screenHeight * 0.03 ,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.1, vertical: screenHeight * 0.02),
                      child: TextFormField1(
                        keyboardType: TextInputType.emailAddress,
                        label: 'Email',
                        controller: _email,
                        validator: validateEmail,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.1, vertical: screenHeight * 0.02),
                      child: TextFormField1(
                        keyboardType: TextInputType.text,
                        label: 'Password',
                        obscureText: _obscureText,
                        controller: _password,
                        iconButton: IconButton(

                          onPressed: (){
                            setState(() {
                              _obscureText=!_obscureText;
                            });
                          }, icon: Icon(
                          _obscureText?Icons.visibility:Icons.visibility_off,color: Colors.white,
                        ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please Enter Password";
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height:screenHeight * 0.05 ,
              ),

              InkWell(
                onTap: _SignInAccount,
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
                              "Login".toUpperCase(),
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
              SizedBox(
                height:screenHeight * 0.05 ,
              ),
              Align(
                alignment: Alignment.topCenter,
                child: InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const ForgetPassword()));
                  },
                  child: Text("Forget Password?",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize:getResponsiveSize(16),
                        fontWeight: FontWeight.w500,

                      )),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
