import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import '../../config/api.dart';

// Model Data Dokumen
class Document {
  String kodeDepo;
  String kodeObat;
  String harga;
  String userId;
  String fileName;
  String fileType;
  String filePath; // Base64 encoded file

  Document(
      {required this.kodeDepo,required this.kodeObat,required this.harga,required this.userId,required this.fileName, required this.fileType, required this.filePath});

  Map<String, dynamic> toJson() => {
        'kodeDepo': kodeDepo,
        'kodeObat': kodeObat,
        'harga': harga,
        'userId': userId,
        'fileName': fileName,
        'fileType': fileType,
        'filePath': filePath,
      };
}

// GetX Controller ...
class UploadController extends GetxController {

  final String kodeDepo;
  final String userId;
  final String dataSearch;
  final String kodeObat;
  final String harga;

  UploadController({required this.kodeDepo,required this.userId,required this.dataSearch,required this.kodeObat,required this.harga});

  var isLoading = false.obs;
  var selectedFile = Rx<XFile?>(null);
  // var userId = '-';

  // final cUser = Get.put(CUser());

  // var kdKelurahan = cUser.data.idApotek;

  // Tambahan: Tipe dokumen yang diizinkan
  final allowedFileTypes = ['image/jpeg', 'image/png', 'image/jpg', 'image/gif', 'application/pdf'];

  void pickFile() async {
    final ImagePicker picker = ImagePicker();
    selectedFile.value = await picker.pickImage(source: ImageSource.gallery);

    // Validasi tipe file
    //Pada android tertentu mimeType memberi nilai null
    if (selectedFile.value != null && !allowedFileTypes.contains(selectedFile.value!.mimeType)) {
      //Get.snackbar('Error', 'Tipe file ${selectedFile.value?.mimeType} tidak didukung ');
      //selectedFile.value = null; // Reset pilihan file
    }
  }

  Future<void> uploadDocument() async {
    if (selectedFile.value == null) return;

    isLoading.value = true;

    try {
      final bytes = await selectedFile.value!.readAsBytes();
      String base64Image = base64Encode(bytes);

      String url =  'http://192.168.43.17:81/e_warung/api/general/upload_file.php';
      url = '${Api.getApotekLocation}/upload_file.php';

      final document = Document(
        kodeDepo: kodeDepo,
        kodeObat: kodeObat,
        harga: harga,
        userId: userId,
        fileName: selectedFile.value!.name,
        // fileType: selectedFile.value!.mimeType!,
        fileType: "-",
        filePath: base64Image,
      );

      final response = await http.post(
        Uri.parse(url),
        body: jsonEncode(document.toJson()),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        isLoading.value = false;
        Get.snackbar(
            'Sukses', responseData['message'] ?? 'Berkas berhasil diunggah');

        Get.defaultDialog(
          title: "Sukses",
          middleText: "Berkas berhasil diunggah!",
          onConfirm: () {
            Get.back(); // Tutup dialog
            Get.back(); // Kembali ke halaman sebelumnya
          },
          textConfirm: "OK",
        );

      } else {
        isLoading.value = false;
        final errorData = jsonDecode(response.body);
        Get.snackbar('Error', errorData['error'] ?? 'Gagal mengunggah berkas');
      }
    } catch (e) {
      Get.snackbar('Error ', 'Terjadi kesalahan: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
