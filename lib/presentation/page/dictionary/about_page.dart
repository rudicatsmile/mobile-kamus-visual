import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text('aboutApp'.tr),
      ),
      body:  SingleChildScrollView( // Agar bisa scroll jika konten panjang
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Visual Dictionary',
              style: TextStyle(
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10.0),
            Text(
              'purposeOfUsingApp'.tr,
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5.0),
            Text(
              'purposeOfUsingApp2'.tr,
              style: TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 20.0),
            Text(
              'toWhomApplication'.tr,
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5.0),
            Text(
              'purposeOfUsingApp3'.tr,
              style: const TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 20.0),
            Text('Terima Kasih',style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold,),
            ),
            SizedBox(height: 5.0),
            Text(
              'Terima kasih kepada semua pihak yang telah membantu dalam pengembangan aplikasi ini, termasuk:\n- Komunitas berkebutuhan khusus yang telah memberikan masukan dan saran.\n- Para ahli bahasa isyarat yang telah membantu dalam penyusunan kamus.\n- Tim pengembang yang telah bekerja keras untuk mewujudkan aplikasi ini.',
              style: TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}
