import 'dart:convert';
import 'package:d_info/d_info.dart';
import 'package:d_input/d_input.dart';
import 'package:d_method/d_method.dart';
import 'package:d_view/d_view.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import '../config/api.dart';
import '../data/model/peserta _dtks.dart';
import '../data/model/ref_lokasi.dart';

class FindDtksPage extends StatefulWidget {
  const FindDtksPage({Key? key}) : super(key: key);

  @override
  State<FindDtksPage> createState() => _FindDtksPageState();
}

class _FindDtksPageState extends State<FindDtksPage> {
  final controllerNik = TextEditingController();
  final formKey = GlobalKey<FormState>();

  String sType = '';
  String level = '';
  String? kdTahun;
  String? kdBulan;
  PesertaDtks? pesertaDtks;
  PesertaDtks? pesertaDtks2;
  List record = [];

  Future getUnit(tableName, kode) async {
    level = "level";
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

  checkDtks() async {
    if (formKey.currentState!.validate()) {
      if (kdTahun == null) {
        DInfo.dialogError(context, "Data Tahun belum dipilih");
        DInfo.closeDialog(context,
            durationBeforeClose: const Duration(seconds: 3));
        return false;
      }

      if (kdBulan == null) {
        DInfo.dialogError(context, "Data Bulan belum dipilih");
        DInfo.closeDialog(context,
            durationBeforeClose: const Duration(seconds: 3));
        return false;
      }

      const CircularProgressIndicator();
      // DMethod.printTitle('CEK KEDUA:  ', 'CEK : $BASE_URL/checkViewkib.php');
      String url = '${Api.pesertaDtks}/checkDtks.php';
      var response = await post(Uri.parse(url),
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/x-www-form-urlencoded"
          },
          body: {
            "nik": controllerNik.text,
            "tahun": kdTahun,
            "bulan": kdBulan,
          },
          encoding: Encoding.getByName("utf-8"));

      var data = json.decode(response.body);
      // isLoading.value = false;
      if (data["message"] == "Success") {
        // Get.to(DetailPage(index: 1, code: kode));
        DMethod.printTitle('CEK VALUE:  ', data["value"].toString());
        //pesertaDtks = jsonDecode(data["value"]);
        //pesertaDtks2 = PesertaDtks.fromJson(jsonDecode(data["value"]));
        //record = jsonDecode(data["value"]);
        var nama = data["value"]["nama"];
        var status = data["value"]["status"];
        var jenisBantuanPKH = data["value"]["PKH"];
        var jenisBantuanBPNT = data["value"]["BPNT"];
        var jenisBantuanPBI = data["value"]["PBI"];
        var jenisBantuanFIS = data["value"]["FIS"];
        var jenisBantuanPMK = data["value"]["PMK"];
        var jenisBantuanSND = data["value"]["SND"];
        var jenisBantuanALB = data["value"]["ALB"];
        var jenisBantuanPES = data["value"]["PES"];
        //  setState(() {
        //     pesertaDtks = PesertaDtks.fromJson(jsonDecode(response.body));
        //   });
        var jenisBantuan = '';
        jenisBantuanPKH == 'YA' ? jenisBantuan = jenisBantuan + 'PKH' : '';
        jenisBantuanBPNT == 'YA' ? jenisBantuan = jenisBantuan + '-BPNT' : '';
        jenisBantuanPBI == 'YA' ? jenisBantuan = jenisBantuan + '-PBI' : '';
        jenisBantuanFIS == 'YA' ? jenisBantuan = jenisBantuan + '-FIS' : '';
        jenisBantuanPMK == 'YA' ? jenisBantuan = jenisBantuan + '-PMK' : '';
        jenisBantuanSND == 'YA' ? jenisBantuan = jenisBantuan + '-SND' : '';
        jenisBantuanALB == 'YA' ? jenisBantuan = jenisBantuan + '-ALB' : '';
        jenisBantuanPES == 'YA' ? jenisBantuan = jenisBantuan + '-PES' : '';
        _displayDialog(context, nama, jenisBantuan, status);
      } else {
        // Get.offAll(Formkiblite(kode));
        //DMethod.printTitle('CEK NIK:  ', data["message"] );
        _displayDialog(context, '-', '-', '-');
      }
    }
  }

  Future<void> _displayDialog(BuildContext context, String nama,
      String jenisBantuan, String status) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Data Peserta DTKS'),
            content: Text(nama != '-'
                ? 'Nama : $nama\nJenis Bantuan : $jenisBantuan\nStatus : $status'
                : 'Data tidak ditemukan.'),
            actions: <Widget>[
              MaterialButton(
                color: Colors.green,
                textColor: Colors.white,
                child: const Text('OK'),
                onPressed: () {
                  // insertMessage(userName!, mController.text);
                  setState(() {
                    // codeDialog = valueText;
                    Navigator.pop(context);
                  });
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DView.appBarLeft('Cari peserta DTKS'),
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            DInput(
              title: 'NIK',
              controller: controllerNik,
              validator: (value) => value == '' ? "Don't empty" : null,
              inputType: TextInputType.number,
            ),

            DView.spaceHeight(),
            DropdownSearch<RefLokasi>(
              popupProps: PopupProps.menu(
                  // showSelectedItems: true,
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
                kdTahun = value?.kodeUnit;
                sType = '1';
              },
              dropdownBuilder: (context, selectedItem) =>
                  Text(selectedItem?.namaUnit ?? "Pilih tahun"),
              asyncItems: (text) async => await getUnit("ref_tahun", ""),
            ),
            //ComboBox Bulan
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
                kdBulan = value?.kodeUnit;
                sType = '2';
              },
              dropdownBuilder: (context, selectedItem) =>
                  Text(selectedItem?.namaUnit ?? "Pilih Bulan  "),
              asyncItems: (text) async => await getUnit("ref_bulan", ""),
            ),

            DView.spaceHeight(),
            ElevatedButton(
              onPressed: () => checkDtks(),
              child: const Text('C e k',
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
