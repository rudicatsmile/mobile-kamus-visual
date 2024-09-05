import 'package:d_info/d_info.dart';
import 'package:d_method/d_method.dart';
import 'package:d_view/d_view.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../config/api.dart';
import '../../../data/model/peserta.dart';
import '../../../data/model/ref_lokasi.dart';
import '../../../data/source/source_peserta.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PengajuanPesertaPage extends StatefulWidget {
  const PengajuanPesertaPage({Key? key, this.peserta}) : super(key: key);
  final Peserta? peserta;

  @override
  State<PengajuanPesertaPage> createState() => _PengajuanPesertaPageState();
}

class _PengajuanPesertaPageState extends State<PengajuanPesertaPage> {
  final formKey = GlobalKey<FormState>();

  final controllerNik = TextEditingController();
  final controllerNoKK = TextEditingController();
  final controllerNama = TextEditingController();
  final controllerTempatLahir = TextEditingController();
  final controllerTanggalLahir = TextEditingController();
  final controllerJenisKelamin = TextEditingController();
  final controllerAlamat = TextEditingController();
  final controllerRtRw = TextEditingController();
  final controllerProvinsi = TextEditingController();
  final controllerKabupaten = TextEditingController();
  final controllerKecamatan = TextEditingController();
  final controllerDesa = TextEditingController();
  final controllerAgama = TextEditingController();
  final controllerStatusKawin = TextEditingController();
  final controllerPekerjaan = TextEditingController();
  final controllerKewarganegaraan = TextEditingController();


  String? kdKecamatan;
  String? kdBansos;
  String? kdPmks;
  String? kdTanggungan;

  String? kdKelurahan;
  String? kdRw;
  String? kdRt;
  String? nmKelurahan;
  String? kdAgama;
  String? kdStatusKawin;
  String? kdPekerjaan;
  String? kdKewarganegaraan;
  String userName = '';
  String sType = '';
  String level = "";

  String nik = "";
  String nokk = "";
  String nama = "";
  String tempatLahir = "";
  String tanggalLahir = "";
  String jenisKelamin = "";
  String alamat = "";
  String rtRw = "";
  String provinsi = "";
  String kabupaten = "";
  String kecamatan = "";
  String desa = "";
  String agama = "";
  String statusKawin = "";
  String pekerjaan = "";
  String kewarganegaraan = "";
  


  List<String> stringListJenisKelamin = [
    'L',
    'P',
  ];

  String? selectedItem;
  String? hSelectedItem;
  String? selectedJenisKelamin;

  Future getUnit(tableName, kode) async {
    level = "level";
    String url =
        '${Api.location}/${Api.gets}?tableName=$tableName&level=$level&kodeParent=$kode';
    DMethod.printTitle('URL : ', url);
    var response = await http.get(Uri.parse(url));
    if (response.statusCode != 200) {
      return [];
    }
    List allUnit =
        (json.decode(response.body) as Map<String, dynamic>)["value"];
    List<RefLokasi> allModelUnit = [];
    allUnit.forEach((element) {
      allModelUnit.add(RefLokasi(
          kodeUnit: element["kode_unit"], namaUnit: element["nama_unit"]));
    });
    return allModelUnit;
  }

  add() async {
    kdAgama ??= "";
    kdStatusKawin ??= "";
    kdPekerjaan ??= "";
    kdKewarganegaraan ??= "";

    if (formKey.currentState!.validate()) {
      if (controllerNik.text.length < 16) {
        DInfo.dialogError(context, "Panjang NIK harus 16 digit");
        DInfo.closeDialog(context,
            durationBeforeClose: const Duration(seconds: 5));
        return false;
      }
      if (controllerNoKK.text.length < 16) {
        DInfo.dialogError(context, "Panjang Nomor KK harus 16 digit");
        DInfo.closeDialog(context,
            durationBeforeClose: const Duration(seconds: 5));
        return false;
      }
      if (kdBansos == null) {
        DInfo.dialogError(context, "Data Jenis Bansos masih kosong");
        DInfo.closeDialog(context,
            durationBeforeClose: const Duration(seconds: 5));
        return false;
      }
      if (kdPmks == null) {
        DInfo.dialogError(context, "Data Jenis PPKS masih kosong");
        DInfo.closeDialog(context,
            durationBeforeClose: const Duration(seconds: 5));
        return false;
      }
      if (kdTanggungan == null) {
        DInfo.dialogError(context, "Data Jenis Tanggungan masih kosong");
        DInfo.closeDialog(context,
            durationBeforeClose: const Duration(seconds: 5));
        return false;
      }
      if (kdKelurahan == null) {
        DInfo.dialogError(context, "Data Kelurahan masih kosong");
        DInfo.closeDialog(context,
            durationBeforeClose: const Duration(seconds: 5));
        return false;
      }
      bool? yes = await DInfo.dialogConfirmation(
          context, 'Tambah Peserta', 'Ya untuk Konfirmasi');
      if (yes != null) {
        bool success = await SourcePeserta.add(
          controllerNik.text,
          controllerNoKK.text,
          controllerNama.text,
          controllerTempatLahir.text,
          controllerTanggalLahir.text,
          selectedJenisKelamin!,
          controllerAlamat.text,
          controllerRtRw.text,
          kdBansos!,
          kdPmks!,
          kdTanggungan!,
          kdKelurahan!,
          kdRw!,
          kdRt!,
          kdAgama!,
          kdStatusKawin!,
          kdPekerjaan!,
          kdKewarganegaraan!,
        );
        if (success) {
          DInfo.dialogSuccess(context, 'Sukses menambah peserta');
          DInfo.closeDialog(
            context,
            actionAfterClose: () => Get.back(result: true),
          );
        } else {
          DInfo.dialogError(context, 'Gagal menambah peserta');
          DInfo.closeDialog(
            context,
          );
        }
      }
    }
    //}
  }

  addPengajuanPeserta() async {
    bool? yes = await DInfo.dialogConfirmation(
        context, 'Tambah Pengajuan', 'Pengajuan Peserta ?');
    if (yes == true) {
      bool success = await SourcePeserta.updatePengajuan(
          widget.peserta!.nik!, 
          kdPmks!,
          kdTanggungan!
          );
      if (success) {
        DInfo.dialogSuccess(context, 'Success Update Product');
        DInfo.closeDialog(context, actionAfterClose: () {
          Get.back(result: true);
        });
      } else {
        DInfo.dialogError(context, 'Failed Update Product');
        DInfo.closeDialog(
          context,
        );
      }
    }
  }

  @override
  void initState() {
    selectedJenisKelamin = stringListJenisKelamin.first;
   
    // if (widget.peserta != null) {
    //   controllerNik.text = widget.peserta!.nik!;
    //   controllerNoKK.text = widget.peserta!.nokk!;
    //   controllerNama.text = widget.peserta!.nama!;
    //   controllerTempatLahir.text = widget.peserta!.tempatLahir!;
    //   controllerTanggalLahir.text = widget.peserta!.tanggalLahir!;
    //   controllerJenisKelamin.text = widget.peserta!.jenisKelamin!;
    //   controllerAlamat.text = widget.peserta!.alamatKtp!;
    //   controllerRtRw.text = widget.peserta!.rtrwKtp!;
    //   controllerProvinsi.text = widget.peserta!.provinsiKtp!;
    //   controllerKabupaten.text = widget.peserta!.kabupatenKtp!;
    //   controllerKecamatan.text = widget.peserta!.kecamatanKtp!;
    //   controllerDesa.text = widget.peserta!.kelurahanKtp!;
    //   controllerAgama.text = widget.peserta!.agama!;
    //   controllerStatusKawin.text = widget.peserta!.stakaw!;
    //   controllerPekerjaan.text = widget.peserta!.pekerjaan!;
    //   controllerKewarganegaraan.text = widget.peserta!.kewarganegaraan!;


    //    _openDropDownProgKey.currentState?.changeSelectedItem(widget.peserta!.stakaw!);
    // }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DView.appBarLeft('Pengajuan Peserta'),
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
           

            // const Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Column(
            //       mainAxisAlignment: MainAxisAlignment.spaceAround,
            //       children: [
            //           Text('NIP'),
            //       ],
            //     ),
            //     Column(
            //       mainAxisAlignment: MainAxisAlignment.start,
            //       children: [
            //           Text('controllerNik.text')
            //       ],
            //     )                
            //   ],
            // ),
            // DView.spaceHeight(),
            // const Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Column(
            //       mainAxisAlignment: MainAxisAlignment.spaceAround,
            //       children: [
            //           Text('Nomor KK'),
            //       ],
            //     ),
            //     Column(
            //       mainAxisAlignment: MainAxisAlignment.start,
            //       children: [
            //           Text('controllerNama.text')
            //       ],
            //     )                
            //   ],
            // ),
            // DView.spaceHeight(),
            // const Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Column(
            //       mainAxisAlignment: MainAxisAlignment.spaceAround,
            //       children: [
            //           Text('NAMA'),
            //       ],
            //     ),
            //     Column(
            //       mainAxisAlignment: MainAxisAlignment.start,
            //       children: [
            //           Text('controllerALAAMAt.text')
            //       ],
            //     )                
            //   ],
            // ),
             DView.spaceHeight(),
             Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                      Text('NIK'),
                      Text('No.KK'),
                      Text('NAMA'),
                      Text('ALAMAT'),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                      Text(widget.peserta!.nik!,overflow: TextOverflow.ellipsis,),
                      Text(widget.peserta!.nokk!,overflow: TextOverflow.ellipsis,),
                      Text(widget.peserta!.nama!,overflow: TextOverflow.ellipsis,),
                      Text(widget.peserta!.alamatKtp!,overflow: TextOverflow.ellipsis,),
                  ],
                )                
              ],
            ),
           
            //ComboBox Jenis PMKS
            DView.spaceHeight(),
            DropdownSearch<RefLokasi>(
              popupProps: PopupProps.menu(
                  favoriteItemProps: const FavoriteItemProps(
                      favoriteItemsAlignment: MainAxisAlignment.center),
                  showSearchBox: true,
                  itemBuilder: (context, item, isSelected) {
                    return ListTile(
                      selected: isSelected,
                      title: Text(item.namaUnit.toString()),
                    );
                  }),
              onChanged: (value) {
                kdPmks = value?.kodeUnit;                
                sType = '2';
              },
              dropdownBuilder: (context, selectedItem) =>
                  Text(selectedItem?.namaUnit ?? "Pilih Jenis PPKS "),
              asyncItems: (text) async => await getUnit("ref_jenis_pmks", ''),
            ),
            //ComboBox Jenis Tanggungan
            DView.spaceHeight(),
            DropdownSearch<RefLokasi>(
              popupProps: PopupProps.menu(
                  favoriteItemProps: const FavoriteItemProps(
                      favoriteItemsAlignment: MainAxisAlignment.center),
                  showSearchBox: true,
                  itemBuilder: (context, item, isSelected) {
                    return ListTile(
                      selected: isSelected,
                      title: Text(item.namaUnit.toString()),
                    );
                  }),
              onChanged: (value) {
                kdTanggungan = value?.kodeUnit;
                sType = '3';
              },
              dropdownBuilder: (context, selectedItem) =>
                  Text(selectedItem?.namaUnit ?? "Pilih Jenis Tanggungan"),
              asyncItems: (text) async => await getUnit("ref_jenis_tanggungan", ''),
            ),
                     
            DView.spaceHeight(),
            ElevatedButton(
              // onPressed: () => add(),
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  if (widget.peserta == null) {
                    add();
                  } else {
                    addPengajuanPeserta();
                  }
                }
              },
              child: Text(
                  widget.peserta == null ? 'Tambah Pengajuan peserta' : 'Pengajuan Peserta'),
            ),
          ],
        ),
      ),
    );
  }
}
