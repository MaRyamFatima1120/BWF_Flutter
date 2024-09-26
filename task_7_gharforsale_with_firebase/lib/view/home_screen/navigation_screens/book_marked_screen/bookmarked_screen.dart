import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class BookMarkedScreen extends StatefulWidget {
  const BookMarkedScreen({super.key});

  @override
  State<BookMarkedScreen> createState() => _BookMarkedScreenState();
}

class _BookMarkedScreenState extends State<BookMarkedScreen> {
  /*
  Future<List<DocumentSnapshot>> _fetchBookmarked() async {
    List<DocumentSnapshot> homes = [];

    // Get current user ID
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception("User is not authenticated");
    }
    String userId = user.uid;

    // Get all documents in the bookmarkedCards collection for the current user
    QuerySnapshot bookmarkedCardsSnapshot = await FirebaseFirestore.instance
        .collection("bookmarkedCards")
        .doc(userId)
        .collection("homes")
        .get();

    // Check if the main collection has homes
    homes.addAll(bookmarkedCardsSnapshot.docs);

    return homes;
  }*/
  Future<DocumentSnapshot> _fetchHomeById(String id) async {
    return await FirebaseFirestore.instance.collection("homes").doc(id).get();
  }

  Future<List<DocumentSnapshot>> _fetchBookmarked() async {
    List<DocumentSnapshot> homes = [];

    // Get current user ID
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception("User is not authenticated");
    }
    String userId = user.uid;

    // Get all document IDs in the bookmarkedCards collection for the current user
    QuerySnapshot bookmarkedCardsSnapshot = await FirebaseFirestore.instance
        .collection("bookmarkedCards")
        .doc(userId)
        .collection("homes")
        .get();

    // Fetch each home document by ID
    for (var doc in bookmarkedCardsSnapshot.docs) {
      var homeDoc = await _fetchHomeById(doc.id);
      homes.add(homeDoc);
    }

    return homes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Favorite",
          style: TextStyle(
              color: Colors.black,
              fontSize: 20.sp,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
      ),
      body: FutureBuilder<List<DocumentSnapshot>>(
          future: _fetchBookmarked(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              print("Error:${snapshot.error}");
              return Center(
                child: Text("Error:${snapshot.error}"),
              );
            }
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No favorites found.'));
            }
            print("Data fetched:${snapshot.data!.length} items");

            var data = snapshot.data!;
            return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return _buildFavoritCard(context, data[index]);
                });
          }),
    );
  }

// Function to build each favorite card
  Widget _buildFavoritCard(BuildContext context, DocumentSnapshot doc) {
    var data = doc.data() as Map<String, dynamic>?;
    if (data == null) {
      return const Center(
        child: Text("No data available"),
      );
    }
    return GestureDetector(
      onTap: () {
        _showPersistentBottomSheet(context, doc);
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          elevation: 5,
          child: SizedBox(
            height: 20.h,
            width: 100.w,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                    child: Container(
                      width: 40.w,
                      height: 20.h,
                      decoration: BoxDecoration(
                        // color: Colors.pink,
                        image: DecorationImage(
                          image: NetworkImage(
                            data['image'] ?? " ",
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data['name'] ?? "No title",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.sp,
                          color: Colors.black),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on_outlined,
                          color: Color(0xff415770),
                        ),
                        Text(
                          data['type'] ?? "",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14.sp,
                            color: const Color(0xff415770),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Text(
                      "\$${data['price'] ?? ""}/month",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp,
                        color: const Color(0xff308DFF),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

// Function to show the dialog to confirm item removal

  void _showPersistentBottomSheet(BuildContext context, DocumentSnapshot doc) {
    Scaffold.of(context).showBottomSheet((BuildContext context) {
      return Container(
          height: 30.h,
          decoration: const BoxDecoration(
            // color: Colors.pink,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40.0),
                topRight: Radius.circular(40.0)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Remove from Favorites?",
                style: GoogleFonts.poppins(color: Colors.black),
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  elevation: 5,
                  child: SizedBox(
                    height: 15.h,
                    width: 100.w,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20.0)),
                            child: Container(
                              width: 40.w,
                              height: 15.h,
                              decoration: BoxDecoration(
                                // color: Colors.pink,
                                image: DecorationImage(
                                  image: NetworkImage(
                                    doc['image'] ?? " ",
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              doc['name'] ?? "No title",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.sp,
                                  color: Colors.black),
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.location_on_outlined,
                                  color: Color(0xff415770),
                                ),
                                Text(
                                  doc['type'] ?? "",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.sp,
                                    color: const Color(0xff415770),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            Text(
                              "\$${doc['price'] ?? ""}/month",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.sp,
                                color: const Color(0xff308DFF),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                      width: 1,
                      color: Color(0xff006eff),
                    )),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "Cancel",
                      style: GoogleFonts.poppins(
                        color: const Color(0xff006eff),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _removeFromFavorites(doc.id);
                      Navigator.of(context).pop();
                      setState(() {

                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff006eff),
                    ),
                    child: Text(
                      "Yes,Remove?",
                      style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 16.sp),
                    ),
                  )
                ],
              )
            ],
          ));
    });
  }

  // Function to remove item from Firestore
  void _removeFromFavorites(String homeId) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw Exception("User is not authenticated");
      }
      String userId = user.uid;

      await FirebaseFirestore.instance
          .collection('bookmarkedCards')
          .doc(userId)
          .collection('homes')
          .doc(homeId)
          .delete();

      print("Document $homeId successfully deleted from favorites.");
    } catch (e) {
      print("Error removing document from favorites: $e");
    }
  }

}
