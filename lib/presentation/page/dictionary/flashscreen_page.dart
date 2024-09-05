import 'dart:async';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
import 'onboard_page.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController);
    _animationController.forward();

    Timer(const Duration(seconds: 5), () {
      // Durasi splash screen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => OnBoardingPage()),
      );
    });

    // Animasi Status Bar
    FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    _animationController.addListener(() {
      FlutterStatusbarcolor.setStatusBarColor(
          Colors.blue.withOpacity(_animation.value));
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Warna latar belakang splash screen
      body: Center(
        child: FadeTransition(
          // Animasi fade in logo
          opacity: _animation,
          child: Image.asset(
            'assets/images/icon.png', // Ganti dengan logo aplikasi Anda
            width: 200,
            height: 200,
          ),
        ),
      ),
    );
  }
}
