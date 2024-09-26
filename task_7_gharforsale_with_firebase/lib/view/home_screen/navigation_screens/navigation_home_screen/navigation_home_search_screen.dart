import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:task_7_gharforsale_with_firebase/model/home.dart';

class SearchScreen extends StatefulWidget {
  final String searchText;
  final Widget searchRow;

  const SearchScreen({
    super.key,
    required this.searchText,
    required this.searchRow,
  });

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search Results"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            widget.searchRow, // Displays the search bar
            SizedBox(height: 2.h),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _searchHomes(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(child: Text('No homes found.'));
                  }

                  // Filter homes on client side based on searchText
                  final homes = snapshot.data!.docs
                      .where((doc) {
                        final data = doc.data() as Map<String, dynamic>;
                        final type = data['type'] as String? ?? '';
                        final searchLower = widget.searchText.toLowerCase();

                        // Perform case-insensitive comparison
                        return type.toLowerCase().contains(searchLower);
                      })
                      .map((doc) => Home.fromFirestore(doc))
                      .toList();

                  if (homes.isEmpty) {
                    return const Center(
                        child: Text('No homes match your search.'));
                  }

                  return GridView.builder(
                    itemCount: homes.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                      mainAxisExtent: 300, // Adjusted height
                    ),
                    itemBuilder: (context, index) {
                      final home = homes[index];
                      return Container(
                        margin: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              blurRadius: 5,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(15.0),
                              ),
                              child: SizedBox(
                                width: double.infinity,
                                height: 150, // Adjusted height
                                child: Image.network(
                                  home.image,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5.0),
                              child: Text(
                                home.name,
                                style: GoogleFonts.poppins(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5.0),
                              child: Text(
                                "\$${home.price}/month",
                                style: GoogleFonts.poppins(
                                  fontSize: 12.sp,
                                  color: const Color(0xff0066ff),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5.0),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.location_on_outlined,
                                    color: Color(0xffb3b3b3),
                                    size: 20,
                                  ),
                                  Expanded(
                                    child: Text(
                                      home.type,
                                      style: GoogleFonts.poppins(
                                        fontSize: 13.sp,
                                        color: const Color(0xffb3b3b3),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  FutureBuilder<bool>(
                                    future: isBookmarked(home.id),
                                    builder: (context, snapshot) {
                                      // Ensure that snapshot.data is not null and check for boolean
                                      final isBookmarked =
                                          snapshot.data ?? false;

                                      return IconButton(
                                        icon: Icon(
                                          isBookmarked
                                              ? Icons.bookmark
                                              : Icons.bookmark_border,
                                          color: const Color(0xff0066ff),
                                        ),
                                        onPressed: () async {
                                          if (isBookmarked) {
                                            await removeFromBookmark(home);
                                          } else {
                                            await addToBookmark(home);
                                          }

                                          setState(
                                              () {}); // Update the state to reflect changes
                                        },
                                      );
                                    },
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Stream<QuerySnapshot> _searchHomes() {
    // Fetch all documents from 'homes' collection
    return FirebaseFirestore.instance.collection('homes').snapshots();
  }

  //Get Current User's UID
  String getCurrentUserId() {
    final User? user = FirebaseAuth.instance.currentUser;
    return user?.uid ?? '';
  }

//  addToBookmark
  Future<void> addToBookmark(Home home) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final String userId = getCurrentUserId();

    if (userId.isNotEmpty) {
      await firestore
          .collection("bookmarkedCards")
          .doc(userId)
          .collection('homes')
          .doc(home.id)
          .set(home.toMap());
    }
  }

// Removing from Bookmark:
  Future<void> removeFromBookmark(Home home) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final String userId = getCurrentUserId(); // Get the current user's uid

    if (userId.isNotEmpty) {
      await firestore
          .collection('bookmarkedCards')
          .doc(userId)
          .collection('homes')
          .doc(home.id)
          .delete();
    }
  }

//Check if Home is Bookmarked:
  Future<bool> isBookmarked(String homeId) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final String userId = getCurrentUserId(); // Get the current user's uid

    if (userId.isEmpty) return false;

    final doc = await firestore
        .collection('bookmarkedCards')
        .doc(userId)
        .collection('homes')
        .doc(homeId)
        .get();

    return doc.exists;
  }
}
