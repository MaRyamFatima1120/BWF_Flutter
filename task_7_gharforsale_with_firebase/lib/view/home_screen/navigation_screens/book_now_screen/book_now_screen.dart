import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:task_7_gharforsale_with_firebase/view/home_screen/navigation_screens/navigation_home_screen/navigation_home_screen.dart';



class BookNowScreen extends StatefulWidget {
  const BookNowScreen({super.key});

  @override
  _BookNowScreenState createState() => _BookNowScreenState();
}

class _BookNowScreenState extends State<BookNowScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  String? selectedCountry = 'Pakistan';
  String? selectedGender = 'Male';

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Please Enter Email";
    }
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return "Please Enter a valid email address";
    }
    return null;
  }

  String? validateData(String? value) {
    if (value == null || value.isEmpty) {
      return "Please Enter Field";
    }
    return null;
  }
  String? validateMobile(String? value) {
    // General international phone number validation pattern
    String pattern = r'^\+?[1-9]\d{1,14}$';  // Accepts phone numbers with a "+" followed by 10 to 15 digits
    RegExp regExp = RegExp(pattern);
    if (value == null || value.isEmpty) {
      return 'Please enter your mobile number';
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter a valid phone number (e.g., +1234567890)';
    }
    return null;
  }
  void handleGenderChange(String? value) {
    setState(() {
      selectedGender = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Text(
          "Booking Tour",
          style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 18.sp,
              fontWeight: FontWeight.w700),
        ),
      ),),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding:const EdgeInsets.all(16),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             SizedBox(height: 2.h,),
             Text(
               "Name",
               style: GoogleFonts.poppins(
                   color: Colors.black,
                   fontSize: 18.sp,
                   fontWeight: FontWeight.w700),
             ),
             Padding(
               padding: const EdgeInsets.symmetric(horizontal: 10.0),
               child: TextFormField(
                 keyboardType: TextInputType.text,
                 controller: nameController,
                 validator: validateData,
                 decoration: InputDecoration(
                   hintText: "i.e Maryam",
                   hintStyle:  GoogleFonts.poppins(
                       color:  const Color(0xffcfd6ed),
                       fontSize: 16.sp,
                       fontWeight: FontWeight.w400,
                   ),
                   fillColor: const Color(0xfff4f6f9),
                   filled: true,
                   border: OutlineInputBorder(
                     borderRadius: BorderRadius.circular(10),
                     borderSide: BorderSide.none,
                   ),
                 ),
               ),
             ),
             Text(
               "Email",
               style: GoogleFonts.poppins(
                   color: Colors.black,
                   fontSize: 18.sp,
                   fontWeight: FontWeight.w700),
             ),
             Padding(
               padding: const EdgeInsets.symmetric(horizontal: 10.0),
               child: TextFormField(
                 keyboardType: TextInputType.emailAddress,
                 controller: emailController,
                 validator: validateEmail,
                 decoration: InputDecoration(
                   hintText: "example@gmail.com",
                   hintStyle:  GoogleFonts.poppins(
                     color:  const Color(0xffcfd6ed),
                     fontSize: 16.sp,
                     fontWeight: FontWeight.w400,
                   ),
                   fillColor: const Color(0xfff4f6f9),
                   filled: true,
                   border: OutlineInputBorder(
                     borderRadius: BorderRadius.circular(10),
                     borderSide: BorderSide.none,
                   ),
                 ),
               ),
             ),
             Text(
               "Gender",
               style: GoogleFonts.poppins(
                   color: Colors.black,
                   fontSize: 18.sp,
                   fontWeight: FontWeight.w700),
             ),
             Row(
               children: [
                 Expanded(
                   child: RadioListTile<String>(
                     title: Text('Male',style: GoogleFonts.poppins(
                         color: Colors.black,
                         fontSize: 12.sp,
                         fontWeight: FontWeight.w700),),
                     value: 'Male',
                     groupValue: selectedGender,
                     onChanged: handleGenderChange,
                   ),
                 ),
                 Expanded(
                   child: RadioListTile<String>(
                     title: Text('Female',style: GoogleFonts.poppins(
                         color: Colors.black,
                         fontSize: 12.sp,
                         fontWeight: FontWeight.w700),),
                     value: 'Female',
                     groupValue: selectedGender,
                     onChanged: handleGenderChange,
                   ),
                 ),
                 Expanded(

                   child: RadioListTile<String>(
                     title: Text('Other',style: GoogleFonts.poppins(
                         color: Colors.black,
                         fontSize: 12.sp,
                         fontWeight: FontWeight.w700),),
                     value: 'Other',
                     groupValue: selectedGender,
                     onChanged: handleGenderChange,
                   ),
                 ),
               ],
             ),
             Text(
               "Mobile Number",
               style: GoogleFonts.poppins(
                   color: Colors.black,
                   fontSize: 18.sp,
                   fontWeight: FontWeight.w700),
             ),
             Padding(
               padding: const EdgeInsets.symmetric(horizontal: 10.0),
               child: TextFormField(
                 keyboardType: TextInputType.number,
                 controller: mobileController,
                 validator: validateMobile,
                 decoration: InputDecoration(
                   hintText: "*92 345 0000000",
                   hintStyle:  GoogleFonts.poppins(
                     color:  const Color(0xffcfd6ed),
                     fontSize: 16.sp,
                     fontWeight: FontWeight.w400,
                   ),
                   fillColor: const Color(0xfff4f6f9),
                   filled: true,
                   border: OutlineInputBorder(
                     borderRadius: BorderRadius.circular(10),
                     borderSide: BorderSide.none,
                   ),
                 ),
               ),
             ),
             Text(
               "Country",
               style: GoogleFonts.poppins(
                   color: Colors.black,
                   fontSize: 18.sp,
                   fontWeight: FontWeight.w700),
             ),
             DropdownButtonFormField<String>(
               value: selectedCountry,
               onChanged: (newValue) => setState(() => selectedCountry = newValue),
               items: <String>['Pakistan', 'India', 'USA', 'UK']
                   .map<DropdownMenuItem<String>>((String value) {
                 return DropdownMenuItem<String>(
                   value: value,
                   child: Text(value,style:   GoogleFonts.poppins(
                     color:  Colors.black,
                     fontSize: 16.sp,
                     fontWeight: FontWeight.w400,
                   ),),
                 );
               }).toList(),
               decoration: InputDecoration(

                 fillColor: const Color(0xfff4f6f9),
                 filled: true,
                 border: OutlineInputBorder(
                   borderRadius: BorderRadius.circular(10),
                   borderSide: BorderSide.none,
                 ),),
             ),
             SizedBox(
               height: 4.h,
             ),
             Center(
               child: ElevatedButton(onPressed: (){
                 if (_formKey.currentState!.validate()) {
                   saveToFirebase();
                 }
               },
                 style: ElevatedButton.styleFrom(
                   minimumSize: Size(80.w, 8.h),
                   backgroundColor:const Color(0xff006eff),

                 ), child: Text("Continue", style: GoogleFonts.poppins(
               color: Colors.white,
                   fontSize: 18.sp,
                   fontWeight: FontWeight.w700),),

               ),
             )
           ],
          ),
        ),
      ),
    );
  }

  void saveToFirebase() {
    FirebaseFirestore.instance.collection('bookings').add({
      'name': nameController.text,
      'email': emailController.text,
      'gender': selectedGender,
      'mobile': mobileController.text,
      'country': selectedCountry,
      'timestamp': FieldValue.serverTimestamp(),
    }).then((result) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ConfirmationScreen()),
      );
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to book tour: $error'))
      );
    });
  }
}

class ConfirmationScreen extends StatelessWidget {
  const ConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Request Received!')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle, size: 100, color: Colors.blue),
            const Text(
              "We're Checking if the home can be seen on Fri, October 4, 6:00 pm",
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            const Text('Agent Will take you on the tour!'),


            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>NavigationHomeScreen()));
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff006eff),
                    foregroundColor: Colors.white),
                child: Text(
                  "Continue",
                  style: GoogleFonts.poppins(
                      fontSize: 16.sp, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
