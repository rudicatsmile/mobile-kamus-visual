import 'package:eapotek/presentation/page/dictionary/kamus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:video_player/video_player.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../config/api.dart';
import 'halaman_user_detail.dart';
import 'halaman_user_detail_images.dart';
import 'vide_fullscreen_page.dart'; // Untuk caching gambar

class HasilPencarianItem extends StatefulWidget {
  final KamusModel item;

  HasilPencarianItem({required this.item});

  @override
  _HasilPencarianItemState createState() => _HasilPencarianItemState();
}

class _HasilPencarianItemState extends State<HasilPencarianItem> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  bool isVideoError = false; // Tambahkan state untuk error video

  @override
  void initState() {
    super.initState();
    _controller =
        VideoPlayerController.network('${Api.kamus}/${widget.item.video}')
          ..initialize().then((_) {
            // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
            setState(() {});
          })
          ..addListener(() {
            if (_controller.value.hasError) {
              setState(() {
                isVideoError = true;
              });
            }
          });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      
      leading:
          GestureDetector(
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      HalamanUserDetail(wordStr: widget.item.kata),
                ),
              );
            },
            child: CachedNetworkImage(
              imageUrl: '${Api.kamus}/${widget.item.gambar}',
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          // CircleAvatar(
          //   radius: 20,
          //   backgroundColor: Colors.transparent,
          //   child: InstaImageViewer(
          //     child: Image(
          //         width: 50,
          //         height: 60,
          //         fit: BoxFit.fill,
          //         image: Image.network('${Api.kamus}/${widget.item.gambar}').image),
          //   ),
          // ),
      title: 
          // Text(widget.item.kata,style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold,),),
          GestureDetector( // Bungkus title dengan GestureDetector
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HalamanUserDetailImages(kataId: int.parse(widget.item.id),kataStr: widget.item.kata,),
                ),
              );
            },
            child: Text(widget.item.kata),
          ),
      subtitle: Text(widget.item.keterangan ?? '-' ,style: const TextStyle(fontSize: 12)),
      trailing: isVideoError
          ? const Icon(Icons.error,color: Colors.red) 
          :    
           IconButton(
                          onPressed: () {
                            Get.to(VideoFullscreenPage(videoUrl: widget.item.video));
                          },
                          icon: const Icon(Icons.play_arrow),
                          iconSize: 20,
                          color: Colors.black,
                        ),       
          
          // _controller.value.isInitialized
          //     ? AspectRatio(
          //         aspectRatio: _controller.value.aspectRatio,
          //         child: Stack(
          //           alignment: Alignment.center,
          //           children: [
          //             VideoPlayer(_controller),
          //             if (!_controller.value.isPlaying)
          //               IconButton(
          //                 onPressed: () {
          //                   Get.to(VideoFullscreenPage(videoUrl: widget.item.video));
          //                 },
          //                 icon: const Icon(Icons.play_arrow),
          //                 iconSize: 20,
          //                 color: Colors.white70,
          //               ),
          //           ],
          //         ),
          //       )
          //     : const CircularProgressIndicator(), // Tampilkan indikator loading jika video belum siap
      onTap: () {
        // if (!isVideoError) {
        //   setState(() {
        //     if (_controller.value.isPlaying) {
        //       _controller.pause();
        //     } else {
        //       _controller.play();
        //     }
        //   });
        // }
        // },

        // if (!isVideoError) {
        //   Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) =>
        //           VideoFullscreenPage(videoUrl: widget.item.video),
        //     ),
        //   );
        // }
          Navigator.push(
            context,
            MaterialPageRoute(
              // builder: (context) => HalamanUserDetail(wordStr: widget.item.kata),
              builder: (context) => HalamanUserDetailImages(kataId: int.parse(widget.item.id),kataStr: widget.item.kata,),

            ),
          );
        

        // Get.to(HalamanUserDetail(wordStr: widget.item.kata));
      },
    );
  }
}
