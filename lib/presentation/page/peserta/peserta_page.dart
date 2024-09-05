// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:d_info/d_info.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/source/source_peserta.dart';

import '../../../data/model/peserta.dart';
import '../../controller/c_perserta.dart';
import 'add_peserta_page.dart';
import 'pengajuan_peserta_page.dart';

class PesertaPage extends StatefulWidget {
  // final String kriteria;
  // const PesertaPage(this.kriteria, {key}) : super(key: key);

  final String kriteria;
  const PesertaPage({
    Key? key,
    required this.kriteria,
  }) : super(key: key);

  @override
  State<PesertaPage> createState() => _PesertaPageState();
}

class _PesertaPageState extends State<PesertaPage> {
  final cPeserta = Get.put(CPeserta());

  delete(String idPeserta) async {
    bool? yes = await DInfo.dialogConfirmation(
        context, 'Delete Peserta', 'Ya Untuk Konfirmasi');
    // if (yes != null) {
    if (yes == true) {
      bool success = await SourcePeserta.delete(idPeserta);
      if (success) {
        DInfo.dialogSuccess(context, 'Sukses hapus peserta');
        DInfo.closeDialog(
          context,
          actionAfterClose: () => cPeserta.setList(),
        );
      } else {
        DInfo.dialogError(context, 'gagal hapus peserta');
        DInfo.closeDialog(
          context,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: const Text('Data Peserta'),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => const AddPesertaPage())?.then((value) {
                if (value ?? false) {
                  cPeserta.setList();
                }
              });
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: GetBuilder<CPeserta>(builder: (_) {
        if (cPeserta.loading) return DView.loadingCircle();
        if (cPeserta.list.isEmpty) return DView.empty();
        return ListView.separated(
          itemCount: cPeserta.list.length,
          separatorBuilder: (context, index) => const Divider(
            height: 1,
            indent: 16,
            endIndent: 16,
            color: Colors.white70,
          ),
          itemBuilder: (context, index) {
            Peserta peserta = cPeserta.list[index];
            return ListTile(
              leading: CircleAvatar(
                radius: 18,
                child: Text('${index + 1}'),
                backgroundColor: 
                  peserta.statusPengajuan=='aktif' ? Colors.greenAccent : Colors.white
                  ,
              ),
              title: Text(peserta.nama ?? ''),
              subtitle: Text(
                peserta.alamatKtp ?? ''                
              ),
              trailing: PopupMenuButton<String>(
                onSelected: (value) {
                  if (value == 'update') {
                    Get.to(() => AddPesertaPage(peserta: peserta))!
                        .then((value) {
                      if (value ?? false) {
                        cPeserta.setList();
                      }
                    });
                  } else if(value == 'pengajuan'){
                    Get.to(() => PengajuanPesertaPage(peserta: peserta))!
                        .then((value) {
                      if (value ?? false) {
                        cPeserta.setList();
                      }
                    });
                  }else {
                    delete(peserta.idt.toString());
                  }
                  
                },
                icon: const Icon(Icons.more_vert),

                itemBuilder: (context) => [
                  widget.kriteria == 'pengajuan'
                      ? const PopupMenuItem(
                          value: 'pengajuan',
                          child: Text('Pengajuan'),
                        )
                      : const PopupMenuItem(
                          value: 'update',
                          child: Text('Update'),
                        ),

                  widget.kriteria == 'pengajuan'
                      ? const PopupMenuItem(
                          value: 'empty',
                          child: Text(''),
                        )
                      : const PopupMenuItem(
                          value: 'delete',
                          child: Text('Delete'),
                        ),
                  
                  
                 
                ],

                // itemBuilder: (context) => [
                //   const PopupMenuItem<String>(
                //     value: 'delete',
                //     child: Text('Delete'),
                //   ),
                // ],
              ),
            );
          },
        );
      }),
    );
  }
}
