
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../config/api.dart';
import '../../data/model/image_model.dart';


// ... (model ImageModel)

class SampleImagesFromApi extends StatefulWidget {
  @override
  _SampleImagesFromApiState createState() => _SampleImagesFromApiState();
}

class _SampleImagesFromApiState extends State<SampleImagesFromApi> {
  List<ImageModel> sampleImages = [];

  @override
  void initState() {
    super.initState();
    fetchImages();
  }

  Future<void> fetchImages() async {
     String url = '${Api.imageAds}/getImageAds.php';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      setState(() {
        sampleImages = data.map((item) => ImageModel.fromJson(item)).toList();
      });
    } else {
      // Tangani error jika ada
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gambar dari API')),
      body: ListView.builder(
        itemCount: sampleImages.length,
        itemBuilder: (context, index) {
          return Image.network(sampleImages[index].imageUrl);
        },
      ),
    );
  }
}