import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/screen/seller/text_form_fied.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditProductScreen extends StatefulWidget {
  final String productId;
  final String productName;
  final String productDescription;
  final String productPrice;
  final String productImageUrl;

  const EditProductScreen(
      {super.key,
      required this.productId,
      required this.productName,
      required this.productDescription,
      required this.productPrice,
      required this.productImageUrl});

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _formKey = GlobalKey<FormState>();
  final _productNameController = TextEditingController();
  final _productDescriptionController = TextEditingController();
  final _productPriceController = TextEditingController();
  File? _productImage;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _productNameController.text =widget.productName;
    _productDescriptionController.text =widget.productDescription;
    _productPriceController.text =widget.productPrice;
  }

  final auth = FirebaseAuth.instance;
  Future<void> _pickImage() async {
    print("Pick Image Button Pressed");
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _productImage = File(pickedFile.path);
      } else {
        print("No image selected");
      }
    });
  }

  Future<String> _uploadImage(File? image) async {
    if (image == null) {
      throw Exception("No image selected");
    }
    // Create a reference to the location in Firebase Storage
    final Reference storageReference = FirebaseStorage.instance.ref().child(
        'products/${DateTime.now().millisecondsSinceEpoch}_${image.uri.pathSegments.last}');
    //upload the file to Firebase Storage
    final UploadTask uploadTask = storageReference.putFile(image);

    //wait

    final TaskSnapshot snapshot = await uploadTask;

    //get
    final String downloadUrl = await snapshot.ref.getDownloadURL();

    return downloadUrl;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFdf1b33),
        centerTitle: true,
        title: const Text("Update Products",
            style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 10.0),
                    child: TextFormField2(
                      label: 'Product Name',
                      controller: _productNameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please Enter Product Names";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.text,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 10.0),
                    child: TextFormField2(
                      label: 'Product Description',
                      controller: _productDescriptionController,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please Enter Product Description";
                        }
                        return null;
                      },
                      maxLines: 3,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 10.0),
                    child: TextFormField2(
                      label: 'Price',
                      controller: _productPriceController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please Enter Price in Pkr";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  _productImage != null
                      ? Image.file(
                          _productImage!,
                          height: 200,
                          width: 200,
                          fit: BoxFit.cover,
                        )
                      : const Text("No image selected."),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: _pickImage,
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      backgroundColor: const Color(0xFFdf1b33),
                      foregroundColor: Colors.white,
                    ),
                    child: const Text(
                      "Pick Product Image",
                      style: TextStyle(
                          //color: Colors.white
                          ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        try {
                          String imageUrl = _productImage != null
                              ? await _uploadImage(_productImage!)
                              : '';
                          FirebaseFirestore.instance
                              .collection('products')
                              .doc(widget.productId).update({
                            'name': _productNameController.text,
                            'description': _productDescriptionController.text,
                            'price': _productPriceController.text,
                            'imageUrl': imageUrl,
                          });
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Products Update Successfully",
                                style: TextStyle(color: Colors.white)),
                            backgroundColor: Colors.green,
                          ));
                          Navigator.pop(context);
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "Error updating Product:$e",
                                style: const TextStyle(color: Colors.white),
                              ),
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
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                    ),
                    child: const Text(
                      "Update Product",
                      style: TextStyle(
                          //color: Colors.white
                          ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
