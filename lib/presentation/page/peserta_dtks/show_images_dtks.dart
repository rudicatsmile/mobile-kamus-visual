// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';


// import 'package:d_view/d_view.dart';
// import 'package:get/get.dart';
// import '../../../data/model/peserta _dtks.dart';
// import '../../../data/source/source_peserta_dtks.dart';
// import '../../controller/c_perserta_dtks.dart';
// import 'add_peserta_dtks_page.dart';
// import 'pengajuan_dtks_peserta_page.dart';
// import 'upload_photo.dart';

class ShowImagesDtks extends StatefulWidget {
  final String nik;
  final String tahun;
  final String bulan;
  final String mode;
  const ShowImagesDtks({
    Key? key,
    required this.nik,
    required this.tahun,
    required this.bulan,
    required this.mode,
  }) : super(key: key);

  @override
  State<ShowImagesDtks> createState() => _ShowImagesDtksState();
}

class _ShowImagesDtksState extends State<ShowImagesDtks> {
  // final cPesertaDtks = Get.put(CPesertaDtks());
  List record = [];

  Future<void> imageFromdb(nik, tahun, bulan, mode) async {
    try {
      String uri =
          "http://localhost:81/pandohop/api_pandohop/pesertaDtks/get_images.php?nik=" +
              nik +
              "&tahun=" +
              tahun +
              "&bulan=" +
              bulan;
      print(uri);
      var response = await http.get(Uri.parse(uri));
      if (response.statusCode == 200) {
        print("reponse.body");
      } else {
        print('A network error occurred');
      }
      print(response.toString());
      setState(() {
        record = jsonDecode(response.body);
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    imageFromdb(widget.nik, widget.tahun, widget.bulan,widget.mode);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: const Text('Photo Peserta DTKS'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2),
          itemCount: record.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              margin: const EdgeInsets.all(10),
              child: Column(children: [
                // Expanded(
                //   child: Image.network(
                //     "http://localhost:81/pandohop/images/dtks/" + record[index]["file_name"]
                //   )
                //   ),
                Text(record[index]["caption"])
              ]),
            );
          }),
    );
  }
}
