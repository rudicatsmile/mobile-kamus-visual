import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UploadhotoController extends GetxController {
  TextEditingController usernameC = TextEditingController();
  TextEditingController passwordC = TextEditingController();

  RxBool isHidden = true.obs;
  RxBool isLoading = false.obs;
  RxBool showButtonPhoto = true.obs;

  RxString location = '..., ...'.obs;

  RxString address = 'Tunggu sampai tampil lokasi ...'.obs;
  String latitude = '';
  String longitude = '';
  String kodeRelawan = '';

  var selectedFile = Rx<XFile?>(null);

  Future<Position> _getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    // Test if location services are enabled.
    isLoading.value = true;
    showButtonPhoto.value = false;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future<void> GetAddressFromLatLong(Position position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    // print(placemarks);
    Placemark place = placemarks[0];
    address.value =
        '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
    isLoading.value = false;
    showButtonPhoto.value = true;
  }

  void getStringSF() async {
    // Position position = await _getGeoLocationPosition();
    // location.value = 'Lat: ${position.latitude} , Long: ${position.longitude}';
    // latitude = '${position.latitude}';
    // longitude = '${position.longitude}';
    // GetAddressFromLatLong(position);
    location.value = 'Lat: 111 , Long: 222';
  }

  @override
  void onInit() {
    getStringSF();
    super.onInit();
  }
}
