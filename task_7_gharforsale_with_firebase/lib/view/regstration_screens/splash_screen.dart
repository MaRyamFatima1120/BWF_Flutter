
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:task_7_gharforsale_with_firebase/view/swip_screen/swipe_screen.dart';
import 'package:task_7_gharforsale_with_firebase/view/onboarding_screen/onboard_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkLoginUser();
  }


  void checkLoginUser(){
   User? user= FirebaseAuth.instance.currentUser;

  Future.delayed(const Duration(seconds: 3),(){
    if(user != null){
      Timer(const Duration(seconds: 8), (){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const SwipeScreen()));
      });
    }
    else{

      Timer(const Duration(seconds: 8), (){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const OnBoardScreen()));
      });
    }
  });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        width: 100.w,
        height: 100.h,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 100.w,
              height: 70.h,
              decoration:const  BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/splash_screen.png"),
                      fit: BoxFit.cover
                  )
              ),
            ),
            SizedBox(height: 5.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Image.asset("assets/images/home.png"),
                SizedBox(width: 5.w,),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: "Gharr ",
                        style: Theme.of(context).textTheme.titleMedium
                      ),
                      TextSpan(
                        text: "For.",
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(color: const Color(0xff006eff))
                      ),
                      TextSpan(
                          text: "Sale",
                          style: Theme.of(context).textTheme.titleMedium
                      ),
                    ]
                  )
                ),
              ],
            ),
            SizedBox(height: 3.h,),
           /*
            GestureDetector(
              onTap: (){

                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const OnBoardScreen()));
              },
              child: Container(
                width: 80.w,
                height: 7.h,
                decoration: BoxDecoration(
                  color: const Color(0xff006eff),
                  borderRadius: BorderRadius.circular(40.0),
                ),
                child: Center(child: Text("Get Started",style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w400,color: Colors.white,fontSize: 18.sp),)),
              ),
            )
           */
          ],
        ),
      ),
    );
  }
}
