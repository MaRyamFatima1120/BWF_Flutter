import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';


class Dashboard extends StatefulWidget {
  const Dashboard({super.key,});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  
  final ref =FirebaseDatabase.instance.ref('Post');
  @override
  Widget build(BuildContext context) {
    return  SafeArea(child: Scaffold(
      body: Column(

        children: [
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Center(child: Text("Good Morning",style: TextStyle(fontWeight: FontWeight.w800,fontSize: 30),)),
          ),
          Expanded(
            child: FirebaseAnimatedList(
                query: ref,
                defaultChild: Center(child: Text("Not Add yet",style:TextStyle(fontSize: 26) ,)),
                itemBuilder:(context,snapshot,animation,index){
                  return Container(
                    color: Colors.pinkAccent,
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(snapshot.child('title').value.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24,color: Colors.white),),
                          subtitle: Text(snapshot.child('Description').value.toString(),style: TextStyle(fontSize: 18,color: Colors.white),),
                          trailing: Text(snapshot.child('Amount').value.toString(),style: TextStyle(fontSize: 18,color: Colors.white),),
                        ),
                        Divider(
                          color: Colors.black,
                        )
                      ],
                    ),

                  );
                }),
          ),

        ],
      )
    ));
  }
}

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(child: Scaffold(
      body: Center(
        child: Text("Setting Page"),
      ),
    ));
  }
}
