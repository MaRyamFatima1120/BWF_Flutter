import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task_5_expense_app_with_firebase/views/auth/login_screen.dart';
import 'package:task_5_expense_app_with_firebase/views/posts/home_screen.dart';

class SplashServices {
  void isLogin(BuildContext context) {
    final auth =FirebaseAuth.instance;
    //if user is login
    final user = auth.currentUser;
    if(user != null){
      Timer(
          const Duration(seconds: 3),
              () => Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => const HomeScreen())));

    }
    else{
      Timer(
          const Duration(seconds: 3),
              () => Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => const LoginScreen())));
    }

  }
}
