import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:d_info/d_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../config/api.dart';
import '../config/session.dart';
import 'controller/c_user.dart';
import 'page/ads/carousel_image_slider.dart';
import 'page/profile/discover_list_item_widget.dart';
import 'page/profile/featured_article_banner_widget.dart';
import 'page/sign_in.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  void confirmExit(BuildContext context, String dTitle, String dMessage) {
    Widget cancelButton = ElevatedButton(
      child: const Text("Batal"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    Widget continueButton = ElevatedButton(
      child: const Text("OK"),
      onPressed: () async {
        exit(0);
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(dTitle),
      content: Text(dMessage),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void confirmLogout(BuildContext context, String dTitle, String dMessage) {
    Widget cancelButton = ElevatedButton(
      child: const Text("Batal"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    Widget continueButton = ElevatedButton(
      child: const Text("OK"),
      onPressed: () {
        deleteStringBookingViewToSF();
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) {
        //     return const FormLogin();
        //   }),
        // );
        //exit(0);
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(dTitle),
      content: Text(dMessage),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  deleteStringBookingViewToSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("isLogin", "");
  }

  logout() async {
    bool? yes = await DInfo.dialogConfirmation(
      context,
      'Logout',
      'You sure to logout?',
    );
    //DMethod.printTitle('cedk', yes.toString());

    if (yes == true) {
      Session.clearUser();
      // print('logout deh');
      // Get.off(() => const LoginPage());
      Get.off(() => const SignInLogin());
    }
  }

  exitApp() async {
    bool? yes = await DInfo.dialogConfirmation(
      context,
      'Exit',
      'You sure to exit?',
    );
    //DMethod.printTitle('cedk', yes.toString());

    if (yes == true) {
      Session.clearUser();
      // print('exit deh');
      exit(0);
    }
  }

  List<String> imagesString2 = [];

  Future<void> fetchImages() async {
    String url = '${Api.imageAds}/getImageAds.php';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      setState(() {
        imagesString2 = data.map((item) => item['imageUrl'] as String).toList();
      });
    } else {
      // Tangani error jika ada
    }
  }

  @override
  void initState() {
    super.initState();
    fetchImages();
  }

  @override
  Widget build(BuildContext context) {
    final cUser = Get.put(CUser());
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          title: const Text('Pusat pencarian '),
          actions: [
            IconButton(
                onPressed: () {
                  logout();
                },
                icon:const Icon(Icons.logout_sharp)),
          ]
          ),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            children: [
              // CardProfileInformationWidget(),
              const CarouselImageSLider(),
              const SizedBox(
                height: 10,
              ),

              Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: FeaturedArticleBannerWidget()),

              //Iklan Internal
              Container(
                  margin: const EdgeInsets.only(left: 20),
                  child: infoHorizontal()),
            ],
          ),
        )));
  }

  Widget infoHorizontal() {
    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // const TitleAndSubtitle(
        //   title: "Daerah  ",
        //   subTitle: "Sebaran Data",
        // ),
        const SizedBox(
          height: 10,
        ),
        Container(
          height: 210,
          child: ListView.builder(
            itemCount: imagesString2.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return DiscoverListItemWidget(index);
            },
          ),

          // ListView.builder(
          //  itemCount: 5,
          //  scrollDirection: Axis.horizontal,
          //  itemBuilder: (BuildContext context, int index) {
          //   return ListTile(
          //       leading: const Icon(Icons.list),
          //       trailing: const Text(
          //         "GFG",
          //         style: TextStyle(color: Colors.green, fontSize: 15),
          //       ),
          //       title: Text("List item $index"));
          // }),
        ),
      ],
    ));
  }
}
