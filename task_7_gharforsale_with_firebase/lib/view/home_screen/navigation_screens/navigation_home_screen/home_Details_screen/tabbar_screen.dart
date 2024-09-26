import 'package:flutter/material.dart';

class HomeTabScreen extends StatefulWidget {
  const HomeTabScreen({super.key});

  @override
  State<HomeTabScreen> createState() => _HomeTabScreenState();
}

class _HomeTabScreenState extends State<HomeTabScreen>
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
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Column(children: [
      TabBar(tabs: [
        Tab(
          text: "Description",
        ),
        Tab(text: "Gallery")
      ]),
      TabBarView(
        children: [
          Center(
            child: Text("Home Screen"),
          ),
          TabBarView(children: [
            Center(
              child: Text("Profile Screen"),
            ),
          ])
        ],
      ),
    ]));
  }
}
