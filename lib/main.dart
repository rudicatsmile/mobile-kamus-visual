import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'consts/language.dart';
import 'presentation/page/dictionary/flashscreen_page.dart';
import 'presentation/page/dictionary/halaman_user.dart';
import 'presentation/page/dictionary/m_crud_kamus.dart';
import 'presentation/page/dictionary/word_mapping_page.dart';
import 'presentation/page/main_page.dart';
import 'presentation/page/peserta_dtks/peserta_dtks_page.dart';
import 'screens/profile_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(

      //# LAN
      // locale:const Locale('en','US'),
      // fallbackLocale:const Locale('en','US') ,
      locale:const Locale('id','ID'),
      fallbackLocale:const Locale('id','ID') ,
      translations:Languages() ,
      //theme
      // theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      //# END LAN


      debugShowCheckedModeBanner: false,
      title: 'Visual Dictionary',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //home: HalamanUser(), // Tampilkan HalamanUser sebagai halaman awal
      //home : MainPage(),
      home:SplashScreen(),
      // home :  const PesertDtks(kriteria: 'surveyor', nikSurveyor: '', kdkelurahan: ''),
      //home: ProfileScreen(),
    );
  }
}
