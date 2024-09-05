import 'package:custom_radio_group_list/custom_radio_group_list.dart';
import 'package:d_info/d_info.dart';
import 'package:d_input/d_input.dart';
import 'package:d_view/d_view.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../config/api.dart';
import '../../../data/model/peserta.dart';
import '../../../data/model/ref_lokasi.dart';
import '../../../data/source/source_peserta.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddPesertaPage extends StatefulWidget {
  // const AddPesertaPage({Key? key}) : super(key: key);
  const AddPesertaPage({Key? key, this.peserta}) : super(key: key);
  final Peserta? peserta;

  @override
  State<AddPesertaPage> createState() => _AddPesertaPageState();
}

class _AddPesertaPageState extends State<AddPesertaPage> {
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
  final controllerRw = TextEditingController();
  final controllerRt = TextEditingController();
  final controllerAgama = TextEditingController();
  final controllerStatusKawin = TextEditingController();
  final controllerPekerjaan = TextEditingController();
  final controllerKewarganegaraan = TextEditingController();
  final controllerSearch = TextEditingController();
  TextEditingController dateinput = TextEditingController(); 



  final _openDropDownProgKey = GlobalKey<DropdownSearchState<String>>();

  String? kdPropinsi;
  String? kdKabupaten;
  String? kdKecamatan;
  String? kdKelurahan;
  String? nmKelurahan;
  String? kdRw;
  String? kdRt;  
  String? kdAgama;
  String? kdStatusKawin;
  String? kdPekerjaan;
  String? kdKewarganegaraan;
  String userName = '';
  String sType = '';
  String level = "";

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
      if (kdPropinsi == null) {
        DInfo.dialogError(context, "Data Propinsi masih kosong");
        DInfo.closeDialog(context,
            durationBeforeClose: const Duration(seconds: 5));
        return false;
      }
      if (kdKabupaten == null) {
        DInfo.dialogError(context, "Data Kabupaten masih kosong");
        DInfo.closeDialog(context,
            durationBeforeClose: const Duration(seconds: 5));
        return false;
      }
      if (kdKecamatan == null) {
        DInfo.dialogError(context, "Data Kecamatan masih kosong");
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
      if (kdRw == null) {
        DInfo.dialogError(context, "Data RW masih kosong");
        DInfo.closeDialog(context,
            durationBeforeClose: const Duration(seconds: 5));
        return false;
      }
      if (kdRt == null) {
        DInfo.dialogError(context, "Data RT masih kosong");
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
          kdPropinsi!,
          kdKabupaten!,
          kdKecamatan!,
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

  updatePeserta() async {
    bool? yes = await DInfo.dialogConfirmation(
        context, 'Update Peserta', 'Update Peserta ?');
    if (yes != null) {
      bool success = await SourcePeserta.update(
          widget.peserta!.nik!, // as old nik
          Peserta(
            nik: controllerNik.text, // as new nik
            nokk: controllerNoKK.text,
            nama: controllerNama.text,
            tempatLahir: controllerTempatLahir.text,
            tanggalLahir: controllerTanggalLahir.text,
            jenisKelamin: selectedJenisKelamin,
            alamatKtp: controllerAlamat.text,
            rtrwKtp: controllerRtRw.text,
            provinsiKtp: kdPropinsi,
            kabupatenKtp: kdKabupaten,
            kecamatanKtp: kdKecamatan,
            kelurahanKtp: kdKelurahan,
            agama: kdAgama,
            stakaw: kdStatusKawin,
            pekerjaan: kdPekerjaan,
            kewarganegaraan: kdKewarganegaraan,
          ));
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

  // showInputDate() async {
  //   final controller = TextEditingController();
  //   bool? dateExist = await Get.dialog(
  //     AlertDialog(
  //       title: const Text('Pick Date Before Delete'),
  //       content: Column(
  //         mainAxisSize: MainAxisSize.min,
  //         children: [
  //           ElevatedButton(
  //             onPressed: () async {
  //               DateTime? result = await showDatePicker(
  //                 context: context,
  //                 initialDate: DateTime.now(),
  //                 firstDate: DateTime(2000),
  //                 lastDate: DateTime(DateTime.now().year + 1),
  //               );
  //               if (result != null) {
  //                 controller.text = result.toIso8601String();
  //               }
  //             },
  //             child: const Text('Pick Date'),
  //           ),
  //           DView.spaceHeight(8),
  //           TextField(
  //             controller: controller,
  //             enabled: false,
  //             decoration: const InputDecoration(hintText: 'Date'),
  //           ),
  //         ],
  //       ),
  //       actions: [
  //         TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
  //         TextButton(
  //           onPressed: () {
  //             if (controller.text == '') {
  //               DInfo.toastError('Input cannot be null');
  //             } else {
  //               Get.back(result: true);
  //             }
  //           },
  //           child: const Text('Delete'),
  //         ),
  //       ],
  //     ),
  //     barrierDismissible: false,
  //   );
  //   // if (dateExist ?? false) {
  //   //   delete(controller.text);
  //   // }
  // }
 
  @override
  void initState() {
    selectedJenisKelamin = stringListJenisKelamin.first;
   
    if (widget.peserta != null) {
      controllerNik.text = widget.peserta!.nik!;
      controllerNoKK.text = widget.peserta!.nokk!;
      controllerNama.text = widget.peserta!.nama!;
      controllerTempatLahir.text = widget.peserta!.tempatLahir!;
      controllerTanggalLahir.text = widget.peserta!.tanggalLahir!;
      controllerJenisKelamin.text = widget.peserta!.jenisKelamin!;
      controllerAlamat.text = widget.peserta!.alamatKtp!;
      controllerRtRw.text = widget.peserta!.rtrwKtp!;
      controllerProvinsi.text = widget.peserta!.provinsiKtp!;
      controllerKabupaten.text = widget.peserta!.kabupatenKtp!;
      controllerKecamatan.text = widget.peserta!.kecamatanKtp!;
      controllerDesa.text = widget.peserta!.kelurahanKtp!;
      controllerRw.text = widget.peserta!.kodeRW!;
      controllerRt.text = widget.peserta!.kodeRT!;
      controllerAgama.text = widget.peserta!.agama!;
      controllerStatusKawin.text = widget.peserta!.stakaw!;
      controllerPekerjaan.text = widget.peserta!.pekerjaan!;
      controllerKewarganegaraan.text = widget.peserta!.kewarganegaraan!;

      print(widget.peserta!.tempatLahir!);

       _openDropDownProgKey.currentState?.changeSelectedItem(widget.peserta!.stakaw!);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DView.appBarLeft('Tambah Peserta'),
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            //NIK
            
            DInput(
              controller: controllerNik,
              hint: 'Isi NIK 16 digit',
              title: 'NIK',
              validator: (value) => value == '' ? "Silahkan di isi" : null,
              isRequired: true,
              inputType: TextInputType.number,
            ),
            DView.spaceHeight(),
            //KK
            DInput(
              controller: controllerNoKK,
              hint: 'Isi No.KK 16 digit',
              title: 'Nomor KK',
              validator: (value) => value == '' ? "Silahkan di isi" : null,
              isRequired: true,
              inputType: TextInputType.number,
            ),
            //Nama
            DView.spaceHeight(),
            DInput(
              controller: controllerNama,
              hint: 'Nama',
              title: 'Nama Lengkap',
              validator: (value) => value == '' ? "Silahkan di isi." : null,
              isRequired: true,
            ),
            //Tempat lahir
            DView.spaceHeight(),
            DInput(
              controller: controllerTempatLahir,
              hint: 'Tempat Lahir',
              title: 'Tempat Lahir',
              validator: (value) => value == '' ? "Silahkan di isi." : null,
              isRequired: true,
            ),

            //Tanggal lahir
            DView.spaceHeight(),

            // search(),
            TextField(
                controller: controllerTanggalLahir, 
                decoration: const InputDecoration( 
                  //  icon: Icon(Icons.calendar_today), //icon of text field
                   labelText: "Tanggal Lahir" ,
                    // hintText: 'Enter your name',
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.grey),
                      // borderRadius: BorderRadius.circular(10),
                    )
                ),
                readOnly: true,  //set it true, so that user will not able to edit text
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context, initialDate: DateTime.now(),
                      firstDate: DateTime(1950), //DateTime.now() - not to allow to choose before today.
                      lastDate: DateTime(2101)
                  );
                  
                  if(pickedDate != null ){
                      // print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
                      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate); 
                      // print(formattedDate); //formatted date output using intl package =>  2021-03-16
                        //you can implement different kind of Date Format here according to your requirement

                      setState(() {
                         controllerTanggalLahir.text = formattedDate; //set output date to TextField value. 
                      });
                  }else{
                      // print("Date is not selected");
                  }
                },
             )
          
          ,
            // DInput(
            //   controller: controllerTanggalLahir,
            //   title: 'Tanggal Lahir',
            //   validator: (value) => value == '' ? "Silahkan di isi." : null,
            //   // isRequired: true,
            //   inputType: TextInputType.datetime,
            // ),
            //Radiobutton Jenis Kelamin
            DView.spaceHeight(),
            const Text(
              'Jenis Kelamin ',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 30,
              child: RadioGroup(
                  items: stringListJenisKelamin,
                  selectedItem: selectedJenisKelamin,
                  scrollDirection: Axis.horizontal,
                  onChanged: (value) {
                    selectedJenisKelamin = value;
                    final snackBar = SnackBar(content: Text("$value"));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  },
                  labelBuilder: (ctx, index) {
                    return Row(
                      children: [
                        // Text(
                        //   'Id : ${sampleList[index].id}',
                        //   style: const TextStyle(color: Colors.red),
                        // ),
                        // const SizedBox(
                        //   width: 10,
                        // ),
                        Text(
                          // sampleList[index].title,
                          stringListJenisKelamin[index],
                        ),
                      ],
                    );
                  },
                  shrinkWrap: true,
                  disabled: false),
            ),

            //Alamat
            DView.spaceHeight(),
            DInput(
              controller: controllerAlamat,
              hint: 'Alamat ',
              title: 'Alamat (KTP)',
              validator: (value) => value == '' ? "Silahkan di isi." : null,
              isRequired: true,
            ),
            //RT RW
            DView.spaceHeight(),
            DInput(
              controller: controllerRtRw,
              hint: 'RT / RW',
              title: 'RT / RW',
              validator: (value) => value == '' ? "Silahkan di isi." : null,
              isRequired: true,
            ),
            //ComboBox Propinsi
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
                kdPropinsi = value?.kodeUnit;
                //DMethod.printTitle('KODE Propinsi : ', kdPropinsi.toString());
                sType = '1';
              },
              dropdownBuilder: (context, selectedItem) =>
                  Text(selectedItem?.namaUnit ?? "Pilih Propinsi"),
              asyncItems: (text) async => await getUnit("ref_pro", "62"),
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
              asyncItems: (text) async => await getUnit("ref_kab", kdPropinsi),
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
              asyncItems: (text) async => await getUnit("ref_kec", kdKabupaten),
            ),

            //CB Kelurahan/Desa
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
                kdKelurahan = value?.kodeUnit;
                nmKelurahan = value?.namaUnit;
                sType = '4';
              },
              dropdownBuilder: (context, selectedItem) =>
                  Text(selectedItem?.namaUnit ?? "Pilih Kelurahan"),
              asyncItems: (text) async => await getUnit("ref_kel", kdKecamatan),
            ),

            //CB RW
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
                kdRw = value?.kodeUnit;
                sType = '5';
              },
              dropdownBuilder: (context, selectedItem) =>
                  Text(selectedItem?.namaUnit ?? "Pilih RW"),
              asyncItems: (text) async => await getUnit("ref_rw", kdKelurahan),
            ),

            //CB RT
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
                kdRt = value?.kodeUnit;
                sType = '6';
              },
              dropdownBuilder: (context, selectedItem) =>
                  Text(selectedItem?.namaUnit ?? "Pilih RT"),
              asyncItems: (text) async => await getUnit("ref_rt", kdRw),
            ),

            //Agama
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
                kdAgama = value?.kodeUnit;
                sType = '5';
              },
              dropdownBuilder: (context, selectedItem) =>
                  Text(selectedItem?.namaUnit ?? "Pilih Agama"),
              asyncItems: (text) async => await getUnit("ref_agama", ''),
            ),

            //Statu Kawin
            // DropdownSearch<int>(
            //     key: _openDropDownProgKey,
            //     items: [1, 2, 3],
            //   ),
            DView.spaceHeight(),
            DropdownSearch<RefLokasi>(
              // key: _openDropDownProgKey,
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
                kdStatusKawin = value?.kodeUnit;
                sType = '6';
              },
              dropdownBuilder: (context, selectedItem) =>
                  Text(selectedItem?.namaUnit ?? "Pilih Status Kawin"),
              asyncItems: (text) async => await getUnit("ref_status_kawin", ''),
            ),

            //Pekerjaan
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
                kdPekerjaan = value?.kodeUnit;
                sType = '7';
              },
              dropdownBuilder: (context, selectedItem) =>
                  Text(selectedItem?.namaUnit ?? "Pilih Pekerjaan"),
              asyncItems: (text) async => await getUnit("ref_pekerjaan", ''),
            ),

            //Kewarganegaraan
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
                kdKewarganegaraan = value?.kodeUnit;
                sType = '8';
              },
              dropdownBuilder: (context, selectedItem) =>
                  Text(selectedItem?.namaUnit ?? "Pilih Kewarganegaraan"),
              asyncItems: (text) async => await getUnit("ref_negara", ''),
            ),

            //  ElevatedButton(
            //     onPressed: () {
            //       _openDropDownProgKey.currentState?.changeSelectedItem("100");
            //     },
            //     child: const Text('set to 100'),
            //   ),
            DView.spaceHeight(),
            ElevatedButton(
              // onPressed: () => add(),
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  if (widget.peserta == null) {
                    add();
                  } else {
                    updatePeserta();
                  }
                }
              },
              child: Text(
                  widget.peserta == null ? 'Tambah peserta' : 'Update Peserta'),
            ),
          ],
        ),
      ),
    );
  }

  // Expanded search() {
  //   return Expanded(
  //     child: Container(
  //       height: 70,
  //       padding: const EdgeInsets.all(16),
  //       child: TextField(
  //         controller: controllerSearch,
  //         onTap: () async {
  //           DateTime? result = await showDatePicker(
  //             context: context,
  //             initialDate: DateTime.now(),
  //             firstDate: DateTime(2000),
  //             lastDate: DateTime(
  //               DateTime.now().year,
  //               DateTime.now()
  //                   .add(const Duration(days: 30))
  //                   .month, // next Month
  //             ),
  //           );
  //           if (result != null) {
  //             controllerSearch.text = DateFormat('yyyy-MM-dd').format(result);
  //           }
  //         },
  //         decoration: InputDecoration(
  //           border: OutlineInputBorder(
  //             borderSide: BorderSide.
  //             //borderRadius: BorderRadius.circular(80),
  //           ),
  //           contentPadding: const EdgeInsets.symmetric(horizontal: 16),
  //           isDense: true,
  //           filled: true,
  //           // fillColor: AppColor.input,
  //           hintText: 'Tanggal Lahir',
  //           suffixIcon: IconButton(
  //             onPressed: () {
  //               if (controllerSearch.text != '') {
  //                 //cHistory.search(controllerSearch.text);
  //               }
  //             },
  //             icon: const Icon(Icons.search, color: Colors.white),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
