import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'config/app_color.dart';
import 'presentation/controller/c_user.dart';
import 'presentation/controller/notification_controller.dart';
import 'presentation/page/example/notification_firebase.dart';
import 'presentation/page/login_page.dart';
import 'presentation/page/sign_in.dart';
import 'presentation/profile_page.dart';

import 'config/session.dart';

// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   Session.getUser();
//   runApp(const MyApp());
// }

//F1
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationController.initializeLocalNotifications();
  await NotificationController.initializeIsolateReceivePort();
  Session.getUser();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  //F1
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  

  @override
  Widget build(BuildContext context) {
    final cUser = Get.put(CUser());
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
          primaryColor: AppColor.primary,
          scaffoldBackgroundColor: Colors.black,
          appBarTheme: const AppBarTheme(backgroundColor: AppColor.primary),
          colorScheme: const ColorScheme.dark().copyWith(primary: AppColor.primary)),
      home: 
      //const FindDtksPage(),
      //ProfilePage(),
      // Obx(() {
      //   // if (cUser.data.idUser == null) return const LoginPage();
      //   if (cUser.data.idUser == null) return const SignInLogin();
      //   return  ProfilePage();
      // }),
      //DashboardPage();
      //MyDropdownSearch()
      NotificatinFirebase()
    );
  }
}
