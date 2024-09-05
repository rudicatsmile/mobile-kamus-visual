import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'main_page.dart'; // Import halaman utama Anda

class PetunjukPage extends StatefulWidget {
  @override
  _PetunjukPageState createState() => _PetunjukPageState();
}

class _PetunjukPageState extends State<PetunjukPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => MainPage()),
    );
  }

  Widget _buildImage(String assetName, [double width = 350]) {
    return Image.asset('assets/$assetName', width: width);
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);

    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: Colors.white,
      pages: [
        PageViewModel(
          title: "Selamat Datang di Aplikasi Visual Dictionary",
          body:
              "Aplikasi ini membantu Anda belajar bahasa isyarat dengan mudah dan menyenangkan.",
          image: _buildImage('petunjuk1.png'), // Ganti dengan nama file gambar Anda
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Cara Menggunakan Aplikasi",
          body:
              "1. Ketikkan kata yang ingin Anda cari di kolom pencarian.\n2. Hasil pencarian akan menampilkan gambar dan video isyarat.\n3. Ketuk video untuk melihat dalam mode layar penuh.",
          image: _buildImage('petunjuk2.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Tips Tambahan",
          body:
              "- Gunakan fitur pencarian untuk menemukan kata-kata yang Anda butuhkan.\n- Tonton video isyarat berulang kali untuk meningkatkan pemahaman Anda.\n- Praktikkan bahasa isyarat secara teratur untuk menjadi lebih lancar.",
          image: _buildImage('petunjuk3.png'),
          decoration: pageDecoration,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      showSkipButton: true,
      // skipFlex: 0,
      nextFlex: 0,
      skip: const Text('Lewati'),
      next: const Icon(Icons.arrow_forward),
      done: const Text('Mulai', style: TextStyle(fontWeight: FontWeight.w600)),
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
