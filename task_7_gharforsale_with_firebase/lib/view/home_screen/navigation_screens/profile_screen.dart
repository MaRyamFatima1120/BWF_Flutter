import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class BottomProfileScreen extends StatefulWidget {
  const BottomProfileScreen({super.key});

  @override
  State<BottomProfileScreen> createState() => _BottomProfileScreenState();
}

class _BottomProfileScreenState extends State<BottomProfileScreen> {

  String? imageUrl;
  User? currentUser; // To store the current user
  Map<String,dynamic>? userData;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCurrentUser();
  }

  void _getCurrentUser() {
    currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      _getImageFromFirebase(currentUser!.uid);
      _getUserDataFromFirestore(currentUser!.uid);
    }
  }

  Future<void> _getImageFromFirebase(String uid) async {
    try {
      //Get the image URL from Firebase Storage

      String download = await FirebaseStorage.instance
          .ref('profile_pictures/$uid.jpg')
          .getDownloadURL();
      setState(() {
        imageUrl = download;
      });
    } catch (e) {
      print("Error fetching image: :$e");
    }
  }

  //Fetch User data from Firestore

  // Fetch user data from Firestore
  Future<void> _getUserDataFromFirestore(String uid) async {
    try {
      DocumentSnapshot userDoc =
      await FirebaseFirestore.instance.collection('users').doc(uid).get();
      setState(() {
        userData = userDoc.data() as Map<String, dynamic>?;
      });
    } catch (e) {
      print("Error fetching user data: $e");
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // backgroundColor: Colors.blue,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              ClipPath(
                clipper: CustomClipPath(),
                child: Container(
                  width: double.infinity,
                  height: 60.h,

                  decoration: BoxDecoration(
                  color: Colors.purple,
                    image:imageUrl != null
                        ? DecorationImage(
                      image: NetworkImage(imageUrl!), // Use the imageUrl fetched from Firebase
                      fit: BoxFit.cover, // Make the image cover the entire container
                    )
                        : null,
                  ),
                  ),
              ),
              Positioned(
                bottom: 80,
                child: CircleAvatar(
                  radius: 125,
                  backgroundColor:Colors.white,

                  child: CircleAvatar(
                    radius: 120,
                    backgroundImage: imageUrl != null
                        ? NetworkImage(imageUrl!)
                        : null,
                    child: imageUrl == null
                        ? const Icon(
                      Icons.person,
                      size: 30,
                    )
                        : null,
                  ),
                ),
              ),]
            ,
          ),

          // Display user data such as name and email
          userData != null
              ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  " ${userData!['username'] ?? 'N/A'}",
                  style: TextStyle(fontSize: 25.sp, fontWeight: FontWeight.bold),
                ),
                const Divider(
                  thickness: 2,
                  indent: 20.0,
                  endIndent: 20.0,
                  color: Colors.black,
                ),
                SizedBox(height: 1.w,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0,vertical: 15),

                  child: Row(
                    children: [
                      const Icon(Icons.email_outlined),
                      SizedBox(width: 3.w,),
                      Text(
                        "${userData!['email'] ?? 'N/A'}",
                        style: TextStyle(fontSize: 16.sp),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 1.w,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0,vertical: 15),
                  child: Row(

                    children: [
                      const Icon(Icons.call),
                      SizedBox(width: 3.w,),
                      Text(
                        "${userData!['phone'] ?? 'N/A'}",
                        style: TextStyle(fontSize: 16.sp),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 5.h,),
                Text(
                  "Developed by Maryam Fatima",
                  style: TextStyle(fontSize: 16.sp),
                ),

              ],
            ),
          )
              : const CircularProgressIndicator(), // Show loader while fetching data


        ],
      ),
    );

  }
}

class CustomClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double w = size.width;
    double h = size.height;

    // Create a new Path object
    Path path = Path();

    // Define your custom clipping path
    path.lineTo(0, h * 0.75); // Move to 75% of the height on the left
    path.quadraticBezierTo(w / 2, h/2, w, h * 0.75); // Draw a curved line
    path.lineTo(w, 0); // Complete the path to the top-right corner

    path.close(); // Close the path

    return path; // Return the defined path
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false; // Return true if you want to update the clip when the widget changes
  }
}

