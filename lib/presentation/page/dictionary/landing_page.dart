import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../screens/setting_screen.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text('home'.tr),
        actions: [
            IconButton(
                onPressed: () {
                      Get.to(() => const SettingScreen(image: 'assets/images/profil.png'))?.then((value) {
                          if (value ?? false) {                    
                           
                          }
                        });
                     
                },
                icon: const Icon(Icons.settings)),
          ]

      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.blue[400]!, Colors.blue[800]!],
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'assets/images/icon.png',
                  width: 200,
                  height: 200,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Visual Dictionary',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                 Text(
                  'welcomeToApp'.tr,
                  style:  const TextStyle(
                    fontSize: 18,
                    color: Colors.white70,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                _buildFeatureCard(Icons.image, 'interactiveImage'.tr, 'findSymbolImage'.tr),
                _buildFeatureCard(Icons.videocam, 'simbolVideo'.tr, 'learnSignsInteractiveVideos'.tr),
                _buildFeatureCard(Icons.favorite, 'saveFavoriteKey'.tr, 'saveFavoriteValue'.tr),
                SizedBox(height: 40),
                // ElevatedButton(
                //   onPressed: () {
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(builder: (context) => HalamanUser()),
                //     );
                //   },
                //   style: ElevatedButton.styleFrom(
                //     backgroundColor: Colors.white,
                //     padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                //     textStyle: TextStyle(fontSize: 18),
                //   ),
                //   child: Text('Mulai Belajar', style: TextStyle(color: Colors.blue[800])),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureCard(IconData icon, String title, String description) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Icon(icon, size: 50, color: Colors.blue[800]),
            SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(
              description,
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
