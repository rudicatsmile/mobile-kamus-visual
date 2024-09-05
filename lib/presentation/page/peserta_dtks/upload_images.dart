import 'package:d_info/d_info.dart';
// import 'dart:convert';
import 'dart:io';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
// import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import 'package:async/async.dart';
import 'package:video_player/video_player.dart';

import '../../../config/api.dart';
import '../../controller/c_upload_photo.dart';
import '../../controller/c_user.dart';

class UploadImageScreen extends StatefulWidget {
  // const UploadImageScreen({Key? key}) : super(key: key);
  final String kodeNik;
  final String tahun;
  final String bulan;
  final String mode;
  final String tahap;
  final String batch;
  final String gelombang;
  const UploadImageScreen(this.kodeNik,
      {key,
      required this.mode,
      required this.tahun,
      required this.bulan,
      required this.tahap,
      required this.batch,
      required this.gelombang})
      : super(key: key);

  @override
  State<UploadImageScreen> createState() => _UploadImageScreenState();
}

class _UploadImageScreenState extends State<UploadImageScreen> {
  final UploadhotoController uploadPhotoC = Get.put(UploadhotoController());
  final cUser = Get.put(CUser());

  // final TextEditingController txtController = TextEditingController();
  final txtController = TextEditingController();
  File? imageFile;
  // File? videoFile;
  XFile? videoFile;
  VideoPlayerController? _videoController;

  @override
  void dispose() {
    _videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.mode == 'video'
            ? Text('uploadVideo'.tr)
            : Text('uploadImage'.tr),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 20.0,
              ),
              imageFile != null ||
                      (_videoController != null &&
                          _videoController!.value.isInitialized)
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(150.0),
                      child: widget.mode == "video"
                          ? AspectRatio(
                              aspectRatio: _videoController!.value.aspectRatio,
                              child: VideoPlayer(_videoController!),
                            )
                          : Image.file(
                              imageFile!,
                              height: 230.0,
                              width: 230.0,
                              fit: BoxFit.fill,
                            ))
                  : Obx(() {
                      return SizedBox(
                          child: uploadPhotoC.isLoading.isFalse
                              ? Image.asset(
                                  'assets/images/camera.png',
                                  height: 230.0,
                                  width: 230.0,
                                )
                              : Image.asset(
                                  'assets/images/waiting.gif',
                                  height: 230.0,
                                  width: 230.0,
                                ));
                    }),

              const SizedBox(
                height: 20.0,
              ),
              //Tampilkan Lat - Lng disini
              DView.spaceHeight(20),
              // Obx(() =>
              // Container(
              //     padding: const EdgeInsets.all(16),
              //     decoration: BoxDecoration(
              //       color: Colors.black12,
              //       borderRadius: BorderRadius.circular(16),
              //     ),
              //     child: Column(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [
              //         const Text(
              //           'Lokasi :',
              //           style: TextStyle(
              //               fontSize: 14, fontWeight: FontWeight.bold),
              //         ),
              //         Row(
              //           children: [
              //             Flexible(
              //               child: Text(
              //                 uploadPhotoC.address.value,
              //                 style: const TextStyle(fontSize: 14),
              //               ),
              //             ),
              //           ],
              //         ),
              //         Text(
              //             'Lat : ${uploadPhotoC.latitude} - Long : ${uploadPhotoC.longitude}')
              //       ],
              //     ),
              //   )
              //   ),
              Column(
                children: [
                  ElevatedButton(
                      onPressed: () async {
                        Get.back();
                      },
                      child: const Text('Batal')),
                  DView.spaceWidth(10),
                  imageFile != null ||
                          (_videoController != null &&
                              _videoController!.value.isInitialized)
                      ? ElevatedButton(
                          onPressed: () {
                            widget.mode == "video"
                                ? sendVideo(videoFile!)
                                : sendImage(imageFile!);
                          },
                          child: widget.mode == 'video'
                              ? Text('sendVideo'.tr)
                              : Text('sendImage'.tr),
                        )
                      : const SizedBox(),
                  DView.spaceWidth(10),
                  Obx(() {
                    return uploadPhotoC.showButtonPhoto.isTrue
                        ? ElevatedButton(
                            onPressed: () async {
                              // Map<Permission, PermissionStatus> statuses = await [Permission.storage, Permission.camera, ].request();
                              showImagePicker(context);
                            },
                            child: imageFile != null ||
                                    (_videoController != null &&
                                        _videoController!.value.isInitialized)
                                ? Text('takeAgainImage'.tr)
                                : widget.mode == 'video'
                                    ? Text('takeVideo'.tr)
                                    : Text('takeImage'.tr))
                        : const SizedBox();
                  }),
                ],
              ),
              const SizedBox(
                height: 15,
              ),

              imageFile != null
                  ? Container(
                      // color: Colors.white,
                      padding: const EdgeInsets.only(left: 16),
                      child: TextField(
                        controller: txtController,
                        // autofocus: true,
                        style: const TextStyle(
                            fontSize: 18.0, color: Colors.black),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'inputImageHeader'.tr,
                          hintStyle: TextStyle(color: Colors.black54),
                          contentPadding: const EdgeInsets.only(
                              left: 14.0, bottom: 8.0, top: 8.0),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.blue),
                            borderRadius: BorderRadius.circular(10.7),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: const BorderSide(color: Colors.red),
                            borderRadius: BorderRadius.circular(10.7),
                          ),
                        ),
                      ))
                  : const SizedBox(),

              const SizedBox(
                height: 15,
              ),

              // imageFile != null
              //     ? ElevatedButton(
              //         onPressed: () {
              //           sendImage(imageFile!);
              //         },
              //         child: const Text("Kirim Photo"))
              //     : Text('---')
            ],
          ),
        ),
      ),
    );
  }

  final picker = ImagePicker();

  Future sendImage(File imageFile) async {
    //var img = await picker.pickImage(source: media);
    var nLat = "123456";
    var nLng = "789098";
    // var kodeNik = "6271015907850004";
    var tahun = "2024";
    var bulan = "4";
    var tahap = "1";
    var batch = "7121";
    var gelombang = "1";
    // var mode = "Testing";

    //var nLat = uploadPhotoC.latitude;
    //var nLng = uploadPhotoC.longitude;
    var pencatat = cUser.data.nama;

    var stream =
        new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    var length = await imageFile.length();

    var uri =
        "${Api.kamus}/upload_photo.php?nik=${widget.kodeNik}&tahun=$tahun&bulan=$bulan&tahap=${tahap}&batch=${batch}&gelombang=${gelombang}&lat=$nLat&lng=$nLng&mode=${widget.mode}";
    // print('URL : ' + uri);

    // Get.snackbar("URI : ", uri, colorText: Colors.white,backgroundColor: Colors.black,
    // duration: Duration(seconds:10),
    // icon: const Icon(Icons.add_alert), );

    // var uritest =
    //     "https://pandohopdinsos.palangkaraya.go.id/api_pandohop/pesertaDtks/upload_photo.php?nik=${kodeNik}&tahun=${tahun}&bulan=${bulan}&tahap=${tahap}&batch=${batch}&gelombang=${gelombang}&lat=$nLat&lng=$nLng&mode=${mode}";
    var request = http.MultipartRequest('POST', Uri.parse(uri));
    var pic = await http.MultipartFile("image", stream, length,
        filename: imageFile.path);
    request.fields['title'] = txtController.text; //Untuk field title image
    request.fields['pencatat'] = 'app_mobile'; //Untuk field title image
    request.files.add(pic);

    await request.send().then((result) {
      http.Response.fromStream(result).then((response) {
        // var message = jsonDecode(response.body);
        // final snackBar = SnackBar(content: Text(message['message']));
        // ScaffoldMessenger.of(context).showSnackBar(snackBar);
        //getImageServer();
        DInfo.dialogSuccess(context, 'successUploadImage'.tr);
        DInfo.closeDialog(context);
        //Get.offAll(FormPilihTps("02"));
        // final snackBar = SnackBar(
        //   content: const Text('Yay! A SnackBar!'),
        //   action: SnackBarAction(
        //     label: 'Undo',
        //     onPressed: () {
        //       // Some code to undo the change.
        //     },
        //   ),
        // );
      });
    }).catchError((e) {
      print(e);
    });
    //}
  }

  Future sendVideo(XFile imageFile) async {
    var nLat = "123456";
    var nLng = "789098";
    var tahun = "2024";
    var bulan = "4";
    var tahap = "1";
    var batch = "7121";
    var gelombang = "1";
    var pencatat = cUser.data.nama;

    var stream =
        new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    var length = await imageFile.length();

    var uri =
        "${Api.kamus}/upload_photo.php?nik=${widget.kodeNik}&tahun=$tahun&bulan=$bulan&tahap=${tahap}&batch=${batch}&gelombang=${gelombang}&lat=$nLat&lng=$nLng&mode=${widget.mode}";
    var request = http.MultipartRequest('POST', Uri.parse(uri));
    var pic = await http.MultipartFile("image", stream, length,
        filename: imageFile.path);
    request.fields['title'] = txtController.text; //Untuk field title image
    request.fields['pencatat'] = 'app_mobile'; //Untuk field title image
    request.files.add(pic);

    await request.send().then((result) {
      http.Response.fromStream(result).then((response) {
        DInfo.dialogSuccess(context, 'successUploadImage'.tr);
        DInfo.closeDialog(context);
      });
    }).catchError((e) {
      print(e);
    });
  }

  void showImagePicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return Card(
              child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 5.2,
            margin: const EdgeInsets.only(top: 8.0),
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    child: InkWell(
                  child: const Column(
                    children: [
                      Icon(
                        Icons.image,
                        size: 60.0,
                      ),
                      SizedBox(height: 12.0),
                      Text(
                        "Gallery",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      )
                    ],
                  ),
                  onTap: () {
                    widget.mode == 'video'
                        ? _videoFromGallery()
                        : _imgFromGallery();
                    Navigator.pop(context);
                  },
                )),
                Expanded(
                    child: InkWell(
                  child: const SizedBox(
                    child: Column(
                      children: [
                        Icon(
                          Icons.camera_alt,
                          size: 60.0,
                        ),
                        SizedBox(height: 12.0),
                        Text(
                          "Camera",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        )
                      ],
                    ),
                  ),
                  onTap: () {
                    widget.mode == 'video'
                        ? _videoFromCamera()
                        : _imgFromCamera();
                    Navigator.pop(context);
                  },
                )),
              ],
            ),
          ));
        });
  }

  _videoFromGallery() async {
    final allowedVideoTypes = ['video/mp4', 'video/quicktime'];

    final ImagePicker picker = ImagePicker();
    videoFile = await picker.pickVideo(source: ImageSource.gallery);
    // videoFile = await picker.pickVideo(source: ImageSource.camera);

    if (videoFile != null && videoFile!.path != null) {
      final mimeType =
          lookupMimeType(videoFile!.path); // Dapatkan mimeType dari path

      if (mimeType != null && !allowedVideoTypes.contains(mimeType)) {
        Get.snackbar('Error', 'Tipe video tidak didukung');
        videoFile = null;
      }
    }

    if (videoFile != null) {
      setState(() {
        videoFile = videoFile;
        _videoController = VideoPlayerController.file(File(videoFile!.path))
          ..initialize().then((_) {
            setState(() {});
          });
      });
    }
  }

  _videoFromCamera() async {
    final allowedVideoTypes = ['video/mp4', 'video/quicktime'];

    final ImagePicker picker = ImagePicker();
    // videoFile = await picker.pickVideo(source: ImageSource.gallery);
    videoFile = await picker.pickVideo(source: ImageSource.camera);

    if (videoFile != null && videoFile!.path != null) {
      final mimeType =
          lookupMimeType(videoFile!.path); // Dapatkan mimeType dari path

      if (mimeType != null && !allowedVideoTypes.contains(mimeType)) {
        Get.snackbar('Error', 'Tipe video tidak didukung');
        videoFile = null;
      }
    }

    if (videoFile != null) {
      setState(() {
        videoFile = videoFile;
        _videoController = VideoPlayerController.file(File(videoFile!.path))
          ..initialize().then((_) {
            setState(() {});
          });
      });
    }
  }

  _imgFromGallery() async {
    await picker
        .pickImage(source: ImageSource.gallery, imageQuality: 50)
        .then((value) {
      if (value != null) {
        _cropImage(File(value.path));
      }
    });
  }

  _imgFromCamera() async {
    await picker
        .pickImage(source: ImageSource.camera, imageQuality: 50)
        .then((value) {
      if (value != null) {
        _cropImage(File(value.path));
      }
    });
  }

  _cropImage(File imgFile) async {
    final croppedFile = await ImageCropper().cropImage(
        sourcePath: imgFile.path,
        aspectRatioPresets: Platform.isAndroid
            ? [
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio16x9
              ]
            : [
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio5x3,
                CropAspectRatioPreset.ratio5x4,
                CropAspectRatioPreset.ratio7x5,
                CropAspectRatioPreset.ratio16x9
              ],
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: "Image Cropper",
              toolbarColor: Colors.deepOrange,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          IOSUiSettings(
            title: "Image Cropper",
          )
        ]);
    if (croppedFile != null) {
      imageCache.clear();
      setState(() {
        imageFile = File(croppedFile.path);
      });
      // reload();
    }
  }
}
