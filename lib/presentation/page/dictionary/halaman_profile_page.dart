import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart'; // Import CachedNetworkImage

class HalamanProfilePage extends StatelessWidget {
  final String name = "Nama Pengguna";
  final String email = "Copyright@2024";
  final String imageUrl = "assets/images/profil.png";
  final String lecturer = "Dr. Sunardi, M.Pd.";
  final String developer =
      " Narti Dahliawati \n Nelvi Rosa Eliskar \n Nuning Sapta Rahayu \n Yuliadini Rahayu";
  final String partnerTeam = "Rudi Kurniawan (CV. multi Solution)";
  final String appPurpose =
      "Membantu oarang berkebutuhan khusus belajar bahasa isyarat";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("profil".tr),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // CachedNetworkImage(
              //   // imageUrl: 'assets/images/tidur.png',
              //   imageUrl: imageUrl,
              //   imageBuilder: (context, imageProvider) => CircleAvatar(
              //     radius: 50.0,
              //     backgroundImage: imageProvider,
              //   ),
              //   placeholder: (context, url) => const CircularProgressIndicator(),
              //   errorWidget: (context, url, error) => const Icon(Icons.error),
              // ),
              // Image.network(
              //   '/assets/images/camera.png',
              //   fit: BoxFit.cover,
              //   errorBuilder: (context, error, stackTrace) {
              //     return const Icon(Icons.person);
              //   },
              // ),
              // CircleAvatar(
              //   radius: 50,
              //   child: Image.asset(
              //     imageUrl,
              //     fit: BoxFit.contain,
              //     errorBuilder: (context, error, stackTrace) {
              //       return const Icon(Icons.person);
              //     },
              //   ),
              // ),
              CircleAvatar(
                backgroundImage: NetworkImage(imageUrl),
                minRadius: 50,
                maxRadius: 75,
              ),
              const SizedBox(height: 16.0),
              // Text(
              //   name,
              //   style: const TextStyle(
              //     fontSize: 24.0,
              //     fontWeight: FontWeight.bold,
              //   ),
              // ),
              const SizedBox(height: 8.0),
              Text(
                email,
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 16.0),
              _buildInfoItem("lecturer".tr, lecturer),
              _buildInfoItem("developer".tr, developer),
              _buildInfoItem("partnerTeam".tr, partnerTeam),
              // _buildInfoItem('editProfile'.tr, appPurpose),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoItem(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4.0),
          Text(
            value,
            style: const TextStyle(fontSize: 16.0),
          ),
          const Divider(), // Tambahkan pemisah antara item informasi
        ],
      ),
    );
  }
}
