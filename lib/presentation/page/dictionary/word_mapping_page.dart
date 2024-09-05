import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../config/api.dart';

// void main() => runApp(MyApp());

class WordMapping extends StatefulWidget {
  @override
  _WordMappingState createState() => _WordMappingState();
}

class _WordMappingState extends State<WordMapping> {
  String _word = ""; // Menyimpan input dari TextField
  Future<Map<String, String>>?
      _wordMapFutureO; // Future untuk menyimpan hasil fetchWordMap
  Future<List<Map<String, String>>>? _wordMapFuture;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Word Mapping')),
        body: 
        
          Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    _word = value;
                  });
                },
                decoration: const InputDecoration(labelText: 'Masukkan kata'),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _wordMapFuture = fetchWordMap(_word);
                });
              },
              child: const Text('Petakan Kata'),
            ),
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
          ],
        ),
      ),
    );
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
  // final response = await http.get(Uri.parse('http://your_api_endpoint/word_mapping.php?word=$word'));
  String url = '${Api.kamus}/word_mapping.php?word=$word';
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    List<dynamic> jsonList = jsonDecode(response.body);
    return jsonList.map((item) => Map<String, String>.from(item)).toList();
  } else {
    throw Exception('Failed to load word map');
  }
}
