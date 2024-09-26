import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:task_7_gharforsale_with_firebase/view/regstration_screens/profile_screen.dart';
import 'package:task_7_gharforsale_with_firebase/view/regstration_screens/forget_screen.dart';
import 'package:task_7_gharforsale_with_firebase/view/regstration_screens/registration_screen.dart';
import 'package:task_7_gharforsale_with_firebase/view/regstration_screens/widgets/text_form_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscureController = true;

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Please Enter Email";
    }
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return "Please Enter a valid Email Address";
    }
    return null;
  }

  String? validatePassword(String? password) {
    List<String> errors = [];
    if (password == null || password.isEmpty) {
      return "Please Enter Password";
    }
    if (password.length < 8) {
      errors.add("*.Password must be at least 8 characters long.");
    }
    if (!RegExp(r"[A-Z]").hasMatch(password)) {
      errors.add("*.Password must contain at least one uppercase letter.");
    }
    if (!RegExp(r"[a-z]").hasMatch(password)) {
      errors.add("*.Password must contain at least one lowercase letter.");
    }
    if (!RegExp(r"[0-9]").hasMatch(password)) {
      errors.add("*.Password must contain at least one number.");
    }
    // If there are any errors, join them with newlines and return as a single string
    if (errors.isNotEmpty) {
      return errors.join("\n");
    }
    return null;
  }

  Future<void> _signIn() async {
    try {
      final UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: _emailController.text.trim(),
              password: _passwordController.text.trim());
//print
      print("Successfully Signed in :${userCredential.user?.email}");

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          "User Account Sign in successfully.",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        backgroundColor: Color(0xff006eff),
      ));

//Navigate
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const ProfileScreen()));
    } catch (e) {
      print("Sign-in failed:$e.toString");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Sign-in failed: ${e.toString()} \nPlease check your credentials or sign up if you don't have an account.",
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(20),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child: Image.asset("assets/images/registration_image/logo.png")),
                SizedBox(
                  height: 5.h,
                ),
                Text("Sign in",
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontSize: 18.sp)),
                SizedBox(
                  height: 1.h,
                ),
                Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Email",
                            style: Theme.of(context).textTheme.titleSmall),
                        SizedBox(
                          height: 1.h,
                        ),
                        TextFormField1(
                          keyboard: TextInputType.emailAddress,
                          hintText: "Email",
                          controller: _emailController,
                          validator: validateEmail,
                          icon: const Icon(Icons.person,
                              color: Color(0xff909090)),
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        Text("Password",
                            style: Theme.of(context).textTheme.titleSmall),
                        SizedBox(
                          height: 1.h,
                        ),
                        TextFormField1(
                          keyboard: TextInputType.text,
                          hintText: "Password",
                          obscureText: _obscureController,
                          validator: validatePassword,
                          controller: _passwordController,
                          icon: const Icon(Icons.key, color: Color(0xff909090)),
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _obscureController = !_obscureController;
                                });
                              },
                              icon: Icon(
                                _obscureController
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: _obscureController
                                    ? const Color(0xff909090)
                                    : Colors.red,
                              )),
                        ),
                      ],
                    )),
                SizedBox(
                  height: 3.h,
                ),
                TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ForgetScreen()));
                    },
                    child: Text("Forget Password?",
                        style: Theme.of(context).textTheme.titleSmall)),
                SizedBox(
                  height: 2.h,
                ),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        _signIn();
                      }
                    },
                    child: Container(
                      width: 80.w,
                      height: 7.h,
                      decoration: BoxDecoration(
                        color: const Color(0xff006eff),
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      child: Center(
                          child: Text(
                        "Sign in ",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                                fontSize: 18.sp),
                      )),
                    ),
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Center(
                  child: Text.rich(TextSpan(children: [
                    TextSpan(
                        text: "Don't have an account? ",
                        style: Theme.of(context).textTheme.titleSmall),
                    TextSpan(
                        text: "Signup",
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall
                            ?.copyWith(color: const Color(0xff006eff)),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const RegistrationScreen()));
                          }),
                  ])),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
