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


class AddEmployeePage extends StatefulWidget {
  const AddEmployeePage({Key? key}) : super(key: key);

  @override
  State<AddEmployeePage> createState() => _AddEmployeePageState();
}

class _AddEmployeePageState extends State<AddEmployeePage> {
  final controllerName = TextEditingController();
  final controllerUserId = TextEditingController();
  final controllerNik = TextEditingController();
  final controllerPassword = TextEditingController();
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
  String? nmKelurahan;
  String? kdRw;
  String? kdRt;  
  String? kdAgama;
  String? kdStatusKawin;
  String? kdPekerjaan;
  String? kdKewarganegaraan;
  String userName = '';
  String sType = '';
  String? kdKelurahan ;

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

       if (kdKelurahan == null) {
        DInfo.dialogError(context, "Data Desa / Kelurahan harus di isi");
        DInfo.closeDialog(context,
            durationBeforeClose: const Duration(seconds: 3));
        return false;
      }
      bool? yes =
          await DInfo.dialogConfirmation(context, 'Add User', 'Yes to confirm');
      if (yes == true) {
        bool success = await SourceUser.add(
            controllerName.text,
            controllerUserId.text,
            controllerPassword.text,
            controllerNik.text,
            adminTypeValue!,
            adminUser,
            adminPeserta,
            validator,
            surveyor,
            verifikator,
            adjusment,
            kdKelurahan!
            );
        if (success) {
          DInfo.dialogSuccess(context, 'Success Add User');
          DInfo.closeDialog(
            context,
            actionAfterClose: () => Get.back(result: true),
          );
        } else {
          DInfo.dialogError(context, 'Failed Add User');
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
      appBar: DView.appBarLeft('tambah User'),
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            DInput(
              title: 'Nama',
              controller: controllerName,
              validator: (value) => value == '' ? "Don't empty" : null,
            ),
            DView.spaceHeight(),
            DInput(
              title: 'User ID',
              controller: controllerUserId,
              validator: (value) => value == '' ? "Don't empty" : null,
            ),
            DView.spaceHeight(),
            DInput(
              title: 'NIK',
              controller: controllerNik,
              validator: (value) => value == '' ? "Don't empty" : null,
            ),
            DView.spaceHeight(),
            DInput(
              title: 'Password',
              controller: controllerPassword,
              validator: (value) => value == '' ? "Don't empty" : null,
              inputType: TextInputType.visiblePassword,
            ),
            DView.spaceHeight(),
            //Dropdown Tipe user
            DropdownButton<String>(
                hint: const Text(
                  "Pilih Tipe User",
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 18,
                  ),
                ),
                value: adminTypeValue,
                // isExpanded: true,
                underline: const SizedBox(),
                borderRadius: BorderRadius.circular(10),
                dropdownColor: Colors.white,
                items: dropdownItems.map((String value) {
                  return DropdownMenuItem<String>(
                      value: value, child: Text(value));
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    adminTypeValue = newValue!;
                  });
                }),
            DView.spaceHeight(),

            //Checkbox Pilihan Admin User - Admin Peserta - Validator - Surveyor - Verifikator
            Row(
              children: [
                Checkbox(
                    value: adminUser,
                    onChanged: (value) {
                      setState(() {
                        adminUser = value!;
                      });
                    }),
                const Text(
                  "Admin User",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
            DView.spaceHeight(),
            Row(
              children: [
                Checkbox(
                    value: adminPeserta,
                    onChanged: (value) {
                      setState(() {
                        adminPeserta = value!;
                      });
                    }),
                const Text(
                  "Admin Peserta",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
            DView.spaceHeight(),
            Row(
              children: [
                Checkbox(
                    value: validator,
                    onChanged: (value) {
                      setState(() {
                        validator = value!;
                      });
                    }),
                const Text(
                  "Validator",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
            DView.spaceHeight(),
            Row(
              children: [
                Checkbox(
                    value: surveyor,
                    onChanged: (value) {
                      setState(() {
                        surveyor = value!;
                      });
                    }),
                const Text(
                  "Surveyor",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
            DView.spaceHeight(),
            Row(
              children: [
                Checkbox(
                    value: verifikator,
                    onChanged: (value) {
                      setState(() {
                        verifikator = value!;
                      });
                    }),
                const Text(
                  "Verifikator",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
            DView.spaceHeight(),
            Row(
              children: [
                Checkbox(
                    value: adjusment,
                    onChanged: (value) {
                      setState(() {
                        adjusment = value!;
                      });
                    }),
                const Text(
                  "Adjusment",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                )
              ],
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
            //Dropdown Desa/Kelurahan
            // DropdownSearch<RefLokasi>(
            //   popupProps: PopupProps.menu(
            //       favoriteItemProps: const FavoriteItemProps(
            //           favoriteItemsAlignment: MainAxisAlignment.center),
            //       showSearchBox: true,
            //       itemBuilder: (context, item, isSelected) {
            //         return ListTile(
            //           selected: isSelected,
            //           title: Text(item.namaUnit.toString()),
            //         );
            //       }),
            //   onChanged: (value) {
            //     kdKelurahan = value?.kodeUnit;
            //   },
            //   dropdownBuilder: (context, selectedItem) =>
            //       Text(selectedItem?.namaUnit ?? "Pilih Keurahan / Desa"),
            //   asyncItems: (text) async =>
            //       await getUnit("ref_kel", ""),
            // ),

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
