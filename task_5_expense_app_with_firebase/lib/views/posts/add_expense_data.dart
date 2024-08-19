import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../../widgets/round_button.dart';
import '../utils/utils.dart';

class AddExpenseData extends StatefulWidget {
  const AddExpenseData({super.key});

  @override
  State<AddExpenseData> createState() => _AddExpenseDataState();
}

class _AddExpenseDataState extends State<AddExpenseData> {
  final merchant = TextEditingController();
  final amount = TextEditingController();
  final description = TextEditingController();
  final date = TextEditingController();
  bool loading = false;
  final databaseRef = FirebaseDatabase.instance.ref('Post');

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    MyTextFormField(
                      controller: merchant,
                      labelText: "Merchant Name",
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    MyTextFormField(
                      controller: amount,
                      labelText: "Amount",
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    MyTextFormField(
                      maxLine: 4,
                      controller: description,
                      labelText: "Description",
                    ),
                    /*   const SizedBox(height:10,),
                 MyTextFormField(
                    icon: Icon(Icons.date_range),
                    controller: description,
                    labelText: "Date",
                  ),*/

                    const SizedBox(
                      height: 30,
                    ),
                    RoundButton(
                      title: "Save Expense ",
                      loading: loading,
                      onTap: () {
                        setState(() {
                          loading =true;
                        });
                        double? parsedAmount =double.tryParse(amount.text.toString());
                        if(parsedAmount ==null){
                          Utils().toastMessage("Invalid Amount Value");
                          setState(() {
                            loading =false;
                          });
                          return;
                        }
                        databaseRef.child(DateTime.now().millisecondsSinceEpoch.toString()).set({
                          'title': merchant.text.toString(),
                          'id': DateTime.now().millisecondsSinceEpoch.toString(),
                          'Amount':parsedAmount,
                          'Description':description.text.toString()
                        }).then((value){
                          Utils().toastMessage("Post Added");
                          setState(() {
                            loading =false;
                          });
                        }).onError((error,stackTrace){
                          Utils().toastMessage(error.toString());
                          setState(() {
                            loading =false;
                          });
                        });
                      },
                    ),
                  ],
                ),
              ),
            )));
  }
}

class MyTextFormField extends StatelessWidget {
  const MyTextFormField(
      {super.key, this.controller, this.labelText, this.maxLine, this.icon});

  final TextEditingController? controller;
  final String? labelText;
  final int? maxLine;

  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLine,
      controller: controller,
      decoration: InputDecoration(
        icon: icon,
        labelText: labelText,
        labelStyle: const TextStyle(color: Colors.black),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            color: Colors.black54,
            width: 2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            color: Color(0xFFfc4f84),
            width: 2,
          ),
        ),
      ),
    );
  }
}
