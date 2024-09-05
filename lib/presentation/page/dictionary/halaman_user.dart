import 'dart:convert';

import 'package:eapotek/presentation/page/dictionary/c_kamus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import '../../../config/api.dart';
import '../peserta_dtks/peserta_dtks_page.dart';
import 'admin_kata_page.dart';
import 'c_abjad.dart';
import 'hasil_pencarian_item.dart';
import 'package:http/http.dart' as http;

import 'manage_kata_page.dart';

class HalamanUser extends StatelessWidget {
  final KamusController controller = Get.put(KamusController());
  final AbjadController abjadController = Get.put(AbjadController());
  final TextEditingController _searchController = TextEditingController();

  HalamanUser({super.key});

  Future<List<Map<String, String>>> fetchWordMap(String word) async {
    String url = '${Api.kamus}/word_mapping.php?word=$word';
    print('URL:' + url);
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((item) => Map<String, String>.from(item)).toList();
    } else {
      throw Exception('Failed to load word map');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Visual Dictionary'), actions: [
        IconButton(
            onPressed: () {
              // Get.to(() => const ManageKatapage(
              Get.to(() => const AdminKataPage(
                  kriteria: 'surveyor', nik: '', kdlokasi: ''))?.then((value) {
                if (value ?? false) {
                  // cPesertaDtks.setListKata(cUser.data.userId,cUser.data.idApotek);
                  //cPesertaDtks.setListKata('','');
                }
              });
            },
            icon: const Icon(Icons.add_circle)),
      ]),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    onChanged: (value) => controller.kataKunci.value = value,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 16),
                      isDense: true,
                      filled: true,
                      // fillColor: AppColor.input,
                      hintText: 'findWord'.tr,
                      suffixIcon: IconButton(
                        onPressed: () {
                          controller.cariKata(_searchController.text);
                          //abjadController.cariAbjad(_searchController.text);
                        },
                        icon: const Icon(Icons.search, color: Colors.black),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Obx(
            () => controller.isLoading
                    .value // Menampilkan CircularProgressIndicator saat loading
                ? const Expanded(
                    child: Center(child: CircularProgressIndicator()),
                  )
                : controller.hasilPencarian.isEmpty
                    ? Expanded(
                        child: Center(
                          child: Text('dataNotFound'.tr),
                        ),
                      )
                    : Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                    shape: BoxShape.rectangle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 3,
                                      ),
                                    ]),
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: controller.hasilPencarian.length,
                                  itemBuilder: (context, index) {
                                    return HasilPencarianItem(
                                      item: controller.hasilPencarian[index],
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        // ),
                      ),
          ),
        ],
      ),
    );
  }

  LayoutBuilder abjadLayout() {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return FutureBuilder<List<Map<String, String>>>(
          // future: _wordMapFuture,
          future: fetchWordMap(_searchController.text),
          // future : fetchWordMap('dina'),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SizedBox(
                  width: constraints.maxWidth,
                  height: constraints.maxHeight,
                  child: ListView.builder(
                    shrinkWrap: true,
                    // scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      String letter =
                          snapshot.data![index]['letter']!.toUpperCase();
                      String word = snapshot.data![index]['word']!;
                      return ListTile(
                          leading: Text(
                            letter,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          title: CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.transparent,
                            child: InstaImageViewer(
                              child: Image(
                                  width: 50,
                                  height: 60,
                                  fit: BoxFit.fill,
                                  image: Image.network(
                                          '${Api.kamus}/images/abjad/$word')
                                      .image),
                            ),
                          ));
                    },
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return const CircularProgressIndicator();

            // ... (sisa kode sama)
          },
        );
      },
    );
  }
}
