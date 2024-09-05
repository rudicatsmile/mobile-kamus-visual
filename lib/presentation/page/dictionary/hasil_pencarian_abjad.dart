import 'package:flutter/material.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:video_player/video_player.dart';

import '../../../config/api.dart';
import 'abjad_model.dart';
import 'vide_fullscreen_page.dart'; 

class HasilPencarianAbjad extends StatefulWidget {
  final AbjadModel item;

  HasilPencarianAbjad({required this.item});

  @override
  _HasilPencarianAbjadState createState() => _HasilPencarianAbjadState();
}

class _HasilPencarianAbjadState extends State<HasilPencarianAbjad> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  bool isVideoError = false; // Tambahkan state untuk error video

  @override
  void initState() {
    super.initState();
    // _controller =  VideoPlayerController.network('${Api.kamus}/${widget.item.image}')
    //       ..initialize().then((_) {
    //         setState(() {});
    //       })
    //       ..addListener(() {
    //         if (_controller.value.hasError) {
    //           setState(() {
    //             isVideoError = true;
    //           });
    //         }
    //       });
  }

  @override
  void dispose() {
    //_controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.item.letter),
      leading:          
          CircleAvatar(
            radius: 20,
            backgroundColor: Colors.transparent,
            child: InstaImageViewer(
              child: Image(
                  width: 50,
                  height: 60,
                  fit: BoxFit.fill,
                  image: Image.network('${Api.kamus}/images/abjad/${widget.item.word}').image),
            ),
          ),
      
          
      //onTap: () {
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
        //           VideoFullscreenPage(videoUrl: widget.item.image),
        //     ),
        //   );
        // }
      //},
    );
  }
}
