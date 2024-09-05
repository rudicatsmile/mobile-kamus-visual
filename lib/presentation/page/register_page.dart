import 'dart:convert';

import 'package:d_info/d_info.dart';
import 'package:d_input/d_input.dart';
import 'package:d_view/d_view.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../config/api.dart';
import '../../../data/model/ref_lokasi.dart';
import '../../../data/source/source_user.dart';
import 'package:http/http.dart' as http;


class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final controllerName = TextEditingController();
  final controllerUserId = TextEditingController();
  final controllerNik = TextEditingController();
  final controllerPassword = TextEditingController();
  final controllerPhone = TextEditingController();
  final controllerWa = TextEditingController();
  final formKey = GlobalKey<FormState>();

  bool validator = false;
  bool surveyor = false;
  bool verifikator = false;
  bool adjusment = false;
  bool adminUser = false;
  bool adminPeserta = false;

// Initial Selected Value
  String? kdPropinsi;
  String? kdKabupaten;
  String? kdKecamatan;
  String? kdKelurahan ;
  String? nmKelurahan;
  String? kdRw;
  String? kdRt;  
  String? kdAgama;
  String? kdStatusKawin;
  String? kdPekerjaan;
  String? kdKewarganegaraan;
  String userName = '';
  String sType = '';
  String phone = '';
  String whatsapp = '';

  // List of items in our dropdown menu
  // var items = [
  //   'administrator',
  //   'reguler',
  // ];

  String? adminTypeValue = "Reguler";
  List<String> dropdownItems = ['Administrator', 'Reguler'];

  Future getUnit(tableName, kode) async {
    var level = "level";
    String url =
        '${Api.location}/${Api.gets}?tableName=$tableName&level=$level&kodeParent=$kode';
    //DMethod.printTitle('URL : ', url);
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
    if (formKey.currentState!.validate()) {

       if (kdPropinsi == null) {
        DInfo.dialogError(context, "Propinsi harus di isi");
        DInfo.closeDialog(context,
            durationBeforeClose: const Duration(seconds: 3));
        return false;
      }
      if (kdKabupaten == null) {
        DInfo.dialogError(context, "Kabupaten harus di isi");
        DInfo.closeDialog(context,
            durationBeforeClose: const Duration(seconds: 3));
        return false;
      }
      if (kdKecamatan == null) {
        DInfo.dialogError(context, "Kecamatan harus di isi");
        DInfo.closeDialog(context,
            durationBeforeClose: const Duration(seconds: 3));
        return false;
      }
      bool? yes =
          await DInfo.dialogConfirmation(context, 'Pendaftaran baru', 'Ya, Konfirmasi');
      if (yes == true) {
        bool success = await SourceUser.register(
            controllerName.text,
            controllerUserId.text,
            controllerPassword.text,
            controllerPhone.text,
            controllerWa.text,
            kdPropinsi!,
            kdKabupaten!,
            kdKecamatan!,           
            );
        if (success) {
          DInfo.dialogSuccess(context, 'Berhasil menambahkan user');
          DInfo.closeDialog(
            context,
            actionAfterClose: () => Get.back(result: true),
          );
        } else {
          DInfo.dialogError(context, 'Gagal menambahkan user');
          DInfo.closeDialog(
            context,
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DView.appBarLeft('Pendaftaran User'),
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            DInput(
              title: 'Nama',
              controller: controllerName,
              validator: (value) => value == '' ? "Tidak boleh kosong" : null,
            ),
            DView.spaceHeight(),
            DInput(
              title: 'User ID',
              controller: controllerUserId,
              validator: (value) => value == '' ? "Tidak boleh kosong" : null,
            ),           
            DView.spaceHeight(),
            DInput(
              title: 'Password',
              controller: controllerPassword,
              validator: (value) => value == '' ? "Tidak boleh kosong" : null,
              inputType: TextInputType.visiblePassword,
            ),
            DView.spaceHeight(),
            DInput(
              title: 'Nomor Telepon',
              controller: controllerPhone,
              validator: (value) => value == '' ? "Tidak boleh kosong" : null,
            ),
            DView.spaceHeight(),
            DInput(
              title: 'Nomor Whatsapp',
              controller: controllerWa,
              validator: (value) => value == '' ? "Tidak boleh kosong" : null,
            ),

            //ComboBox Propinsi
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
                kdPropinsi = value?.kodeUnit;
                sType = '1';
              },
              dropdownBuilder: (context, selectedItem) =>
                  Text(selectedItem?.namaUnit ?? "Pilih Propinsi"),
              asyncItems: (text) async => await getUnit("ref_lokasi_pro", ""),
            ),
            //ComboBox Kabupaten / Kota
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
                kdKabupaten = value?.kodeUnit;
                sType = '2';
              },
              dropdownBuilder: (context, selectedItem) =>
                  Text(selectedItem?.namaUnit ?? "Pilih Kabupaten / Kota : "),
              asyncItems: (text) async => await getUnit("ref_lokasi_kab", kdPropinsi),
            ),
            //ComboBox Kecamatan
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
                kdKecamatan = value?.kodeUnit;
                sType = '3';
              },
              dropdownBuilder: (context, selectedItem) =>
                  Text(selectedItem?.namaUnit ?? "Pilih Kecamatan"),
              asyncItems: (text) async => await getUnit("ref_lokasi_kec", kdKabupaten),
            ),
        
            //Button submit Tambah
            DView.spaceHeight(),
            ElevatedButton(
              onPressed: () => add(),
              child: const Text('T a m b a h',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}
