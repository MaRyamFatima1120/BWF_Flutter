import 'package:flutter/material.dart';
import 'package:task_3_ten_widgets_and_navigation/views/display_screen.dart';

enum gendertype { Male, Female, other }

const Color blueColor = Color(0XFF130040);

class UserForm extends StatefulWidget {
  const UserForm({super.key});

  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final _myFormKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _fatherName = TextEditingController();
  final _email = TextEditingController();
  final _phoneNumber = TextEditingController();
  final _address = TextEditingController();
  final _city = TextEditingController();
  final _country = TextEditingController();
  final _dob = TextEditingController();

  Map<String, bool> skills = {
    "Flutter": false,
    "Dart": false,
    "React": false,
    //  "Angular":false,
    //"Cyber Security":false,
  };

  gendertype? gender;

  bool isChecked = true;

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
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            child: Form(
              key: _myFormKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),

                  //Name
                  CustomTextForm(
                    hintText1: 'Enter Your Name',
                    labelText1: 'Name',
                    controller: _name,
                    prefixIcon: const Icon(
                      Icons.person,
                      color: blueColor,
                    ),
                    validator: (msg) {
                      if (msg?.isEmpty ?? true) {
                        return "Please Enter Name";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  //Father Name
                  CustomTextForm(
                    hintText1: 'Enter Your Father Name',
                    labelText1: 'Father Name',
                    controller: _fatherName,
                    prefixIcon: const Icon(
                      Icons.person,
                      color: blueColor,
                    ),
                    validator: (msg) {
                      if (msg?.isEmpty ?? true) {
                        return "Please Enter Father Name";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  //Age
                  CustomTextForm(
                    hintText1: 'Pick your Date of Birth',
                    labelText1: 'Your Date of Birth',
                    controller: _dob,
                    prefixIcon: IconButton(
                        onPressed: () async {
                          DateTime? datePicked = await showDatePicker(
                              context: context,
                              firstDate: DateTime(1970),
                              lastDate: DateTime(2024));
                          if (datePicked != null) {
                            //int age = DateTime.now().year - datePicked.year;
                            var formattedDate =
                                "${datePicked.day}/${datePicked.month}/${datePicked.year}";
                            setState(() {
                              _dob.text = formattedDate.toString();
                            });
                          }
                        },
                        icon: const Icon(
                          Icons.date_range,
                          color: blueColor,
                        )),
                    validator: (msg) {
                      if (msg?.isEmpty ?? true) {
                        return "Please Enter Field";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  //Gender
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Gender",
                        style: TextStyle(
                            color: blueColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: RadioListTile(
                          activeColor: blueColor,
                          title: const Text("Male",
                              style: TextStyle(fontSize: 12)),
                          value: gendertype.Male,
                          groupValue: gender,
                          onChanged: (value) {
                            setState(() {
                              gender = value;
                            });
                          },
                        ),
                      ),
                      Expanded(
                        child: RadioListTile(
                          activeColor: blueColor,
                          title: const Text(
                            "Female",
                            style: TextStyle(fontSize: 12),
                          ),
                          value: gendertype.Female,
                          groupValue: gender,
                          onChanged: (value) {
                            setState(() {
                              gender = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: RadioListTile(
                          activeColor: blueColor,
                          title: const Text("Other",
                              style: TextStyle(fontSize: 12)),
                          value: gendertype.other,
                          groupValue: gender,
                          onChanged: (value) {
                            setState(() {
                              gender = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  //Email
                  CustomTextForm(
                    hintText1: 'Enter Email',
                    labelText1: 'Email',
                    controller: _email,
                    prefixIcon: const Icon(
                      Icons.email,
                      color: blueColor,
                    ),
                    validator: (msg) {
                      if (msg?.isEmpty ?? true) {
                        return "Please Enter Field";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  //Phone Number
                  CustomTextForm(
                    labelText1: 'Phone No.',
                    controller: _phoneNumber,
                    prefixIcon: const Icon(
                      Icons.phone,
                      color: blueColor,
                    ),
                    mykey: TextInputType.number,
                    validator: (msg) {
                      if (msg?.isEmpty ?? true) {
                        return "Please Enter Field";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),

                  //Skills
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Skill",
                        style: TextStyle(
                            color: blueColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    ),
                  ),

                  //Checkbox for Skills
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: skills.keys.map((String key) {
                      return Expanded(
                          child: Row(
                        children: [
                          Checkbox(
                              value: skills[key],
                              onChanged: (bool? value) {
                                setState(() {
                                  skills[key] = value!;
                                });
                              }),
                          Text(key),
                        ],
                      ));
                    }).toList(),
                  ),

                  //city
                  CustomTextForm(
                    hintText1: 'Enter City Name',
                    labelText1: 'City',
                    controller: _city,
                    prefixIcon: const Icon(
                      Icons.location_city,
                      color: blueColor,
                    ),
                    validator: (msg) {
                      if (msg?.isEmpty ?? true) {
                        return "Please Enter Field";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  //country
                  CustomTextForm(
                    hintText1: 'Enter Country Name',
                    labelText1: 'Country',
                    controller: _country,
                    prefixIcon: const Icon(
                      Icons.location_on_outlined,
                      color: blueColor,
                    ),
                    validator: (msg) {
                      if (msg?.isEmpty ?? true) {
                        return "Please Enter Field";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  //Address
                  CustomTextForm(
                    hintText1: 'Enter Address',
                    labelText1: 'Address',
                    controller: _address,
                    prefixIcon: const Icon(
                      Icons.location_on,
                      color: blueColor,
                    ),
                    validator: (msg) {
                      if (msg?.isEmpty ?? true) {
                        return "Please Enter Field";
                      }
                      return null;
                    },
                  ),

                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 150,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        _myFormKey.currentState!.validate();
                        submitFunction();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: blueColor,
                      ),
                      child: const Center(
                          child: Text(
                        "Submit",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      )),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void submitFunction() {
    String name = _name.text;
    String fatherName = _fatherName.text;
    String email = _email.text;
    String address = _address.text;
    String phone = _phoneNumber.text;
    String city = _city.text;
    String country = _country.text;
    String age = _dob.text;
    String selectedgender = gender.toString().split(".").last;

    List<String> selectedSkills = [];
    skills.forEach((key, value) {
      if (value) {
        selectedSkills.add(key);
      }
    });
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => DisplayScreen(
                myName: name,
                fatherName: fatherName,
                age: age,
                skills: selectedSkills.join(","),
                city: city,
                country: country,
                email: email,
                address: address,
                phoneNumber: phone,
                gender: selectedgender,
              )),
    );
  }
}

class CustomTextForm extends StatelessWidget {
  const CustomTextForm({
    super.key,
    this.hintText1,
    this.labelText1,
    this.prefixIcon,
    required this.validator,
    required this.controller,
    this.mykey,
  });

  final String? hintText1;
  final String? labelText1;
  final Widget? prefixIcon;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final TextInputType? mykey;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: hintText1,
        hintStyle: const TextStyle(color: blueColor, fontSize: 12),
        labelText: labelText1,
        labelStyle: const TextStyle(color: blueColor, fontSize: 12),
        prefixIcon: prefixIcon,
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(11),
            borderSide: const BorderSide(
              color: blueColor,
              width: 2,
            )),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(11),
          borderSide: const BorderSide(
            color: blueColor,
            width: 2,
          ),
        ),
        //When Error Come then below type of decoration should be come
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(11),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 2,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(11),
          borderSide: const BorderSide(
            color: blueColor,
            width: 2,
          ),
        ),
        errorStyle: const TextStyle(color: Colors.red),
      ),
      controller: controller,
      validator: validator,
      keyboardType: mykey,
    );
  }
}
