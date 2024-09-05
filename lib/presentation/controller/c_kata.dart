import 'dart:convert';

import 'package:d_method/d_method.dart';
import 'package:get/get.dart';
import '../../config/api.dart';
import '../../data/model/data_image_kata.dart';
import '../../data/model/list_kata.dart';
import '../../data/source/source_kata.dart';
import 'package:http/http.dart' as http;

class CKata extends GetxController {
  // RxString nikUser = ''.obs;
  final RxBool _loading = false.obs;
  bool get loading => _loading.value;
  set loading(bool newData) {
    _loading.value = newData;
  }

  final RxList<ListKata> _list = <ListKata>[].obs;
  List<ListKata> get list => _list.value;
  setList() async {
    loading = true;
    // DMethod.printTitle('Source : ', 'setList aja');

    update();
    _list.value = await SourceKata.gets();
    update();
    Future.delayed(const Duration(seconds: 1), () {
      loading = false;
      update();
    });
  }

  final RxList<DataImageKata> _listImage = <DataImageKata>[].obs;
  List<DataImageKata> get listImage => _listImage.value;
  setListImage(nik, tahun, bulan, mode) async {
    loading = true;
    _listImage.value = await SourceKata.getImage(nik, tahun, bulan, mode);
    Future.delayed(const Duration(seconds: 1), () {
      loading = false;
    });
  }

  search(String query) async {
    // _list.value = await SourcePesertaDtks.search(query);
    //1*
    // _listByNik.value = await SourcePesertaDtks.search(query);
    _listKata.value = await SourceKata.search(query);
    update();
  }

  final RxList<ListKata> _listKata = <ListKata>[].obs;
  List<ListKata> get listKata => _listKata.value;

  setListKata(nik, kdlokasi) async {
    loading = true;
    DMethod.printTitle('Source : ', 'setListKata aja');
    update();
    _listKata.value = await SourceKata.getsKata(nik, kdlokasi);
    update();
    Future.delayed(const Duration(seconds: 1), () {
      loading = false;
      update();
    });
  }

  var katas = <ListKata>[].obs;
  var isLoading = false.obs;
  var currentPage = 1.obs;
  var hasMore = true.obs;

  Future<void> fetchKatas() async {
    if (isLoading.value || !hasMore.value) return;

    isLoading(true);
    try {
      // final response = await http.get(Uri.parse('http://159.223.45.187/api/kamus/getWithPage.php?page=${currentPage.value}&limit=10'));

      final response = await http.get(Uri.parse(
          '${Api.kamus}/getWithPage.php?page=${currentPage.value}&limit=10}'));

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        // print('Received JSON: $jsonData');

        if (jsonData['data'] != null && jsonData['data'] is List) {
          var newKatas = (jsonData['data'] as List)
              .map((item) => ListKata.fromJson(item))
              .toList();

          if (newKatas.isEmpty) {
            hasMore(false);
          } else {
            _listKata.addAll(newKatas);
            currentPage++;
          }
        } else {
          // print('Invalid data format: ${jsonData['data']}');
          hasMore(false);
        }
      } else {
        // print('Server returned status code: ${response.statusCode}');
        throw Exception('Failed to load katas');
      }
    } catch (e) {
      // print('Error fetching katas: $e');
      hasMore(false);
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchKatas_old() async {
    if (isLoading.value || !hasMore.value) return;

    isLoading(true);
    try {
      // final response = await http.get(Uri.parse('http://159.223.45.187/api/kamus/getWithPage.php?page=${currentPage.value}&limit=10'));

      final response = await http.get(Uri.parse(
          '${Api.kamus}/getWithPage.php?page=${currentPage.value}&limit=10}'));

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        // print('Received JSON: $jsonData');

        if (jsonData['data'] != null && jsonData['data'] is List) {
          var newKatas = (jsonData['data'] as List)
              .map((item) => ListKata.fromJson(item))
              .toList();

          if (newKatas.isEmpty) {
            hasMore(false);
          } else {
            katas.addAll(newKatas);
            currentPage++;
          }
        } else {
          // print('Invalid data format: ${jsonData['data']}');
          hasMore(false);
        }
      } else {
        // print('Server returned status code: ${response.statusCode}');
        throw Exception('Failed to load katas');
      }
    } catch (e) {
      // print('Error fetching katas: $e');
      hasMore(false);
    } finally {
      isLoading(false);
    }
  }

  final RxList<ListKata> _listKataPaging = <ListKata>[].obs;
  List<ListKata> get listKataPaging => _listKataPaging.value;

  setListKataPaging(page, limit) async {
    loading = true;
    DMethod.printTitle('Source : ', 'setListKataPaging aja');
    update();
    _listKataPaging.value = await SourceKata.getsKataPaging(page, limit);
    update();
    Future.delayed(const Duration(seconds: 1), () {
      loading = false;
      update();
    });
  }

  @override
  void onInit() {
    //setList();
    super.onInit();
  }
}
