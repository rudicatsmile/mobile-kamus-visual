import 'package:eapotek/presentation/page/dictionary/kamus.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../config/api.dart';

class KamusController extends GetxController {
  var kataKunci = ''.obs;
  var hasilPencarian = <KamusModel>[].obs;
  var isLoading = false.obs;
  var error = false.obs;
  var errorMessage = ''.obs;

  void cariKata(String kataKunci) async {
    if (kataKunci.isNotEmpty) {
      isLoading.value = true;
      error.value = false; // Reset error state

      try {

        var url = Uri.parse('${Api.kamus}/kamus.php?kata=$kataKunci');
        var response = await http.get(url);

        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);

          hasilPencarian.value = List<KamusModel>.from(data.map((item) => KamusModel.fromJson(item)));
        } else {
          error.value = true;
          errorMessage.value = 'Gagal memuat data. Kode error: ${response.statusCode}';
        }
      } catch (e) {
        error.value = true;
        errorMessage.value = 'Terjadi kesalahan: $e';
      } finally {
        isLoading.value = false;
      }
    }
  }
}
