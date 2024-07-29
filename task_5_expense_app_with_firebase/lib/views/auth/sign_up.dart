import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_5_expense_app_with_firebase/views/auth/login_screen.dart';
import '../../widgets/round_button.dart';
import '../../widgets/text_form_field.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../utils/utils.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool loading =false;
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _name =TextEditingController();

  FirebaseAuth _auth =FirebaseAuth.instance;
  

  @override
  void dispose() {
    super.dispose();
    _email.dispose();
    _password.dispose();
  }
  //method
  void SignUp(){
    setState(() {
      loading = true;
    });
    _auth.createUserWithEmailAndPassword(
        email:_email.text.toString() , password: _password.text.toString()).then((value){
      setState(() {
        loading = false;
      });

    }).onError((error,stackTrace){
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
          body: SingleChildScrollView(
            child: Padding(
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
                    "Create your Account",
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
                            hintText: "Enter your Full Name",
                            labelText: "Full Name ",
                            controller: _name,
                            validator: (msg) {
                              if (msg?.isEmpty ?? true) {
                                return 'Please Enter correct name';
                              }
                              return null;
                            },
            
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          CustomTextForm(
                            hintText: "Enter your Email ID",
                            labelText: "Email ID",
                            controller: _email,
                            validator: (msg) {
                              if (msg?.isEmpty ?? true) {
                                return 'Please Enter Email';
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
                    height: 50.0,
                  ),
            
                  Center(
                      child:  RoundButton(
                        title: "Register",
                        loading: loading,
                        onTap: () {
                          if(_formKey.currentState!.validate()){
                          SignUp();

                          }

                        },

                      )),
                  const SizedBox(height: 10,),
                  RichText(
                    text: TextSpan(children: [
                      const TextSpan(
                        text: "Already have an account?",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                      TextSpan(
                          text: "Login",
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap =(){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> const LoginScreen()));
                            }
                      )
                    ]),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
