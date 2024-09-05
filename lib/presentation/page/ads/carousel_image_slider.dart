import 'dart:convert';
import 'package:d_method/d_method.dart';
import 'package:flutter/material.dart';
import 'package:fan_carousel_image_slider/fan_carousel_image_slider.dart';
import 'package:http/http.dart' as http;
import '../../../config/api.dart';

class CarouselImageSLider extends StatefulWidget {
  const CarouselImageSLider({super.key});

  @override
  State<CarouselImageSLider> createState() => _CarouselImageSLiderState();
}

class _CarouselImageSLiderState extends State<CarouselImageSLider> {

  // List<ImageModel> sampleImages = [];
  List<String> imagesString = [];

  Future<void> fetchImagesTop() async {
    String url = '${Api.imageAds}/getImageAds.php';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {    
      final List<dynamic> data = jsonDecode(response.body);
      setState(() {
        //sampleImages = data.map((item) => ImageModel.fromJson(item)).toList();
        imagesString = data.map((item) => item['imageUrl'] as String).toList();
        DMethod.printTitle('CEK URL1:  ', data.toString());
      });
    } else {
      // Tangani error jika ada
    }
  }
  

  @override
  void initState() {
    super.initState();
    fetchImagesTop();
  }
  
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: 
          imagesString.isEmpty ? const SizedBox() :
          Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [            
            FanCarouselImageSlider.sliderType1(
              imagesLink: imagesString,
              isAssets: false,
              autoPlay: true,
              sliderHeight: 200,
              showIndicator: true,
            ),
            // const SizedBox(
            //   height: 30,
            // ),
            // const Text(
            //   'FanCarouselImageSlider Type2:',
            //   style: TextStyle(fontSize: 20),
            // ),
            // FanCarouselImageSlider.sliderType2(
            //   imagesLink: sampleImages,
            //   isAssets: false,
            //   autoPlay: true,
            //   sliderHeight: 300,
            //   currentItemShadow: const [],
            //   sliderDuration: const Duration(milliseconds: 200),
            //   imageRadius: 0,
            //   slideViewportFraction: 1.2,
            // ),
            // const SizedBox(
            //   height: 50,
            // ),
          ],
        ),
      );
  }
}