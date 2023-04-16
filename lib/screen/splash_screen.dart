import 'dart:async';

import 'package:chat_pot/screen/home_screen.dart';
import 'package:chat_pot/utils/user_pref.dart';
import 'package:flutter/material.dart';

import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(
      const Duration(seconds: 3),
      () => UserPreferences.getToken() == null
          ? Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (builder) => const LoginScreen()),
              (route) => false)
          : Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (builder) => const HomeScreen()),
              (route) => false),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              "assets/icons/logo.png",
              height: 250,
            ),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
