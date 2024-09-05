import 'package:d_info/d_info.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import '../../../config/api.dart';
import '../../controller/c_upload_photo.dart';

class UploadPhotoKataPage extends StatefulWidget {
  final String kodeNik;
  final String tahun;
  final String bulan;
  final String mode;
  final String tahap;
  final String batch;
  final String gelombang;
  const UploadPhotoKataPage(this.kodeNik,
      {key,
      required this.mode,
      required this.tahun,
      required this.bulan,
      required this.tahap,
      required this.batch,
      required this.gelombang})
      : super(key: key);

  @override
  State<UploadPhotoKataPage> createState() => _UploadPhotoKataPageState();
}

class _UploadPhotoKataPageState extends State<UploadPhotoKataPage> {
  final UploadhotoController uploadPhotoC = Get.put(UploadhotoController());

  XFile? image;
  //List _images = [];
  final ImagePicker picker = ImagePicker();
  String location = '..., ...';
  String address = 'Tunggu sampai tampil lokasi ...';
  String latitude = '';
  String longitude = '';

  Future sendImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);
    var nLat = uploadPhotoC.latitude;
    var nLng = uploadPhotoC.longitude;

    var uri =
        "${Api.pesertaDtks}/upload_photo.php?nik=${widget.kodeNik}&tahun=${widget.tahun}&bulan=${widget.bulan}&tahap=${widget.tahap}&batch=${widget.batch}&gelombang=${widget.gelombang}&lat=$nLat&lng=$nLng&mode=${widget.mode}";
    var request = http.MultipartRequest('POST', Uri.parse(uri));
    if (img != null) {
      var pic = await http.MultipartFile.fromPath("image", img.path);
      //request.fields['title']=txtController.text;   //Untuk field title image
      request.files.add(pic);

      await request.send().then((result) {
        http.Response.fromStream(result).then((response) {
          // var message = jsonDecode(response.body);
          // final snackBar = SnackBar(content: Text(message['message']));
          // ScaffoldMessenger.of(context).showSnackBar(snackBar);
          //getImageServer();
          DInfo.dialogSuccess(context, 'Berhasil upload photo....');
          DInfo.closeDialog(context);
          //Get.offAll(FormPilihTps("02"));
        });
      }).catchError((e) {
        print(e);
      });
    }
  }

  // Future getImageServer() async {
  //   try {
  //     final response =
  //         await http.get(Uri.parse('/list_upload_photo.php'));

  //     if (response.statusCode == 200) {
  //       final data = jsonDecode(response.body);

  //       setState(() {
  //         _images = data;
  //       });
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  void getPhoto() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: const Text('Silahkan pilih photo yang akan di upload'),
            content: Container(
              height: MediaQuery.of(context).size.height / 6,
              child: Column(
                children: [
                  ElevatedButton(
                    //if user click this button, user can upload image from gallery
                    onPressed: () {
                      Navigator.pop(context);
                      sendImage(ImageSource.gallery);
                    },
                    child: const Row(
                      children: [
                        Icon(Icons.image),
                        Text('Ambil dari Gallery'),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    //if user click this button. user can upload image from camera
                    onPressed: () {
                      Navigator.pop(context);
                      sendImage(ImageSource.camera);
                    },
                    child: const Row(
                      children: [
                        Icon(Icons.camera),
                        Text('Ambil dari Camera'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  // Future<Position> _getGeoLocationPosition() async {
  //   bool serviceEnabled;
  //   LocationPermission permission;
  //   // Test if location services are enabled.
  //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     // Location services are not enabled don't continue
  //     // accessing the position and request users of the
  //     // App to enable the location services.
  //     await Geolocator.openLocationSettings();
  //     return Future.error('Location services are disabled.');
  //   }
  //   permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       // Permissions are denied, next time you could try
  //       // requesting permissions again (this is also where
  //       // Android's shouldShowRequestPermissionRationale
  //       // returned true. According to Android guidelines
  //       // your App should show an explanatory UI now.
  //       return Future.error('Location permissions are denied');
  //     }
  //   }
  //   if (permission == LocationPermission.deniedForever) {
  //     // Permissions are denied forever, handle appropriately.
  //     return Future.error(
  //         'Location permissions are permanently denied, we cannot request permissions.');
  //   }
  //   // When we reach here, permissions are granted and we can
  //   // continue accessing the position of the device.
  //   return await Geolocator.getCurrentPosition(
  //       desiredAccuracy: LocationAccuracy.high);
  // }

  // Future<void> GetAddressFromLatLong(Position position) async {
  //   List<Placemark> placemarks =
  //       await placemarkFromCoordinates(position.latitude, position.longitude);
  //   print(placemarks);
  //   Placemark place = placemarks[0];
  //   address =
  //       '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
  //   setState(() {});
  // }

  // void getStringSF() async {
  //   Position position = await _getGeoLocationPosition();
  //   location = 'Lat: ${position.latitude} , Long: ${position.longitude}';
  //   latitude = '${position.latitude}';
  //   longitude = '${position.longitude}';
  //   GetAddressFromLatLong(position);
  // }

  // @override
  // void initState() {
  //   // ignore: todo
  //   // TODO: implement initState
  //   //getStringSF();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Upload Photo'),
          // actions: [
          //   IconButton(
          //       onPressed: () {
          //         Get.off(const HomePage());
          //       },
          //       icon: const Icon(Icons.cancel))
          // ],
        ),
        body: Center(
          child: Obx(() => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Lokasi :',
                          style: TextStyle(
                              fontSize: 19, fontWeight: FontWeight.bold),
                        ),
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                uploadPhotoC.address.value,
                                style: const TextStyle(fontSize: 19),
                              ),
                            ),
                          ],
                        ),
                        Text(
                            'Lat : ${uploadPhotoC.latitude} - Long : ${uploadPhotoC.longitude}')
                      ],
                    ),
                  ),
                  DView.spaceHeight(20),
                  uploadPhotoC.isLoading.isFalse
                      ? GestureDetector(
                          onTap: () {
                            getPhoto();
                          },
                          child: Container(
                            height: 120.0,
                            width: 120.0,
                            decoration: const BoxDecoration(
                              color: Colors.amber,
                              image: DecorationImage(
                                image: AssetImage('assets/images/camera.png'),
                                fit: BoxFit.fill,
                              ),
                              shape: BoxShape.circle,
                            ),
                          ),
                        )
                      : Container(
                          height: 120.0,
                          width: 120.0,
                          decoration: const BoxDecoration(
                            color: Colors.white12,
                            image: DecorationImage(
                              image: AssetImage('assets/images/waiting.gif'),
                              fit: BoxFit.fill,
                            ),
                            shape: BoxShape.circle,
                          ),
                        ),
                ],
              )),
        ));
  }
}
