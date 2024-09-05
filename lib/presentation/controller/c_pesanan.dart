import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../config/api.dart';
import '../../data/model/data_barang.dart';

class PesananController extends GetxController {

  final String kodeDepo;
  final String dataSearch;
  final String noRekening;

  PesananController({required this.kodeDepo,required this.dataSearch,required this.noRekening});
  // PesananController(kodeDepo, dataSearch);


  var isLoading = true.obs;
  var daftarProduk = <DataBarang>[].obs;
  var totalHarga = 0.obs;


  @override
  void onInit() {
    // print('tes111...');
    super.onInit();
    // print('tes...');
    fetchProduk();
  }

  void fetchProduk() async {
    try {
      isLoading(true);
    
      String url = "http://192.168.43.17:81/e_warung/api/general/getBarangByKode.php?kdMerchant=$kodeDepo&dataSearch=$dataSearch";
      url = '${Api.getApotekLocation}/getBarangByKode.php?kdMerchant=$kodeDepo&dataSearch=$dataSearch';
      // print('The URL KU : $url');
      var response =
          await http.get(Uri.parse(url)); 
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        // print('URL22 : $jsonResponse');
        daftarProduk.value = (jsonResponse as List)
            .map((data) => DataBarang.fromJson(data))
            .toList();
      } else {
        throw Exception('Failed to loard products');
      }
    } finally {
      isLoading(false);
    }
  }

  void tambahJumlah(int index) {
    daftarProduk[index].jumlah++;
    print(index.toString() + ' : ' + daftarProduk[index].jumlah.toString());
    hitungTotal();
  }

  void kurangiJumlah(int index) {
    if (daftarProduk[index].jumlah > 0) {
      daftarProduk[index].jumlah--;
      hitungTotal();
    }
  }

  void hitungTotal() {
    // totalHarga.value = daftarProduk.fold(0, (sum, item) => sum + int.parse(item.hargaJualToko!) * item.jumlah);
    totalHarga.value = daftarProduk.fold(
        0,
        (sum, item) =>
            sum + num.tryParse(item.hargaJualToko!)!.toInt() * item.jumlah);
  }

  void submitPesanan() async {
    // 1. Siapkan data pesanan
    List<Map<String, dynamic>> dataPesanan = [];
    for (var produk in daftarProduk) {
      if (produk.jumlah > 0) {
        dataPesanan.add({
          'id_produk': produk.kdObat,
          'jumlah': produk.jumlah,
        });
      }
    }

    // 2. Kirim data pesanan ke server
    try {
      String url =  'http://192.168.43.17:81/e_warung/api/general/simpan_pesanan.php';
      url = '${Api.getApotekLocation}/simpan_pesanan.php';
      var response = await http.post(
        Uri.parse(url), // Ganti dengan URL backend Anda
        body: jsonEncode(dataPesanan),
        headers: {'Content-Type': 'application/json'},
      );

      // 3. Tangani respons dari server
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        if (jsonResponse['success'] == true) {
          // Pesanan berhasil disimpan
          // Get.snackbar('Sukses', 'Pesanan berhasil disubmit!', snackPosition: SnackPosition.BOTTOM);
          // Lakukan tindakan lain setelah pesanan berhasil (misalnya, reset keranjang belanja)

          // 1. Ambil ID pesanan dari respons (jika ada)

          //int orderId = jsonResponse['order_id'] ?? 0; // Default ke 0 jika tidak ada ID pesanan

          // 2. Tampilkan popup
          Get.defaultDialog(
            title: "Pesanan Berhasil",
            middleText:
                // "Total Harga: Rp ${totalHarga.value}\nID Pesanan: $orderId",
                "Total Harga: Rp ${totalHarga.value}\nSilahkan Transfer ke : $noRekening",
            textConfirm: "OK",
            onConfirm: () {
              Get.back(); // Tutup popup
              Get.back(); //Back to daftar Apotek/Warung
          // Get.back();
              // Lakukan tindakan lain setelah pesanan berhasil (misalnya, reset keranjang belanja)
            },
          );
          
        } else {
          // Terjadi kesalahan saat menyimpan pesanan di server
          Get.snackbar('Error', 'Gagal menyimpan pesanan. Silakan coba lagi.',
              snackPosition: SnackPosition.BOTTOM);
        }
      } else {
        // Terjadi kesalahan koneksi atau server
        Get.snackbar('Error', 'Terjadi kesalahan. Silakan coba lagi.',
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (error) {
      // Tangani kesalahan jaringan atau kesalahan lainnya
      Get.snackbar('Error', 'Terjadi kesalahan: $error',
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}
