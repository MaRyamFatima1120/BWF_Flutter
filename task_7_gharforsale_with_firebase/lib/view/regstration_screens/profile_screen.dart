import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:task_7_gharforsale_with_firebase/view/regstration_screens/widgets/text_form_field.dart';
import 'package:task_7_gharforsale_with_firebase/view/swip_screen/swipe_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  final ImagePicker _picker =ImagePicker();
  String _profileImage ='';// Store the URL of the profile image

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadProfileImage();
  }

  //load profileImage

  Future<void> _loadProfileImage() async {
    try {
      String userId = FirebaseAuth.instance.currentUser!.uid;
      // Fetch the user document from Firestore
      final doc = await FirebaseFirestore.instance.collection('users').doc(userId).get();
      setState(() {
        // Update the profile image URL from the document data
        _profileImage = doc.data()?['profile_picture'] ?? '';
      });
    } catch (e) {
      print('Error loading profile image: $e');
    }
  }
  //Pick an image

  Future<void> _pickImage() async{

    final pickedFile=await _picker.pickImage(source: ImageSource.gallery);
    if(pickedFile != null){
     await _uploadImage(pickedFile.path);
    }
  }

  //Upload the Image to Firebase Storage

  Future<void> _uploadImage(String filePath) async{
    final file=File(filePath);
    try{
      String userId = FirebaseAuth.instance.currentUser!.uid;
     final storageRef= FirebaseStorage.instance.ref().child('profile_pictures').child("$userId.jpg");

     final uploadTask=storageRef.putFile(file);
     final snapshot=await uploadTask.whenComplete((){});
     final downloadUrl = await snapshot.ref.getDownloadURL();
     await _updateProfilePicture(downloadUrl);
    }catch(e){
      print("Error uploading Image:$e");
    }
  }


  Future<void> _updateProfilePicture(String imageUrl) async {
    try {
      String userId = FirebaseAuth.instance.currentUser!.uid;
      final userDoc = FirebaseFirestore.instance.collection('users').doc(userId);

      // Check if the document exists
      final docSnapshot = await userDoc.get();
      if (docSnapshot.exists) {
        // Update the document if it exists
        await userDoc.update({
          'profile_picture': imageUrl,
        });
      } else {
        // Create the document if it doesn't exist
        await userDoc.set({
          'profile_picture': imageUrl,
          // You can add other fields here if necessary
        });
      }

      // Update local state with the new image URL
      setState(() {
        _profileImage = imageUrl;
      });

    } catch (e) {
      print('Error updating profile picture: $e');
    }
  }


  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  String? validateUsername(String? value){
    if(value == null || value.isEmpty){
      return "Please Enter Username.";
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Please Enter Email";
    }
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return "Please Enter a valid Email Address";
    }
    return null;
  }

  String? validatePassword(String? password) {
    List<String> errors = [];
    if (password == null || password.isEmpty) {
      return "Please Enter Password";
    }
    if (password.length < 8) {
      errors.add("*.Password must be at least 8 characters long.");
    }
    if (!RegExp(r"[A-Z]").hasMatch(password)) {
      errors.add("*.Password must contain at least one uppercase letter.");
    }
    if (!RegExp(r"[a-z]").hasMatch(password)) {
      errors.add("*.Password must contain at least one lowercase letter.");
    }
    if (!RegExp(r"[0-9]").hasMatch(password)) {
      errors.add("*.Password must contain at least one number.");
    }
    // If there are any errors, join them with newlines and return as a single string
    if (errors.isNotEmpty) {
      return errors.join("\n");
    }
    return null;
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: SingleChildScrollView(
          child: Container(
            margin:const EdgeInsets.all(20.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,

                children: [
                  Center(child: Text("Complete Your profile",style:Theme.of(context).textTheme.titleMedium)),
                  Center(child: Text("Don’t worry, only you can see your personal\ndata. No one else will be able to see it.",style:Theme.of(context).textTheme.titleSmall?.copyWith(color: const Color(0xffB0B0B0)),
                    textAlign: TextAlign.center,
                  )
                  ),
                  SizedBox(height: 2.h,),
                  GestureDetector(
                    onTap: _pickImage,
                    child: CircleAvatar(
                      radius: 65,
                      backgroundImage: _profileImage.isNotEmpty?NetworkImage(_profileImage):const AssetImage('assets/images/profile.png') as ImageProvider,
                  ),
                  ),
                  Form(
                      key: _formKey,
                      child: Column(
                       //mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Name",
                              style: Theme.of(context).textTheme.titleSmall),
                          SizedBox(
                            height: 1.h,
                          ),
                          TextFormField1(
                            keyboard: TextInputType.emailAddress,
                            hintText: "Username",
                            controller: _usernameController,
                            validator: validateUsername,
                            icon:
                            const Icon(Icons.person, color: Color(0xff909090)),
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          Text("Mobile Number",
                              style: Theme.of(context).textTheme.titleSmall),
                          SizedBox(
                            height: 1.h,
                          ),
                          TextFormField1(
                            keyboard: TextInputType.phone,
                            hintText: "Enter your phone number",
                            controller: _phoneController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your phone number';
                              }
                              return null;
                            },
                            icon:
                            const Icon(Icons.call, color: Color(0xff909090)),
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          Text("Email Address",
                              style: Theme.of(context).textTheme.titleSmall),
                          SizedBox(
                            height: 1.h,
                          ),
                          TextFormField1(
                            keyboard: TextInputType.emailAddress,
                            hintText: "Email",
                            controller: _emailController,
                            validator: validateEmail,
                            icon:
                            const Icon(Icons.email, color: Color(0xff909090)),
                          ),
                          SizedBox(
                            height: 3.h,
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Center(
                            child: GestureDetector(
                              onTap: () {
                                if (_formKey.currentState?.validate() ?? false) {
                                  _completeProfile();
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
                                      "Complete Profile",
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
                      )),


              ],),
            ),
          ),
        ),
      ),
    );
  }

  //Method to complete profile

Future<void> _completeProfile() async{
    try{
      String userId=FirebaseAuth.instance.currentUser!.uid;

      // Prepare user data

      final userData = {
        'username':_usernameController.text,
        'phone':_phoneController.text,
        'email':_emailController.text,
        'profile_picture':_profileImage,
      };

      // Update user document in Firestore
      final userDoc=FirebaseFirestore.instance.collection('users').doc(userId);

      // Check if the document exists
      final docSnapshot = await userDoc.get();
      if (docSnapshot.exists) {
        // Update the document if it exists
        await userDoc.update(userData);
      } else {
        // Create the document if it doesn't exist
        await userDoc.set(userData);
      }

      // Optionally, you can show a success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated successfully!')),
      );


      // Navigate to the HomeScreen
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const SwipeScreen()));



    }
    catch(e){
      print('Error updating profile: $e');
      // Optionally, you can show an error message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to update profile. Please try again.')),
      );
    }
  }
}
