import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_5_expense_app_with_firebase/views/auth/sign_up.dart';
import 'package:task_5_expense_app_with_firebase/views/forget_password.dart';
import 'package:task_5_expense_app_with_firebase/widgets/round_button.dart';
import '../../widgets/text_form_field.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../posts/home_screen.dart';
import '../utils/utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool loading = false;

  final _auth = FirebaseAuth.instance;


  @override
  void dispose() {
    super.dispose();
    _email.dispose();
    _password.dispose();
  }

  void login() {
    setState(() {
      loading = true;
    });
    _auth.signInWithEmailAndPassword(
        email: _email.text, password: _password.text.toString()).then((value) {
      Utils().toastMessage((value.user!.email.toString()));
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const HomeScreen()));
      setState(() {
        loading = false;
      });
    }).onError((error, stackTrace) {
      debugPrint(error.toString());
      Utils().toastMessage(error.toString());
      setState(() {
        loading = false;
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Welcome,",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Text(
                  "Login with your Email Id",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        CustomTextForm(
                          hintText: "Enter your Email ID",
                          labelText: "Email ID",
                          controller: _email,
                          validator: (msg) {
                            if (msg?.isEmpty ?? true) {
                              return 'PleaseEnter Email';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        CustomTextForm(
                          hintText: "Enter Password",
                          labelText: "Password",
                          controller: _password,
                          validator: (msg) {
                            if (msg?.isEmpty ?? true) {
                              return "Password must contain 8 digit.";
                            }
                            return null;
                          },
                        ),
                      ],
                    )),
                const SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>const ForgetPassword()));
                      },
                      child: const Text(
                        "Forget Password?",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Center(
                    child: RoundButton(
                      title: "Login",
                      loading: loading,
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          login();
                        }
                        // submit();
                      },
                    )),
                const SizedBox(height: 10,),
                RichText(
                  text: TextSpan(children: [
                    const TextSpan(
                      text: "Don't have an account?",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                    TextSpan(
                        text: "Register",
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) => const SignUpScreen()));
                          }
                    )
                  ]),
                ),
              ],
            ),
          ),
        ));
  }
}
