import 'package:flutter/material.dart';
import '../components/profile_screen/profile_header.dart';
import '../components/profile_screen/profile_menu.dart';
import '../components/profile_screen/profile_statistics.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 58),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProfileHeader(),
            SizedBox(height: 40),
            ProfileStatistics(),
            SizedBox(height: 70),
            ProfileMenu(),
          ],
        ),
      ),
    );
  }
}