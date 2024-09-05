import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../config/api.dart';

class HalamanUserDetailImages extends StatefulWidget {
  final int kataId;
  final String kataStr;

  HalamanUserDetailImages({required this.kataId, required this.kataStr});

  @override
  _HalamanUserDetailImagesState createState() => _HalamanUserDetailImagesState();
}

class _HalamanUserDetailImagesState extends State<HalamanUserDetailImages> {
  late Future<Map<String, dynamic>> _futureKata;
  VideoPlayerController? _videoPlayerController;

  @override
  void initState() {
    super.initState();
    _futureKata = fetchKataDetail(widget.kataId);
  }

  Future<Map<String, dynamic>> fetchKataDetail(int id) async {

    final response = await http.get(Uri.parse('${Api.kamus}/detail.php?id=$id'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load kata detail');
    }
  }

  @override
  void dispose() {
    _videoPlayerController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text('Hasil Kata : ${widget.kataStr.toString().capitalize}', style: const TextStyle(fontWeight: FontWeight.bold,),),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _futureKata,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final kata = snapshot.data!;
            _videoPlayerController = VideoPlayerController.network(kata['video'])
              ..initialize();
            return Column(
              children: [
                // Expanded(
                //   child: 
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.all(12),
                    // color: Colors.yellow,
                    child: 
                      
                      CachedNetworkImage(
                        width: 110,
                        imageUrl: '${Api.kamus}/'+kata['gambar'],
                        fit: BoxFit.cover,
                      ),
                      // CircleAvatar(
                      //   radius: 20,
                      //   backgroundColor: Colors.transparent,
                      //   child: InstaImageViewer(
                      //     child: Image(
                      //         width: 420,
                      //         // height: 60,
                      //         fit: BoxFit.cover,
                      //         image: Image.network('${Api.kamus}/'+kata['gambar']).image),
                      //   ),
                      // ),
                  ),
                // ),

                //Text Tulisan keterangan gambar simbol
              // Expanded(
              //     child: 
                    Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.all(5),
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                                      color: Colors.blue[200],
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
                        Text(kata["keterangan"],style: TextStyle(fontSize: 17),)
                    ),
                // ),
                Expanded(
                  child: Container(
                    // height: 1000,
                    alignment: Alignment.center,
                    margin: EdgeInsets.all(12),
                    // color: Colors.blue,
                    child: CachedNetworkImage(
                       width: 150,
                      // alignment: Alignment.center,
                      imageUrl: '${Api.kamus}/'+kata['gambar2'],
                      fit: BoxFit.fill,
                    ),
                  ),
                ),

                Expanded(
                  child: Container(
                    // height: 1000,
                    alignment: Alignment.center,
                    margin: EdgeInsets.all(12),
                    // color: Colors.blue,
                    child: CachedNetworkImage(
                       width: 150,
                      // alignment: Alignment.center,
                      imageUrl: '${Api.kamus}/'+kata['gambar3'],
                      fit: BoxFit.fill,
                    ),
                  ),
                ),

                Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.all(5),
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                                      color: Colors.blue[200],
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
                        Text(kata["keterangan2"],style: TextStyle(fontSize: 17),)
                    ),

                
               
                // Expanded(
                //   child: Container(
                //     child: AspectRatio(
                //       aspectRatio: _videoPlayerController!.value.aspectRatio,
                //       child: VideoPlayer(_videoPlayerController!),
                //     ),
                //   ),
                // ),
              ],
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('${snapshot.error}'));
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
