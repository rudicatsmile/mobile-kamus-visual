import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../../config/api.dart';

class VideoFullscreenPage extends StatefulWidget {
  final String videoUrl;

  VideoFullscreenPage({required this.videoUrl});

  @override
  _VideoFullscreenPageState createState() => _VideoFullscreenPageState();
}



class _VideoFullscreenPageState extends State<VideoFullscreenPage> {
  late VideoPlayerController _controller;
  bool _isPlaying = false;
  bool _showControls = true; // State untuk menampilkan/menyembunyikan kontrol

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network('${Api.kamus}/${widget.videoUrl}')
      ..initialize().then((_) {
        setState(() {
          _isPlaying = true;
        });
        _controller.play();
        _startHideControlsTimer(); // Mulai timer untuk menyembunyikan kontrol
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // ... (fungsi _togglePlayPause, _stopVideo, _seekForward, _seekBackward sama seperti sebelumnya)

  void _togglePlayPause() {
    setState(() {
      if (_isPlaying) {
        _controller.pause();
      } else {
        _controller.play();
      }
      _isPlaying = !_isPlaying;
    });
  }

  void _stopVideo() {
    setState(() {
      _isPlaying = false;
      _controller.pause();
      _controller.seekTo(Duration.zero);
    });
  }

  void _seekForward() {
    _controller.seekTo(_controller.value.position + Duration(seconds: 10));
  }

  void _seekBackward() {
    _controller.seekTo(_controller.value.position - Duration(seconds: 10));
  }

  void _startHideControlsTimer() {
    Future.delayed(Duration(seconds: 3), () {
      if (mounted && _controller.value.isPlaying) {
        setState(() {
          _showControls = false;
        });
      }
    });
  }

  // void _startHideControlsTimer() {
  //   Future.delayed(Duration(seconds: 3), () {
  //     if (mounted && _controller.value.isPlaying) {
  //       setState(() {
  //         _showControls = false;
  //       });
  //     }
  //   });
  // }

  void _toggleControlsVisibility() {
    setState(() {
      _showControls = !_showControls;
      if (_showControls) {
        _startHideControlsTimer();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const  Text('Video Penjelasan')),
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: _toggleControlsVisibility, // Sembunyikan/tampilkan kontrol saat layar di-tap
        child: Center(
          child: _controller.value.isInitialized
              ? Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    ),
                    if (_showControls) // Tampilkan kontrol hanya jika _showControls true
                      _buildControls(),
                    _buildPositionBar(), // Tambahkan track video
                  ],
                )
              : CircularProgressIndicator(),
        ),
      ),
    );
  }

  Widget _buildControls() {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: _seekBackward,
          icon: Icon(Icons.replay_10, color: Colors.white),
        ),
        IconButton(
          onPressed: _togglePlayPause,
          icon: Icon(
            _isPlaying ? Icons.pause : Icons.play_arrow,
            color: Colors.white,
          ),
        ),
        IconButton(
          onPressed: _stopVideo,
          icon: Icon(Icons.stop, color: Colors.white),
        ),
        IconButton(
          onPressed: _seekForward,
          icon: Icon(Icons.forward_10, color: Colors.white),
        ),
      ],
    ),
  );
}


  Widget _buildPositionBar() {
    return VideoProgressIndicator(
      _controller,
      allowScrubbing: true,
      padding: EdgeInsets.all(16.0),
      colors: VideoProgressColors(
        playedColor: Colors.blue,
        bufferedColor: Colors.blueGrey,
        backgroundColor: Colors.grey,
      ),
    );
  }
}
