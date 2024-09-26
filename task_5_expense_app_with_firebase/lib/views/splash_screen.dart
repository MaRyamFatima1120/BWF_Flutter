import 'package:flutter/material.dart';
import 'package:task_5_expense_app_with_firebase/firebase_services/splash_servicees.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  SplashServices ss =SplashServices();
  @override
  void initState(){
    super.initState();
    ss.isLogin(context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SizedBox(
        width: double.infinity,
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/download.png"),
            const Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                      text: 'E',
                      style: TextStyle(
                          color: Color(0xFFfc4f84),
                          fontSize: 30,
                          fontWeight: FontWeight.bold)),
                  TextSpan(
                    text: 'XPENSE APP',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Color(0xFF333041)),
                  ),
                ],
              ),
            ),
            const Text("TRACKER",style: TextStyle(
              color: Color(0xFF333041),
              fontSize: 24,
              letterSpacing: 4.0,

            ),)
          ],
        ),
      ),
    ));
  }
}
