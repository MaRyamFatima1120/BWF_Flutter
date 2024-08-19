import 'package:flutter/material.dart';

const Color blueColor = Color(0XFF130040);

class DisplayScreen extends StatelessWidget {
  const DisplayScreen({
    Key? key,
    required this.myName,
    required this.fatherName,
    required this.age,
    required this.city,
    required this.country,
    required this.email,
    required this.address,
    required this.phoneNumber,
    required this.skills,
    required this.gender,
  }) : super(key: key);

  final String myName;
  final String fatherName;
  final String age;
  final String email;
  final String phoneNumber;
  final String gender;
  final String skills;
  final String city;
  final String country;
  final String address;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: blueColor,
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.dataset_rounded, color: Colors.white),
            ),
          ],
          title: const Text(
            "User Data",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: blueColor,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "User Data Displayed!",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      buildUserDataItem("Name", myName),
                      buildUserDataItem("Father's Name", fatherName),
                      buildUserDataItem("Date of Birth", age),
                      buildUserDataItem("Gender", gender),
                      buildUserDataItem("Email", email),
                      buildUserDataItem("Phone Number", phoneNumber),
                      buildUserDataItem("Skills", skills),
                      buildUserDataItem("City", city),
                      buildUserDataItem("Country", country),
                      buildUserDataItem("Address", address),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildUserDataItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$label:",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
