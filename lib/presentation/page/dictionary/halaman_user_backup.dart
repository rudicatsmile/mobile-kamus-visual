import 'dart:convert';

import 'package:eapotek/presentation/page/dictionary/c_kamus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../config/api.dart';
import 'hasil_pencarian_item.dart';
import 'package:http/http.dart' as http;

class HalamanUser extends StatelessWidget {
  final KamusController controller = Get.put(KamusController());
  final TextEditingController _searchController =
      TextEditingController(); // Controller untuk TextField


  Future<List<Map<String, String>>> fetchWordMap(String word) async {
    String url = '${Api.kamus}/word_mapping.php?word=$word';
    print('URL:'+url);
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

    String _word = ""; // Menyimpan input dari TextField
    Future<List<Map<String, String>>>? _wordMapFuture;
  
    return Scaffold(
      appBar: AppBar(
        title: Text('Kamus Visual Dictionary'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child:
                     
                      TextField(
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
                      hintText: 'Cari kata...',
                      suffixIcon: IconButton(
                        onPressed: () {
                          controller.cariKata(_searchController.text);
                        },
                        icon: const Icon(Icons.search, color: Colors.white),
                      ),
                    ),
                  ),
                ),
                // IconButton(
                //   icon: const Icon(Icons.search),
                //   onPressed: () {
                //     controller.cariKata(_searchController.text);
                //   },
                // ),
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
                    ? const Expanded(
                        child: Center(
                          child: Text('Tidak ada hasil.'),
                        ),
                      )
                    : Expanded(
                        child: 
                        
                          Container(
                            height: double.infinity,
                            width: double.infinity,
                            color: Colors.yellow,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //==========

                                  Expanded(
                                    child: LayoutBuilder(
                                    builder: (BuildContext context, BoxConstraints constraints) {
                                      return FutureBuilder<List<Map<String, String>>>(
                                        // future: _wordMapFuture,
                                        future : fetchWordMap(_searchController.text),
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
                                                    // ... (kode itemBuilder sama)
                                                    String letter = snapshot.data![index]['letter']!
                                                        .toUpperCase();
                                                    String word = snapshot.data![index]['word']!;
                                                    return ListTile(title: Text('$letter: $word'));
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
                                                                    ),
                                  ),

                                //===========
                                Container(
                                    margin: const EdgeInsets.all(12),
                                    // height: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.cyan,
                                      borderRadius: BorderRadius.circular(12),
                                        shape: BoxShape.rectangle,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 1,
                                            blurRadius: 3,
                                          ),
                                        ]),
                                    child: 
                                     
                                          ListView.builder(
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
                      ),
          ),
        ],
      ),
    );
  }
}
