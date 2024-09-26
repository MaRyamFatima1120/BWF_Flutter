import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:sizer/sizer.dart';
import 'package:task_7_gharforsale_with_firebase/view/home_screen/home_screen.dart';

class SwipeScreen extends StatefulWidget {
  const SwipeScreen({super.key});

  @override
  State<SwipeScreen> createState() => _SwipeScreenState();
}

class _SwipeScreenState extends State<SwipeScreen> {
  List<String> images = [
    "https://www.granddesignsmagazine.com/wp-content/uploads/2022/06/Header-700x356.jpg",
    "https://images.surferseo.art/fdb08e2e-5d39-402c-ad0c-8a3293301d9e.png",
    "https://archivaldesigns.com/cdn/shop/products/Peach-Tree-Front_1200x.jpg?v=1725885090",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT-lJMYlac3gGpaKhFzk2yNn4Qk1PFWGca6fg&s",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR2qFGUkO65ahGQ7KyOczQ-oemJJdJPcmqZ4UmCZGbZImMk-x12wr3TQ67dVSbdetzadO0&usqp=CAU",

  ];

  List<int> prices = [
    8500,
    9000,
    7800,
    9500,
    8200,
    8700,
    8300,
  ];

  List<String> type = [
    "10BHK Apartment",
    " 8BHK Apartment",
    " 7BHK Apartment",
    "2BHK Apartment",
    " 9BHK Apartment",
    "11BHK Apartment",
    "10BHK Apartment"
  ];

  List<String> desc = [
    "Lorem Ipsum",
    "Lorem Ipsum",
    "Lorem Ipsum",
    "Lorem Ipsum",
    "Lorem Ipsum",
    "Lorem Ipsum",
    "Lorem Ipsum"
  ];

  List<double> rating = [4.9, 4.5, 5, 4.3, 4.8, 3.9, 4.0];

  //Close Handel
  bool  _showMessage = false;

  void _handleClose(){
    setState(() {
      _showMessage = true;
    });

    Future.delayed(const Duration(seconds: 1),(){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const HomeScreen()));
    });

  }

  // Bookmarked status
  List<bool> isBookmarked = List.generate(7, (_) => false);

  // Toggle bookmark status
  void _toggleBookmark(int index) {
    setState(() {
      isBookmarked[index] = !isBookmarked[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(child: Image.asset("assets/images/logo1.png")),
            SizedBox(
              height: 2.h,
            ),
            if(_showMessage)
              SizedBox(
                height: 70.h,
                width: 100.w,
                child:  Center(child: Text("Data has been Cleared.",style: Theme.of(context).textTheme.titleSmall,)),
              ),

            if(!_showMessage)
              SizedBox(
                height: 70.h,
                width: 100.w,
                child: CardSwiper(
                  allowedSwipeDirection: const AllowedSwipeDirection.only(
                    up: true,),
                  cardsCount: images.length,

                  cardBuilder:
                      (context, index, percentThresholdX, percentThresholdY) =>
                      buildCard(index),
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FloatingActionButton(
                    heroTag: "fab1",
                    onPressed:_handleClose,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child:const Icon(Icons.close,color:Colors.red,size: 30,),
                  ),
                  SizedBox(width: 10.w,),

                  FloatingActionButton(
                    heroTag: "fab2",
                    onPressed: () {
                      _toggleBookmark(0); // Change index dynamically as needed
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: Icon(
                      isBookmarked[0]
                          ? Icons.bookmark
                          : Icons.bookmark_border, // Update icon based on status
                      color: const Color(0xff0066ff),
                      size: 40,
                    ),
                  ),
                ],
              ),)

          ],
        ));
  }

  Widget buildCard(int index) {
    return Container(
      margin: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        image: DecorationImage(
          image: NetworkImage(images[index]),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.8), BlendMode.softLight),
        ),
      ),
      child: Stack(
        children: [
          // Gradient Overlay
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 3),
                borderRadius: BorderRadius.circular(20.0),
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    const Color(0xff054bda),
                    Colors.white.withOpacity(0.2), // Dark color at the bottom
                    Colors.transparent, // Transparent at the top
                  ],
                ),
              ),
            ),
          ),
          // Text on top of the gradient
          Positioned(
            bottom: 20,
            left: 20,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("\$${prices[index]}",
                        style: Theme
                            .of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(color: Colors.white, fontSize: 20.sp)),
                    SizedBox(
                      width: 6.w,
                    ),
                    Text(type[index],
                        style: Theme
                            .of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(color: Colors.white, fontSize: 16.sp)),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(desc[index],
                        style: Theme
                            .of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(color: Colors.white, fontSize: 16.sp)),
                    SizedBox(
                      width: 20.w,
                    ),
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.star,
                              color: Color(0xffeea651),
                            )),
                        Text(rating[index].toString(),
                            style: Theme
                                .of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                color: Colors.white, fontSize: 16.sp)),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
