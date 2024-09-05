import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';
import '../main_page.dart';

class OnBoardingPage extends StatefulWidget {
  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    // Navigator.of(context).push(
    //   MaterialPageRoute(builder: (_) => MainPage()),
    // );
    Get.off(MainPage());
  }

  Widget _buildImage(String assetName, [double width = 350]) {
    return Padding(
      padding: const EdgeInsets.all(29.0),
      child: Image.asset(
        'assets/images/$assetName',
        width: width,
        fit: BoxFit.contain,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);

    const pageDecoration = PageDecoration(
        titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
        bodyTextStyle: bodyStyle,
        bodyPadding: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 16.0),
        pageColor: Colors.white,
        imagePadding: EdgeInsets.zero,
        contentMargin: EdgeInsets.fromLTRB(16.0, 42.0, 16.0, 16.0));

    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: Colors.white,
      pages: [
        PageViewModel(
          title: "onBoardTitle1".tr,
          body: "onBoardBody1".tr,
          image:
              _buildImage('belajar.png'), // Ganti dengan nama file gambar Anda
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "onBoardTitle2".tr,
          body: "onBoardBody2".tr,
          image: _buildImage('bermain.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "onBoardTitle3".tr,
          body: "onBoardBody3".tr,
          image: _buildImage('makan.png'),
          decoration: pageDecoration,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      showSkipButton: true,
      // skipFlex: 0,
      nextFlex: 0,
      skip: Text("introSkip".tr),
      next: const Icon(Icons.arrow_forward),
      done: Text('introStart'.tr,
          style: const TextStyle(fontWeight: FontWeight.w600)),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }
}
