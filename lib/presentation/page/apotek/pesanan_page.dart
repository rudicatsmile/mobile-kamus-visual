// import 'dart:convert';
// import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/c_pesanan.dart';

class HalamanPesanan extends StatelessWidget {
  
  // HalamanPesanan(String? kodeDepo, String? dataSearch, {super.key});
  String kodeDepo; 
  String dataSearch; 
  String noRekening; 
  HalamanPesanan({super.key, required this.kodeDepo,required this.dataSearch,required this.noRekening});   

  // final PesananController controller = Get.put(PesananController(kodeDepo: kodeDepo));

  @override
  Widget build(BuildContext context) {
    //final PesananController controller = Get.find<PesananController>();
    final PesananController controller = Get.put(PesananController(kodeDepo: kodeDepo, dataSearch: dataSearch, noRekening: noRekening ));

    return Scaffold(
      appBar: AppBar(title: const Text('Pesanan ')),
      body: Obx(() => controller.isLoading.value
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: controller.daftarProduk.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(controller.daftarProduk[index].nama),
                        subtitle:
                            Text('Rp ${controller.daftarProduk[index].hargaJualToko}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove),
                              onPressed: () => controller.kurangiJumlah(index),
                            ),
                            Text('${controller.daftarProduk[index].jumlah}'),
                            IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: () => controller.tambahJumlah(index),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Total:',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      Text('Rp ${controller.totalHarga.value}',
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: controller.submitPesanan,
                  child: const Text('Submit Pesanan'),
                ),
              ],
            )),
    );
  }
}
