import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task_5_expense_app_with_firebase/views/auth/login_screen.dart';
import 'package:task_5_expense_app_with_firebase/views/posts/add_expense_data.dart';
import '../bottomnvigationpages/dashboard.dart';
import '../utils/utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final auth = FirebaseAuth.instance;
  int _selectedItem = 0;
  final _bottompages =  [  Dashboard(),Settings()];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFfc4f84),
        title: const Text(
          "Expense App",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {
              auth.signOut().then((value) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()));
              }).onError((error, stackTrace) {
                Utils().toastMessage(error.toString());
              });
            },
            icon: const Icon(
              Icons.logout,
              size: 25,
            ),
            color: Colors.white,
          )
        ],
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: _bottompages[_selectedItem],
          bottomNavigationBar: BottomAppBar(
            shape: const CircularNotchedRectangle(),
            notchMargin: 6.0,
            child: SizedBox(
              height: 100.0, // Set a fixed height for the BottomAppBar
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  IconButton(
                    icon: const Icon(Icons.home),
                    onPressed: () {
                      setState(() {
                        _selectedItem = 0;
                      });
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.settings),
                    onPressed: () {
                      setState(() {
                        _selectedItem = 1;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            floatingActionButton: FloatingActionButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>const AddExpenseData()));
            },
              child: const Icon(Icons.add,color: Colors.pinkAccent,),
            ),



      /*
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 7.0,
        child: Container(
          height: 150.0,
          child: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Icon(Icons.home), label: "Dashboard"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), label: "Settings")
            ],
            currentIndex: _selectedItem,
            onTap: (setValue) {
              setState(() {
                _selectedItem = setValue;
              });
            },
          ),
        ),
      ),floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton(onPressed: (){

          },
            child: const Icon(Icons.add,color: Colors.pinkAccent,),
          ),*/
    ));
  }
}
