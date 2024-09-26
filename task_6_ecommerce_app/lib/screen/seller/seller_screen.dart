import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/screen/login_screen.dart';
import 'package:ecommerce_app/screen/seller/oder_management.dart';
import 'package:ecommerce_app/screen/seller/seller_product_view.dart';
import 'package:ecommerce_app/screen/seller/text_form_fied.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SellerScreen extends StatefulWidget {
  const SellerScreen({super.key});

  @override
  State<SellerScreen> createState() => _SellerScreenState();
}

class _SellerScreenState extends State<SellerScreen> {
  final _formKey = GlobalKey<FormState>();
  final _productName =TextEditingController();
  final _productDescription =TextEditingController();
  final _productPrice =TextEditingController();

  File? _productImage;
  final ImagePicker _picker = ImagePicker();

  final auth =FirebaseAuth.instance;
  void _signOut() async{
    try {
      await auth.signOut();
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const LoginScreen()));
    } catch(e){
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Error Signout:$e "),
            backgroundColor: Colors.redAccent,
          ));
    }
  }
  Future<void> _pickImage() async{
    print("Pick Image Button Pressed");
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      setState(() {
        if(pickedFile != null){
          _productImage = File(pickedFile.path);
        }
        else{
          print("No image selected");
        }
      });
  }

  Future<String> _uploadImage(File? image) async{
    if(image == null){
      throw Exception("No image selected");
    }
    // Create a reference to the location in Firebase Storage
    final Reference storageReference =FirebaseStorage.instance.ref().child(
      'products/${DateTime.now().millisecondsSinceEpoch}_${image.uri.pathSegments.last}');
        //upload the file to Firebase Storage
    final UploadTask uploadTask =storageReference.putFile(image);

    //wait

    final TaskSnapshot snapshot = await uploadTask;

    //get
    final String downloadUrl =await snapshot.ref.getDownloadURL();

    return downloadUrl;

  }

  

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor:const Color(0xFFdf1b33),
          title: const Text("Seller Dashboard",style:TextStyle(color: Colors.white)),
          actions: [
            IconButton(onPressed:_signOut, icon: const Icon(Icons.logout_sharp),color: Colors.white,)
          ],
        ),

        body: SingleChildScrollView(
          child: Column(
            children: [
              const  Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(child: Text("Add Product",style: TextStyle(fontSize: 24,fontWeight: FontWeight.w700),)),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
                      child: TextFormField2(label: 'Product Name',
                        controller: _productName,
                        validator: (value){
                          if(value == null || value.isEmpty){
                            return "Please Enter Product Names";
                          }
                          return null;
                        },
                        keyboardType:TextInputType.text ,
          
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
                      child: TextFormField2(
                        label: 'Product Description',
                        controller: _productDescription,
                      keyboardType: TextInputType.text,
                      validator: (value){
                          if(value == null || value.isEmpty){
                            return "Please Enter Product Description";
                          }
                          return null;
                      },
                        maxLines: 3,
          
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
                      child: TextFormField2(label: 'Price',
                        controller: _productPrice,
                        validator: (value){
                          if(value == null || value.isEmpty){
                            return "Please Enter Price in Pkr";
                          }
                          return null;
                        },
                        keyboardType:TextInputType.number ,
          
                      ),
                    ),
                    _productImage!=null?Image.file(
                      _productImage!,
                      height: 200,
                      width: 200,
                      fit: BoxFit.cover,
                    ):const Text("No image selected."),
                    const SizedBox(height: 10,),
                    ElevatedButton(onPressed: _pickImage,
          
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        backgroundColor: const Color(0xFFdf1b33),
                        foregroundColor: Colors.white,
                      ),
                      child: const Text("Pick Product Image",style: TextStyle(
                        //color: Colors.white
                      ),),
                    ),
                    const SizedBox(height: 15,),
                    ElevatedButton(
                      onPressed: () async{
                        if(_formKey.currentState!.validate()){
                          try{
                            String imageUrl =_productImage!=null ? await _uploadImage(_productImage!):'';
                            FirebaseFirestore.instance.collection('products').add({
                              'name':_productName.text,
                              'description':_productDescription.text,
                              'price':_productPrice.text,
                              'imageUrl':imageUrl,

                            });
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Products added Successfully",style: TextStyle(color: Colors.white)),
                              backgroundColor: Colors.green,
                            ));

                            // Clear text fields and image after successful addition
                            _productName.clear();
                            _productDescription.clear();
                            _productPrice.clear();
                            setState(() {
                              _productImage =null;
                            });
                          }
                          catch(e){
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error adding Product:$e",style: const TextStyle(color: Colors.white),),
                              backgroundColor: Colors.redAccent,
                            ),
                            );
                            print(e);


                          }
                          }

                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        backgroundColor:Colors.white,
                        foregroundColor: Colors.black,
                      ),
                      child: const Text("Add Product",style: TextStyle(
                        //color: Colors.white
                      ),),
                    ),
                   const SizedBox(height: 10,),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                     children: [
                     ElevatedButton(onPressed: (){
                       Navigator.push(context, MaterialPageRoute(builder: (context)=>const SellerProductView()));
                     },
                         style: ElevatedButton.styleFrom(
                           shape: RoundedRectangleBorder(
                             borderRadius: BorderRadius.circular(5.0),
                           ),
                           backgroundColor: const Color(0xFFdf1b33),
                           foregroundColor: Colors.white,
                         ),
                         child: const Text(
                             "Product View")),
                     ElevatedButton(onPressed: (){
                       Navigator.push(context, MaterialPageRoute(builder: (context)=> OrderManagementScreen()));
                     },
                         style: ElevatedButton.styleFrom(

                           shape: RoundedRectangleBorder(
                             borderRadius: BorderRadius.circular(5.0),
                           ),
                           backgroundColor: const Color(0xFFdf1b33),
                           foregroundColor: Colors.white,
                         ),child: const Text(
                             "Order Management ",
                         )),
                   ],)

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
