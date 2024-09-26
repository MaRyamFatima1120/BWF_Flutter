import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:task_7_gharforsale_with_firebase/view/home_screen/navigation_screens/book_now_screen/book_now_screen.dart';
import '../../../../../model/home.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeDetailsScreen extends StatefulWidget {
  final Home home;

  const HomeDetailsScreen({super.key, required this.home});

  @override
  _HomeDetailsScreenState createState() => _HomeDetailsScreenState();
}

class _HomeDetailsScreenState extends State<HomeDetailsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //   appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: widget.home.id,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Image.network(
                    widget.home.image,
                    width: double.infinity,
                    height: 40.h,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                      bottom: 28.h,
                      left: 10.w,
                      child: CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.white,
                          child: Center(
                              child: IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: const Icon(
                                    Icons.arrow_back,
                                    size: 20,
                                  ))))),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 5.w, top: 4.h),
                  child: Text(
                    widget.home.name.isNotEmpty ? widget.home.name : "No Name",
                    style: GoogleFonts.poppins(
                        fontSize: 24.sp, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 5.w,
                  ),
                  child: Text(
                    widget.home.type,
                    style: GoogleFonts.poppins(
                        color: const Color(0xff415770),
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(height: 5.h),
                TabBar(
                  controller: _tabController,
                  labelColor: Colors.blue,
                  unselectedLabelColor: Colors.black,
                  indicatorColor: Colors.blue,
                  indicatorSize: TabBarIndicatorSize.tab,
                  labelStyle: GoogleFonts.poppins(
                      fontSize: 18.sp, fontWeight: FontWeight.w500),
                  tabs: const [
                    Tab(
                      text: 'Description',
                    ),
                    Tab(text: 'Gallery'),
                  ],
                ),
                SizedBox(
                  height: 50.h, // Adjust the height of TabBarView
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      //Description
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 3.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Card(
                                elevation: 5.0,
                                child: SizedBox(
                                  width: 20.w,
                                  height: 10.h,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                          width: 10.w,
                                          height: 2.h,
                                          decoration: const BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    "assets/images/home_screen_details/sqft.png")),
                                          )),
                                      Text(
                                        widget.home.sqft.toStringAsFixed(1),
                                        style: GoogleFonts.poppins(
                                            color: const Color(0xff006eff),
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        "sqft",
                                        style: GoogleFonts.poppins(
                                            color: Colors.grey,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Card(
                                elevation: 5.0,
                                child: SizedBox(
                                  width: 20.w,
                                  height: 10.h,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                          width: 10.w,
                                          height: 2.h,
                                          decoration: const BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage(
                                              "assets/images/home_screen_details/bedrooms.png",
                                            )),
                                          )),
                                      Text(
                                        widget.home.bedrooms.toStringAsFixed(1),
                                        style: GoogleFonts.poppins(
                                            color: const Color(0xff006eff),
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        "Bedrooms",
                                        style: GoogleFonts.poppins(
                                            color: Colors.grey,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Card(
                                elevation: 5.0,
                                child: SizedBox(
                                  width: 20.w,
                                  height: 10.h,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                          width: 10.w,
                                          height: 2.h,
                                          decoration: const BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  "assets/images/home_screen_details/bathroom.png"),
                                            ),
                                          )),
                                      Text(
                                        widget.home.bathrooms
                                            .toStringAsFixed(1),
                                        style: GoogleFonts.poppins(
                                            color: const Color(0xff006eff),
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        "Bathrooms",
                                        style: GoogleFonts.poppins(
                                            color: Colors.grey,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Card(
                                elevation: 5.0,
                                child: SizedBox(
                                  width: 20.w,
                                  height: 10.h,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                          width: 10.w,
                                          height: 2.h,
                                          decoration: const BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    "assets/images/home_screen_details/safety.png")),
                                          )),
                                      Text(
                                        widget.home.safetyRank,
                                        style: GoogleFonts.poppins(
                                            color: const Color(0xff006eff),
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        "Safety Rank",
                                        style: GoogleFonts.poppins(
                                            color: Colors.grey,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 3.h,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 5.w,
                            ),
                            child: Text(
                              "Listing Agent",
                              style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w800),
                            ),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ClipOval(
                                child: CircleAvatar(
                                    radius: 35,
                                    //backgroundColor: Colors.orange,
                                    child: Image.network(
                                      widget.home.agentImage,
                                      fit: BoxFit.cover,
                                      width: 100,
                                      height: 100,
                                    )),
                              ),
                              SizedBox(width: 5.w),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.home.agentName,
                                    style: GoogleFonts.poppins(
                                        color: Colors.black,
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    widget.home.agentRole,
                                    style: GoogleFonts.poppins(
                                        color: Colors.black,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                              SizedBox(width: 20.w),
                              IconButton(
                                onPressed: () {
                                  _launchEmail(widget.home.email);
                                },
                                icon: const Icon(
                                  Icons.email,
                                  color: Color(0xff006eff),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  _launchPhone(widget.home.phone);
                                },
                                icon: const Icon(Icons.call,
                                    color: Color(0xff006eff)),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          SizedBox(
                            height: 10.h,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal, // Horizontal scrolling
                              itemCount: widget.home.amenities.length,
                              itemBuilder: (context, index) {
                                final amenity = widget.home.amenities[index];
                                return Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20.0), // Spacing between cards
                                  child: Center(
                                    child: Card(

                                      elevation: 3.0,

                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                            child: Image.asset(amenity.image,fit: BoxFit.cover,),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                            child: Text(
                                              amenity.name,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 16.sp, // Font size of the text
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),

                                      ],)

                                    ),
                                  ),
                                );
                              },
                            ),
                          )

                        ],
                      ),

                      //Gallery
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 3.h,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Text(
                              "Gallery",
                              style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w800),
                            ),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: GridView.builder(
                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                    crossAxisSpacing: 8.0,
                                    mainAxisSpacing: 8.0,
                                    childAspectRatio: 1.0,
                                  ),
                                  itemCount: widget.home.galleryImages.length,
                                  itemBuilder: (context,index){
                                    return ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Image.network(
                                        widget.home.galleryImages[index],
                                        fit: BoxFit.cover,
                                      ),
                                    );
                                  }),
                            ),
                          )

                        ],
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      //mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 5.w,
                          ),
                          child: Text(
                            "Total Price",
                            style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w800),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 5.w,
                          ),
                          child: Text(
                            "\$${widget.home.price.toStringAsFixed(1)}",
                            style: GoogleFonts.poppins(
                                color: const Color(0xff006eff),
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>BookNowScreen()));
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff006eff),
                            foregroundColor: Colors.white),
                        child: Text(
                          "Book Now",
                          style: GoogleFonts.poppins(
                              fontSize: 16.sp, fontWeight: FontWeight.w600),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 1.h),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _launchEmail(String email) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: email,
    );

    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri, mode: LaunchMode.externalApplication);
    } else {
      print('Could not launch $emailUri');
    }
  }

  //call
  void _launchPhone(String phone) async {
    final Uri phoneUri = Uri(
      scheme: 'tel',
      path: phone,
    );
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {
      print('Could not launch $phoneUri');
    }
  }
}

/*
*
          Text(
            "\$${widget.home.price.toStringAsFixed(2)}/month",
            style: const TextStyle(fontSize: 20, color: Colors.blue),
          ),
          const SizedBox(height: 10),
          Text(
            "Location: ${widget.home.type}",
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 10),
          Text(
            "Category: ${widget.home.category}",
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 10),
          //
          //
* */
