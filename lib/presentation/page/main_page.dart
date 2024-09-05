import 'package:flutter/material.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:get/get.dart';
import 'dictionary/about_page.dart';
import 'dictionary/halaman_profile_page.dart';
import 'dictionary/halaman_user.dart';
import 'dictionary/landing_page.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentPage = 0;
  GlobalKey bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Visual Dictionary'),
      // ),
      body: Container(
        decoration: const BoxDecoration(color: Colors.white),
        child: Center(
          child: _getPage(currentPage),
        ),
      ),
      bottomNavigationBar: FancyBottomNavigation(
        key: bottomNavigationKey,
        tabs: [
          TabData(iconData: Icons.home, title: 'home'.tr),
          TabData(iconData: Icons.app_shortcut, title: 'dataDictionary'.tr),
          TabData(iconData: Icons.person_2_rounded, title: 'profil'.tr),
          TabData(iconData: Icons.help, title: 'help'.tr),
          // TabData(iconData: Icons.settings, title: 'Admin'),
        ],
        initialSelection: 0,
        onTabChangedListener: (position) {
          setState(() {
            currentPage = position;
          });
        },
      ),
    );
  }

  _getPage(int page) {
    switch (page) {
      case 0:
        return LandingPage();
      case 1:
        return HalamanUser();
      case 2:
        return HalamanProfilePage();
      case 3:
        return AboutPage();
      // return PesertDtks(kriteria: 'surveyor', nikSurveyor: '', kdkelurahan: '');

      default:
        return Text("errorPage".tr);
    }
  }
}
