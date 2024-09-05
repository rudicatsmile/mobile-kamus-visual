import 'package:flutter/material.dart';
import '../../screens/setting_screen.dart';
import 'profile_item.dart';

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context)=>const SettingScreen(image: 'assets/images/profil.png')));
      
            },
            child: const ProfileItem(
                text: 'Settings', imagePath: 'assets/images/tidur.png'),
          ),
          const ProfileItem(
              text: 'Your Favorite....', imagePath: 'assets/images/belajar.png'),
          const ProfileItem(text: 'Payment', imagePath: 'assets/images/bermain.png'),
          const ProfileItem(
              text: 'Tell Your Friends', imagePath: 'assets/images/makan.png'),
          const ProfileItem(
              text: 'Promotions', imagePath: 'assets/images/minum.png'),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context)=>const SettingScreen(image: 'assets/images/profil.png')));
      
            },
            child: const ProfileItem(
                text: 'Settings', imagePath: 'assets/images/tidur.png'),
          ),
          const ProfileItem(text: 'Log Out', imagePath: 'assets/images/waiting.png'),
        ],
      ),
    );
  }
}