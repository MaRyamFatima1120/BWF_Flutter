import 'dart:async';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/screen/buyer/buyer_screen.dart';
import 'package:ecommerce_app/screen/seller/seller_screen.dart';
import 'package:ecommerce_app/screen/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Timer? _timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;

    if (user != null) {
      _checkUserRole(user.uid);
    } else {
      _timer = Timer(
          const Duration(seconds: 8),
          () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => const LoginScreen())));
    }
  }

  void _checkUserRole(String uid) async{
    try{
      DocumentSnapshot userDoc =await FirebaseFirestore.instance.collection("users").doc(uid).get();

      if(userDoc.exists){
        String role =userDoc['role'];

        if(role == 'seller'){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const SellerScreen()));
        }
        else{
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const BuyerScreen()));
        }
      }
      else{
        // If the user does not exist in Firestore, navigate to login
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const LoginScreen()));
      }
    }
    catch(e){
      print("Error fetching user role:$e");
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const LoginScreen()));
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd, MMMM yyyy').format(now);
    String formattedTime = DateFormat("hh:mm a").format(now);

    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: screenHeight,
          width: screenWidth,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/1.jpg"),
              fit: BoxFit.fill,
            ),
          ),
          child: Stack(
            children: [
              BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaY: 2.0,
                  sigmaX: 2.0,
                ),
                child: Container(
                  color: Colors.black.withOpacity(0.5),
                  height: screenHeight,
                  width: screenWidth,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.1,
                        vertical: screenHeight * 0.1),
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
                  InkWell(
                    onTap: () {
                      _timer?.cancel();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Signup()));
                    },
                    child: Container(
                      width: screenWidth * 0.7,
                      height: screenHeight * 0.1,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Center(
                        child: Text(
                          "Sign Up".toUpperCase(),
                          style: const TextStyle(
                            color: Color(0xFF064c76),
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.05,
                  ),
                  InkWell(
                    onTap: () {
                      _timer?.cancel();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()));
                    },
                    child: Container(
                      width: screenWidth * 0.7,
                      height: screenHeight * 0.1,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          border: Border.all(
                              color: Colors.white,
                              width: 4,
                              strokeAlign: BorderSide.strokeAlignInside)),
                      child: Center(
                        child: Text(
                          "Login".toUpperCase(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.1,
                  ),
                  Text(
                    formattedTime,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    formattedDate,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.01,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
