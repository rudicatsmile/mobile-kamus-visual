import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:insta_image_viewer/insta_image_viewer.dart';

import '../../../config/api.dart';

// void main() => runApp(MyApp());

class HalamanUserDetail extends StatefulWidget {
  final String wordStr;

  HalamanUserDetail({required this.wordStr});
  @override
  _HalamanUserDetailState createState() => _HalamanUserDetailState();
}

class _HalamanUserDetailState extends State<HalamanUserDetail> {
  // String _word = ""; // Menyimpan input dari TextField
  Future<List<Map<String, String>>>? _wordMapFuture;


  @override
  void initState() {
    super.initState();    
    setState(() {
         _wordMapFuture = fetchWordMap(widget.wordStr);
    });         
  }

  @override
  Widget build(BuildContext context) {
    return 
      Scaffold(
        appBar: AppBar(title: const Text('Isyarat Abjad')),
        body: 
        
          Column(
          children: [
           
            Expanded(
              child: 
              LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  return FutureBuilder<List<Map<String, String>>>(
                    future: _wordMapFuture,
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
                        
                            child: 
                            
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
                                // scrollDirection: Axis.horizontal,
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index) {
                                  String letter = snapshot.data![index]['letter']!
                                      .toUpperCase();
                                  String word = snapshot.data![index]['word']!;
                                  return ListTile(
                                    leading: Text(letter,style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold,),),
                                    // title: Text('$letter: $word')
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
                                    )
                                    );
                                },
                              ),
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
          ],
        ),
      );
    // );
  }
}

//Jika array / List
Future<Map<String, String>> fetchWordMapList(String word) async {
  String url = '${Api.kamus}/word_mapping.php?word=$word';
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    return Map<String, String>.from(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load word map');
  }
}

//Jika objek
Future<List<Map<String, String>>> fetchWordMap(String word) async {
  String url = '${Api.kamus}/word_mapping.php?word=$word';
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    List<dynamic> jsonList = jsonDecode(response.body);
    return jsonList.map((item) => Map<String, String>.from(item)).toList();
  } else {
    throw Exception('Failed to load word map');
  }
}
