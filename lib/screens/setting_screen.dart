import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../components/setting_screen/account_setting.dart';
import '../components/setting_screen/notification_setting.dart';
import '../components/setting_screen/other_setting.dart';
import '../consts/text_style.dart';

class SettingScreen extends StatefulWidget {
  final String image;
  const SettingScreen({super.key, required this.image});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:  Text('setting'.tr),),
      body: Padding(
        padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
        child: 
        SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundImage: AssetImage(widget.image),
              ),
              const SizedBox(
                height: 25,
              ),
              Text('setting'.tr, style: setting),
              const SizedBox(
                height: 10,
              ),
              // const Divider(),
              // const AccountSetting(),
              const NotificationSetting(),
              const Divider(),
              const OtherSetting(),
              const Divider(),
            ],
          ),
        ),
      ),
    );
  }
}