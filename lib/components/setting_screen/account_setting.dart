import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../consts/text_style.dart';
import '../../presentation/page/dictionary/halaman_profile_page.dart';

class AccountSetting extends StatelessWidget {


  const AccountSetting({super.key,});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Image.asset(
              'assets/images/profil.png',
              height: 30,
            ),
            const SizedBox(
              width: 12,
            ),
            Text(
                'account'.tr,
                style: settingType
            )
          ],
        ),
        const SizedBox(
          height: 15,
        ),

        GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context)=> HalamanProfilePage()));
      
            },
            child: 
              // const ProfileItem(text: 'Settings', imagePath: 'assets/images/tidur.png'),
              Text('editProfile'.tr, style: settingText),
          ),
       
        
        const SizedBox(
          height: 15,
        ),
        Text(
            'changePassword'.tr,
            style: settingText
        ),
        const SizedBox(
          height: 15,
        ),
        Text(
            'privacy'.tr,
            style: settingText
        ),
        const SizedBox(
          height: 10,
        ),
        const Divider(),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}

