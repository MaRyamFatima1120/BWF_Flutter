//Two of Design Display Data

import 'package:flutter/material.dart';
//


const Color blueColor = Color(0XFF130040);

class DisplayScreen extends StatelessWidget {
  const DisplayScreen(
      {super.key,
        required this.myName,
        required this.fatherName,
        required this.age,
        required this.city,
        required this.country,
        required this.email,
        required this.address,
        required this.phoneNumber,
        required this.skills,
        required this.gender});

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
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Center(
                  child: Text(
                    "User Data Displayed!",
                    style: TextStyle(
                        color: blueColor, fontSize: 20, fontWeight: FontWeight.bold),
                  )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 500,
                  height: 500,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: blueColor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Name:$myName",
                          style: const TextStyle(color: Colors.white),
                        ),
                        Text("FatherName:$fatherName",
                            style: const TextStyle(color: Colors.white)),
                        Text("Date of Birth:$age",
                            style: const TextStyle(color: Colors.white)),
                        Text("Email:$email",
                            style: const TextStyle(color: Colors.white)),
                        Text("Phone Number:$phoneNumber",
                            style: const TextStyle(color: Colors.white)),
                        //Gender
                        Text("Gender:$gender",
                            style: const TextStyle(color: Colors.white)),
                        //Skills
                        Text("Skill:$skills",
                            style: const TextStyle(color: Colors.white)),

                        Text("City:$city",
                            style: const TextStyle(color: Colors.white)),
                        Text("Country:$country",
                            style: const TextStyle(color: Colors.white)),

                        Text("Address:$address",
                            style: const TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
