import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
//import 'package:google_sign_in/google_sign_in.dart';
import 'package:sizer/sizer.dart';
import 'package:task_7_gharforsale_with_firebase/view/regstration_screens/login_screen.dart';
import 'package:task_7_gharforsale_with_firebase/view/regstration_screens/widgets/text_form_field.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscureController = true;

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


  Future<void> _signup() async {
    try {
      final UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      print("Successfully Account created  :${userCredential.user?.email}");

      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        try {
          await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
            'email': user.email,
            'username': _usernameController.text.trim(),
            'createdAt': Timestamp.now(),
          });
        } catch (e) {
          print("Error writing to Firestore: $e");
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              "Failed to save user data. Please try again later.",
              style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.white),
            ),
            backgroundColor: Colors.red,
          ));
          return;
        }
      }

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          "User Account created successfully.",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        backgroundColor: Colors.green,
      ));

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
      );
    } on FirebaseAuthException catch (e) {
      String errorMessage = "";
      if (e.code == 'network-request-failed') {
        errorMessage = "Network error. Please check your connection.";
      } else if (e.code == 'email-already-in-use') {
        errorMessage = 'The email is already in use.';
      } else if (e.code == 'invalid-email') {
        errorMessage = 'The email format is invalid.';
      } else if (e.code == 'weak-password') {
        errorMessage = 'The password is too weak.';
      }

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          errorMessage,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      ));
    } catch (e) {
      print("Error:$e");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          "An error occurred: $e. Please try again later.",
          style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      ));
    }
  }

 /*
 final GoogleSignIn _googleSignIn =GoogleSignIn();

  Future<void> _signInWithGoogle() async{
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if(googleUser == null) {
        return;
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication  googleAuth = await googleUser.authentication;

      // Create a new credential
      final credential =GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken
      );

      //Sign in with user credential

      final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);


      //check if user is new or existing

      if(userCredential.additionalUserInfo?.isNewUser ?? false){
        // If the user is new, create a document in Firestore

        await FirebaseFirestore.instance.collection('users').doc(userCredential.user?.uid).set({
          'email':userCredential.user?.email,
          'username':userCredential.user?.displayName ??  'Unknown',
          'createdAt':Timestamp.now(),
        });
      }

      print("Successfully signed in with Google: ${userCredential.user?.email}");
// Navigate to the next screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginScreen(), // Adjust this to your next screen
        ),
      );

    } on FirebaseAuthException catch (e) {
      String errorMessage = "";
      if (e.code == 'network-request-failed') {
        errorMessage = "Network error. Please check your connection.";
      } else if (e.code == 'account-exists-with-different-credential') {
        errorMessage = 'An account already exists with a different credential.';
      } else if (e.code == 'invalid-credential') {
        errorMessage = 'The credential provided is invalid.';
      }

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          errorMessage,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      ));
    } catch (e) {
      print("Error: $e");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          "An error occurred: $e. Please try again later.",
          style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      ));
    }
  }
 */



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
                    Image.asset("assets/images/registration_image/logo.png"),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text("Sign Up",
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
                            Text("Username",
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
                              icon:
                              const Icon(Icons.email, color: Color(0xff909090)),
                            ),
                            SizedBox(
                              height: 3.h,
                            ),
                            Text("Password",
                                style: Theme.of(context).textTheme.titleSmall),
                            SizedBox(
                              height: 1.h,
                            ),
                            TextFormField1(
                              keyboard: TextInputType.text,
                              hintText: "Password",
                              obscureText: _obscureController,
                              validator: validatePassword,
                              controller: _passwordController,
                              icon: const Icon(Icons.key, color: Color(0xff909090)),
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _obscureController = !_obscureController;
                                    });
                                  },
                                  icon: Icon(
                                    _obscureController
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: _obscureController
                                        ? const Color(0xff909090)
                                        : Colors.red,
                                  )),
                            ),
                          ],
                        )),
                    SizedBox(
                      height: 3.h,
                    ),

                    Center(
                      child: GestureDetector(
                        onTap: () {
                          if (_formKey.currentState?.validate() ?? false ) {
                            _signup();
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
                                "Sign up ",
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                    fontSize: 18.sp),
                              )),
                        ),
                      ),
                    ),
                    SizedBox(height: 2.h,),
                    Center(
                      child: Text.rich(
                          TextSpan(
                              children: [
                                TextSpan(
                                    text: "Already have an account? ",
                                    style: Theme.of(context).textTheme.titleSmall
                                ),
                                TextSpan(
                                    text: "Login",
                                    style: Theme.of(context).textTheme.titleSmall?.copyWith(color: const Color(0xff006eff)),
                                    recognizer:TapGestureRecognizer()
                                      ..onTap=(){
                                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const LoginScreen()));
                                      }
                                ),

                              ]
                          )
                      ),
                    ),
                    SizedBox(height: 2.h,),
                    /*                   Row(
                      children: [
                        const Expanded(
                          child: Divider(
                            height: 4,
                              color: Color(0xff909090),
                            thickness: 2,
                            endIndent: 2,
                          ),
                        ),
                      Text("or continue with",style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: const Color(0xff909090)
                      ),),
                        const Expanded(
                          child: Divider(
                            indent: 2,
                            height: 4,
                            color: Color(0xff909090),
                            thickness: 2,
                          ),
                        ),
                    ],),
                    SizedBox(
                      height: 2.h,
                    ),

                   Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                            onTap: _signInWithGoogle,
                            child: Image.asset("assets/images/registration_image/google.png")),
                        SizedBox(width:8.w),
                        InkWell(
                            onTap: (){},
                            child: Image.asset("assets/images/registration_image/facebook (1).png")),

                      ],
                    )
                   * */
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
