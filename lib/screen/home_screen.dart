import 'package:chat_pot/constant/app_color.dart';
import 'package:chat_pot/screen/pages/bnb_page/home_page.dart';
import 'package:chat_pot/screen/pages/bnb_page/post_page.dart';
import 'package:chat_pot/screen/pages/bnb_page/profile_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final _pages = <Widget>[
    const HomePage(),
    const CreatePost(),
    const ProfilePage()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.creamColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: const Text(
          "ARTHUB",
          style: TextStyle(color: Colors.black),
        ),
        leading: Image.asset("assets/icons/logo.png"),
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: SalomonBottomBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: [
            SalomonBottomBarItem(
                icon: const Icon(CupertinoIcons.home),
                title: const Text("Home")),
            SalomonBottomBarItem(
                icon: const Icon(CupertinoIcons.add),
                title: const Text("Add Post")),
            SalomonBottomBarItem(
                icon: const Icon(CupertinoIcons.person),
                title: const Text("Profile"))
          ]),
    );
  }
}
