
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:task_7_gharforsale_with_firebase/view/regstration_screens/login_screen.dart';
import 'package:task_7_gharforsale_with_firebase/view/regstration_screens/widgets/text_form_field.dart';

class ForgetScreen extends StatefulWidget {
  const ForgetScreen({super.key});

  @override
  State<ForgetScreen> createState() => _ForgetScreenState();
}

class _ForgetScreenState extends State<ForgetScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();


  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Please Enter Email";
    }
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return "Please Enter a valid Email Address";
    }
    return null;
  }



  Future<void> _forgetPassword() async {
    try{
      await FirebaseAuth.instance.sendPasswordResetEmail(email: _emailController.text.trim());
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Password reset email sent!"),
      backgroundColor: Colors.green,
      ));

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const LoginScreen()));
    }on FirebaseAuthException catch(e){
      String errorMessage;

      if(e.code == 'invalid-email'){
        errorMessage = "This email address is invalid.";
      }
      else if(e.code =="user-not-found"){
        errorMessage = "No user found for that email.";
      }
      else{
        errorMessage ="An error occured.Please try again.";
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage,style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.white),),
          backgroundColor: Colors.red,
        ),
      );
    }catch(e){
      print("Error:$e");
      ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
    content: Text('An error occurred. Please try again.',style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.white),),
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
                    Text("Forget Password",
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
                          ],
                        )),
                    SizedBox(
                      height: 3.h,
                    ),

                    Center(
                      child: GestureDetector(
                        onTap: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            _forgetPassword();
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
                                "Forget Password ",
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
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
