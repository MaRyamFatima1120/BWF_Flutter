import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_4_todoapp_with_using_sqlite/services/db.dart';
import 'package:task_4_todoapp_with_using_sqlite/views/home_screen.dart';
import 'package:task_4_todoapp_with_using_sqlite/views/model.dart';

class AddUpdateTask extends StatefulWidget {
  int? todoId;
  String? todoTitle;
  String? todoDesc;
  String? todoDT;
  bool? update;


  AddUpdateTask({super.key,this.todoId,this.todoTitle,this.todoDT,this.todoDesc,this.update});

  @override
  State<AddUpdateTask> createState() => _AddUpdateTaskState();
}

class _AddUpdateTaskState extends State<AddUpdateTask> {
  DBHelper? dbHelper;
  late Future<List<TodoModel>> dataList;

  final _fromKey =GlobalKey<FormState>();

  @override
  void initState(){
    super.initState();
    dbHelper =DBHelper();
    loadData();
  }

  loadData() async{
    dataList  =dbHelper!.getDataList();
  }

  @override
  Widget build(BuildContext context) {
    final titleController =TextEditingController(text: widget.todoTitle);
    final descController =TextEditingController(text: widget.todoDT);
    String appTitle =  "Update Task";
    if(widget.update == true){
      appTitle ="Update Task";
    }
    else {
      appTitle="Add Task";
  }

    return Scaffold(
      appBar: AppBar(
         title:  Text(appTitle,style:const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        letterSpacing: 1,
      ),),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 100),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Form(
                key: _fromKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        minLines: 5,
                        controller: titleController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Write  Notes Here",
                        ),
                        validator: (value){
                          if(value!.isEmpty){
                            return  "Enter Some text";
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 60,),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Material(
                      color: Colors.amber,
                      child: InkWell(
                        onTap: (){
                          if(_fromKey.currentState!.validate()){
                            if(widget.update == true){
                              dbHelper!.update(TodoModel(
                                id: widget.todoId,
                                  title: titleController.text,
                                  desc: descController.text,
                                  dateandtime: widget.todoDT
                              ));
                            }

                            Navigator.push(context, MaterialPageRoute(builder: (context)=>const HomeScreen()));
                            titleController.clear();
                            descController.clear();
                            print("Data added");
                          }
                        },
                        child: Container(
                          alignment: Alignment.center,
                          margin:const EdgeInsets.symmetric(horizontal: 20),
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          width: 120,
                          height: 55,

                          decoration:const BoxDecoration(
                           ///boxShadow: [
                            //   BoxShadow(
                            //     color: Colors.black,
                            //     blurRadius: 5,
                            //    spreadRadius: 1
                            //      )
                            //      ]
                          ),
                          child: const Text("Submit",style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),),
                        ),
                      ),
                    ),
                    Material(
                      color: Colors.redAccent,
                      child: InkWell(
                        onTap: (){
                          setState((){
                            titleController.clear();
                            descController.clear();
                          });
                        },
                        child: Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          width: 120,
                          height: 55,

                          decoration: const BoxDecoration(
                            ///boxShadow: [
                            //   BoxShadow(
                            //     color: Colors.black,
                            //     blurRadius: 5,
                            //    spreadRadius: 1
                            //      )
                            //      ]
                          ),
                          child: const Text("Clear",style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        
      ),
    );
  }
}
