import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../config/api.dart';
import 'abjad_model.dart';

class AbjadController extends GetxController {
  var kataKunci = ''.obs;
  var hasilPencarian = <AbjadModel>[].obs;
  var isLoading = false.obs;
  var error = false.obs;
  var errorMessage = ''.obs;

  void cariAbjad(String kataKunci) async {
    if (kataKunci.isNotEmpty) {
      isLoading.value = true;
      error.value = false; // Reset error state

      try {

        // var url = Uri.parse('${Api.kamus}/kamus.php?kata=$kataKunci');
        var url = Uri.parse('${Api.kamus}/word_mapping.php?word=$kataKunci');
        print('URLA1: $url');
        var response = await http.get(url);

        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);
          print('URLA2: $data');


          hasilPencarian.value = List<AbjadModel>.from(data.map((item) => AbjadModel.fromJson(item)));
          print('URLA3');
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
