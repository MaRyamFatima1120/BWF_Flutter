import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:task_7_gharforsale_with_firebase/model/home.dart';
import 'package:task_7_gharforsale_with_firebase/view/home_screen/navigation_screens/navigation_home_screen/home_Details_screen/home_details_screen.dart';
import 'package:task_7_gharforsale_with_firebase/view/home_screen/navigation_screens/navigation_home_screen/navigation_home_search_screen.dart';

class NavigationHomeScreen extends StatefulWidget {
  const NavigationHomeScreen({super.key});

  @override
  State<NavigationHomeScreen> createState() => _NavigationHomeScreenState();
}

class _NavigationHomeScreenState extends State<NavigationHomeScreen>
    with SingleTickerProviderStateMixin {
  String _selectedFilter = ''; // Default filter
  List<Home> _homes = []; // List to store fetched homes
  String? imageUrl;
  User? currentUser; // To store the current user

  //TextEditingController

  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCurrentUser();
    _fetchHomes(); // Fetch homes when the screen initializes
  }

  void _getCurrentUser() {
    currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      _getImageFromFirebase(currentUser!.uid);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 5.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Let’s Find your",
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                fontSize: 18.sp,
                                color: const Color(0xff747474),
                                fontWeight: FontWeight.normal,
                              ))),
                      Text("Favorite Home",
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                fontSize: 20.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                              ))),
                    ],
                  ),
                  CircleAvatar(
                    radius: 30,
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

                ],
              ),
              SizedBox(height: 1.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 5.0, vertical: 5.0),
                    width: 65.w,
                    height: 7.h,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.0),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            spreadRadius: 1.0,
                            blurRadius: 4.0,
                          )
                        ]),
                    child: TextFormField(
                      controller: _searchController,
                      decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.search,
                            size: 30,
                            color: Color(0xff717171),
                          ),
                          hintText: "Search by Address, City, or ZIP",
                          hintStyle: TextStyle(
                              color: const Color(0xff717171),
                              fontSize: 16.sp,
                              fontWeight: FontWeight.normal),
                          border: InputBorder.none),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  SearchScreen(
                                    searchText: _searchController.text,
                                    searchRow: buildSearchRow(),
                                  )));
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 10.0),
                      width: 18.w,
                      height: 8.h,
                      decoration: BoxDecoration(
                          color: const Color(0xff308dff),
                          borderRadius: BorderRadius.circular(20.0),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.grey,
                              spreadRadius: 1.0,
                              blurRadius: 4.0,
                            )
                          ]),
                      child: const Icon(
                        Icons.tune,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 1.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildFilterChip('Recommended'),
                  _buildFilterChip('Top Rated'),
                  _buildFilterChip('Best Offer'),
                ],
              ),
              SizedBox(
                height: 2.h,
              ),
              _buildHomesList()
            ],
          ),
        ),
      ),
    );
  }

  // Reusable method to build the search row (so it can be used in both screens)
  Widget buildSearchRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
              horizontal: 5.0, vertical: 5.0),
          width: 65.w,
          height: 7.h,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: const [
                BoxShadow(
                  color: Colors.grey,
                  spreadRadius: 1.0,
                  blurRadius: 4.0,
                )
              ]),
          child: TextFormField(
            controller: _searchController,
            decoration: InputDecoration(
                prefixIcon: const Icon(
                  Icons.search,
                  size: 30,
                  color: Color(0xff717171),
                ),
                hintText: "Search by Address, City, or ZIP",
                hintStyle: TextStyle(
                    color: const Color(0xff717171),
                    fontSize: 16.sp,
                    fontWeight: FontWeight.normal),
                border: InputBorder.none),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        SearchScreen(
                          searchText: _searchController.text,
                          searchRow: buildSearchRow(),
                        )));
          },
          child: Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 10.0, vertical: 10.0),
            width: 18.w,
            height: 8.h,
            decoration: BoxDecoration(
                color: const Color(0xff308dff),
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    spreadRadius: 1.0,
                    blurRadius: 4.0,
                  )
                ]),
            child: const Icon(
              Icons.tune,
              size: 40,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  // Method to build a FilterChip widget
  Widget _buildFilterChip(String filter) {
    return FilterChip(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40.0),
        side: const BorderSide(color: Colors.transparent),
      ),
      selectedColor: const Color(0xffe5f1ff),
      backgroundColor: const Color(0xfff1f2f4),
      selected: _selectedFilter == filter,
      showCheckmark: false,
      label: Text(
        filter,
        style: TextStyle(
          color: _selectedFilter == filter
              ? const Color(0xff308dff)
              : Colors.black, // Change text color when selected
        ),
      ),
      onSelected: (bool selected) {
        setState(() {
          _selectedFilter = selected ? filter : '';
        });
        _fetchHomes();
      },
    );
  }

  // Method to fetch homes from Firebase Firestore
  Future<void> _fetchHomes() async {
    if (_selectedFilter.isEmpty) {
      // Optionally handle the case where no filter is selected
      setState(() {
        _homes = []; // Clear the homes list or handle as needed
      });
      return;
    }
    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('homes')
        .where('category', isEqualTo: _selectedFilter)
        .get();

    setState(() {
      _homes = snapshot.docs.map((doc) => Home.fromFirestore(doc)).toList();
    });
  }

  // Method to build the list of fetched homes
  Widget _buildHomesList() {
    /* if (_selectedFilter.isEmpty) {
      return Center(child: Text('Select a filter to see homes.'));
    }*/
    if (_homes.isEmpty) {
      return const Center(
          child: Text('No homes available for the selected filter.'));
    }

    return SizedBox(
      height: 100.h, // Set an explicit height
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: _homes.length,
        itemBuilder: (context, index) {
          final home = _homes[index];
          return InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeDetailsScreen(home: home,)));
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical:10.0),
              width: 70.w,
              height: 35.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
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
                  Hero(
                    tag: home.id,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(10.0),
                        bottom: Radius.circular(10.0),
                      ),
                      child: SizedBox(
                        width: double.infinity,
                        height: 20.h,
                        child: Image.network(
                          home.image,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      home.name,
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      "\$${home.price}/month",
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          color: Color(0xff0066ff),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.location_on_outlined,
                          color: Color(0xffb3b3b3),
                        ),
                        SizedBox(
                          width: 2.w,
                        ),
                        Text(home.type,
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                  fontSize: 13.sp,
                                  color: const Color(0xffb3b3b3),
                                  fontWeight: FontWeight.w500,
                                ))),
                        const Spacer(),
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
            ),
          );
        },
      ),
    );
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


