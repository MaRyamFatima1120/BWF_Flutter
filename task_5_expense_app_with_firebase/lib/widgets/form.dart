import 'package:flutter/material.dart';
import 'package:task_5_expense_app_with_firebase/widgets/text_form_field.dart';

class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key});

  @override
  State<MyCustomForm> createState() => _MyCustomFormState();
}

class _MyCustomFormState extends State<MyCustomForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: const Column(
          children: [
            CustomTextForm(
              hintText: "Enter your Email ID",
              labelText: "Email ID",
            ),
            SizedBox(
              height: 20.0,
            ),
            CustomTextForm(
              hintText: "Enter Password",
              labelText: "Password",
            ),
          ],
        ));
  }
}
