import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/c_upload_file.dart';
import '../../controller/c_user.dart';

class UploadFile extends StatelessWidget {
  String kodeDepo; 
  String dataSearch; 
  String kodeObat; 
  String harga; 
  UploadFile({super.key, required this.kodeDepo,required this.dataSearch,required this.kodeObat,required this.harga});   

  // final UploadController controller = Get.put(UploadController());
  final cUser = Get.put(CUser());

  @override
  Widget build(BuildContext context) {
    
    final UploadController controller = Get.put(UploadController(kodeDepo: kodeDepo, userId: cUser.data.userId.toString(), dataSearch: dataSearch, kodeObat: kodeObat,harga: harga));
    
    return Scaffold(
      appBar: AppBar(title: const Text('Unggah dokumen / berkas')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() => Text(controller.selectedFile.value?.name ?? 'Belum ada file')),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: controller.pickFile,
              child: const Text('Pilih Dokumen / Berkas'),
            ),
            const SizedBox(height: 20),
            Obx(
              () => ElevatedButton(
                onPressed: controller.isLoading.value ? null : controller.uploadDocument,
                child: controller.isLoading.value
                    ? const CircularProgressIndicator()
                    : const Text('Unggah'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
