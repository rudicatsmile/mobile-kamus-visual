import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // Untuk memilih gambar
import 'package:video_player/video_player.dart'; // Untuk menampilkan video
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CrudPage extends StatefulWidget {
  @override
  _CrudPageState createState() => _CrudPageState();
}

class _CrudPageState extends State<CrudPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _kataController = TextEditingController();
  XFile? _imageFile; // Untuk menyimpan file gambar yang dipilih
  XFile? _videoFile; // Untuk menyimpan file video yang dipilih
  final ImagePicker _picker = ImagePicker();
  VideoPlayerController? _videoPlayerController;

  Future<void> _ambilGambar() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = image;
    });
  }

  Future<void> _ambilVideo() async {
    final XFile? video = await _picker.pickVideo(source: ImageSource.gallery);
    setState(() {
      _videoFile = video;
      _videoPlayerController = VideoPlayerController.file(File(video!.path))
        ..initialize().then((_) {
          setState(() {});
        });
    });
  }

  Future<void> _simpanData() async {
    if (_formKey.currentState!.validate()) {
      // Logika untuk mengirim data ke backend (kata, gambar, video)
      // ...
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CRUD Kata'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _kataController,
                decoration: InputDecoration(labelText: 'Kata'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Kata tidak boleh kosong';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _ambilGambar,
                child: Text('Pilih Gambar'),
              ),
              if (_imageFile != null) Image.file(File(_imageFile!.path)),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _ambilVideo,
                child: Text('Pilih Video'),
              ),
              if (_videoPlayerController != null)
                AspectRatio(
                  aspectRatio: _videoPlayerController!.value.aspectRatio,
                  child: VideoPlayer(_videoPlayerController!),
                ),
              SizedBox(height: 24.0),
              ElevatedButton(
                onPressed: _simpanData,
                child: Text('Simpan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
