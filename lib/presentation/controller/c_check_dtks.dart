import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

import '../../config/api.dart';

class CheckViewKibController extends GetxController {
  RxBool isLoading = false.obs;
  String kodeBar = '';

  void checkDtks(String kode) async {
    isLoading.value = true;
    kodeBar = kode;
    const CircularProgressIndicator();
    // DMethod.printTitle('CEK KEDUA:  ', 'CEK : $BASE_URL/checkViewkib.php');
    String url = '${Api.pesertaDtks}/checkDtks.php';

    var response = await post(Uri.parse(url),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded"
        },
        body: {"kodeBar": kodeBar},
        encoding: Encoding.getByName("utf-8"));

    var data = json.decode(response.body);

    isLoading.value = false;

    if (data["message"] == "Success") {
      // Get.to(DetailPage(index: 1, code: kode));
    } else {
      // Get.offAll(Formkiblite(kode));
    }
  }
}
