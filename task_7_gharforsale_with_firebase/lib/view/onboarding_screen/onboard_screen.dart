import 'package:flutter/material.dart';
import 'package:onboarding_intro_screen/onboarding_screen.dart';
import 'package:task_7_gharforsale_with_firebase/view/regstration_screens/login_screen.dart';


class OnBoardScreen extends StatefulWidget {
  const OnBoardScreen({super.key});

  @override
  State<OnBoardScreen> createState() => _OnBoardScreenState();
}

class _OnBoardScreenState extends State<OnBoardScreen> {
  @override
  Widget build(BuildContext context) {
    return OnBoardingScreen(
      onSkip: () {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const LoginScreen()));
      },

      showPrevNextButton: true,
      showIndicator: true,
      backgourndColor: Colors.white,
      activeDotColor: const Color(0xff006eff),
      deactiveDotColor:const  Color(0xffd2e0ff),
      iconColor: const Color(0xff006eff),
      leftIcon: Icons.arrow_circle_left_outlined,
      rightIcon: Icons.arrow_circle_right_rounded,
      iconSize: 30,
      pages: [
        OnBoardingModel(
          image: Image.asset("assets/images/onboard_image/1.png"),
          title: "Lorem Ipsum is simply dummy",
          body:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
        ),
        OnBoardingModel(
          image: Image.asset("assets/images/onboard_image/2.png"),
          title: "Lorem Ipsum is simply dummy",
          body:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
        ),
        OnBoardingModel(
          image: Image.asset("assets/images/onboard_image/3.png"),
          title:  "Lorem Ipsum is simply dummy",
          body:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
        ),

      ],
    );
  }
}
