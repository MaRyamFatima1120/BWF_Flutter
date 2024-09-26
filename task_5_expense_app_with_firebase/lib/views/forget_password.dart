import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task_5_expense_app_with_firebase/views/utils/utils.dart';
import '../../widgets/text_form_field.dart';
import '../widgets/round_button.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFfc4f84),
        title: const Text(
          "Forget Password",
          style: TextStyle(color: Colors.white),
        ),
       iconTheme:const IconThemeData(
         color: Colors.white,
       ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: CustomTextForm(
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
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          RoundButton(
            onTap: () {
              auth
                  .sendPasswordResetEmail(email: _email.text.toString())
                  .then((value) {
                Utils().toastMessage(
                    "We have sent you email to recover password,Please check email.");
              }).onError((error, stackTrace) {
                Utils().toastMessage(error.toString());
              });
            },
            title: 'Forget',
          ),
        ],
      ),
    ));
  }
}
