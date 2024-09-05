import 'package:awesome_notifications_fcm/awesome_notifications_fcm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'config/app_color.dart';
import 'presentation/controller/c_user.dart';
import 'presentation/controller/notification_controller.dart';
import 'presentation/page/example/notification_firebase.dart';
import 'presentation/page/apotek/search_suggestion.dart';
import 'presentation/page/example/ui_example.dart';
import 'presentation/page/register_page.dart';

import 'config/session.dart';
import 'presentation/page/sign_in.dart';
import 'presentation/profile_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Session.getUser();
  runApp(const MyApp());
}

//F1
// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await NotificationController.initializeLocalNotifications();
//   await NotificationController.initializeIsolateReceivePort();

//   //Remote notification Awsemome_notitication_fcm
//   await NotificationController.initializeRemoteNotifications(debug: true);
//   await NotificationController.getInitialNotificationAction();
//   Session.getUser();
//   runApp(const MyApp());
// }

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  //F1
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //F1
  // @override
  // void initState() {
  //   //NotificationController.startListeningNotificationEvents();
  //   //Remote notification Awsemome_notitication_fcm
  //   //NotificationController.requestFirebaseToken();
  //   //AwesomeNotificationsFcm().subscribeToTopic("rudikurniawan");
  //   super.initState();
  // }
  @override
  Widget build(BuildContext context) {
    final cUser = Get.put(CUser());
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
          primaryColor: AppColor.primary,
          scaffoldBackgroundColor: Colors.black,
          appBarTheme: const AppBarTheme(backgroundColor: AppColor.primary),
          colorScheme:
              const ColorScheme.dark().copyWith(primary: AppColor.primary)
          ),

      home: 
      Obx(() {
        // if (cUser.data.idUser == null) return const LoginPage();    //old
        if (cUser.data.idt == null) return const SignInLogin();
        return ProfilePage();
      }),

      //home: SampleImagesFromApi()

      //const FindDtksPage(),
      // ProfilePage(),
      //DashboardPage();
      //RegisterPage(),
      //RegisterScreen(),
      //NotificatinFirebase()
      //SearchSuggestionScreen(),
      //OrderScreen(),
    );
  }
}
