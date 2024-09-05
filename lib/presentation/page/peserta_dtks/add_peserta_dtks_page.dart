import 'package:d_info/d_info.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../config/api.dart';
import '../../../data/model/list_kata.dart';
import '../../../data/model/peserta _dtks.dart';
import '../../../data/model/ref_lokasi.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../data/source/source_peserta_dtks.dart';
import '../../controller/c_user.dart';

class AddPesertDtks extends StatefulWidget {
  // const AddPesertDtks({Key? key}) : super(key: key);
  const AddPesertDtks({Key? key, this.peserta}) : super(key: key);
  // final PesertaDtks? peserta;
  final ListKata? peserta;

  @override
  State<AddPesertDtks> createState() => _AddPesertDtksState();
}

class _AddPesertDtksState extends State<AddPesertDtks> {
  final formKey = GlobalKey<FormState>();
  final cUser = Get.put(CUser());
  final controllerFilterBiodata = TextEditingController();
  final controllerKata = TextEditingController();
  final controllerKeterangan1 = TextEditingController();
  final controllerKeterangan2 = TextEditingController();
  TextEditingController catatanController = TextEditingController();


  // final _openDropDownProgKey = GlobalKey<DropdownSearchState<String>>();

  String userName = '';
  String sType = '';
  String level = "";

  String? kdTahun = '0';
  String? kdBulan = '0';
  String? kdTahap = '0';
  String? kdBatch = '0';
  String? kdGelombang = '0';
  String? kdBansos = '0';
  String? kdPmks ;  
  String? kdDataPesertaDtks;

  String? selectedItem;
  String? hSelectedItem;
  String? selectedJenisKelamin;

  //Pencatatan
  String? valueText;
  String? codeDialog;

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

  Future getPesertaDtks(tableName, kode) async {
    level = "level";
    var kdKelurahan = cUser.data.idApotek;
    String url =
        '${Api.location}/getDtks.php?tableName=$tableName&level=$level&kodeParent=$kode&kdKelurahan=$kdKelurahan';
    var response = await http.get(Uri.parse(url));
    if (response.statusCode != 200) {
      return [];
    }
    List allPesertaDtks =
        (json.decode(response.body) as Map<String, dynamic>)["value"];
    List<PesertaDtks> allModelPesertaDtks = [];
    allPesertaDtks.forEach((element) {
      allModelPesertaDtks.add(PesertaDtks(
          idt: element["nik"],
          kodeRT: element["nama"],
          bulan: element["alamatDomisili"]));
    });
    return allModelPesertaDtks;
  }

  add() async {
    if (formKey.currentState!.validate()) {
      
      // if (kdDataPesertaDtks == null) {
      //   DInfo.dialogError(context, "Data Penerima DTKS belum dipilih");
      //   DInfo.closeDialog(context,
      //       durationBeforeClose: const Duration(seconds: 2));
      //   return false;
      // }

      if (controllerKata.text == '') {
        DInfo.dialogError(context, "wordMustfilledIn".tr);
        DInfo.closeDialog(context,
            durationBeforeClose: const Duration(seconds: 2));
        return false;
      }

      if (controllerKeterangan1.text == '') {
        DInfo.dialogError(context, "descriptionMustfilledIn".tr);
        DInfo.closeDialog(context,
            durationBeforeClose: const Duration(seconds: 2));
        return false;
      }

      if (controllerKeterangan2.text == '') {
        DInfo.dialogError(context, "descriptionAdditionalMustfilledIn".tr);
        DInfo.closeDialog(context,
            durationBeforeClose: const Duration(seconds: 2));
        return false;
      }

       
      // DMethod.printTitle('NIK : ', kdDataPesertaDtks!);
      // DMethod.printTitle('TAHUN : ', kdTahun!);
      // DMethod.printTitle('BULAN : ', kdBulan!);
      // DMethod.printTitle('KODE BANSOS : ', kdBansos!);

      bool? yes = await DInfo.dialogConfirmation(
          context, 'addWords'.tr, 'confirmYes'.tr);
      if (yes != null) {
        bool success = await SourcePesertaDtks.addKata(
            controllerKata.text , 
            controllerKeterangan1.text ,
            controllerKeterangan2.text ,           
            );
        if (success) {
          DInfo.dialogSuccess(context, 'successAddWord'.tr);
          DInfo.closeDialog(
            context,
            actionAfterClose: () => Get.back(result: true),
            //actionAfterClose: () => PesertDtks(kriteria: 'surveyor', nikSurveyor: cUser.data.nik, kdkelurahan: cUser.data.kdUnit),
          );         
          // Get.snackbar('Info', 'Berhasil menambahkan data',snackPosition:SnackPosition.BOTTOM );
        } else {
          DInfo.dialogError(context, 'failedAddWord'.tr);
          DInfo.closeDialog(context,);
        }
      }
    }
  }

  updateKata() async {

    if (controllerKata.text == '') {
        DInfo.dialogError(context, "wordMustfilledIn".tr);
        DInfo.closeDialog(context,
            durationBeforeClose: const Duration(seconds: 2));
        return false;
    }

    if (controllerKeterangan1.text == '') {
        DInfo.dialogError(context, "descriptionMustfilledIn".tr);
        DInfo.closeDialog(context,
            durationBeforeClose: const Duration(seconds: 2));
        return false;
    }

    if (controllerKeterangan2.text == '') {
        DInfo.dialogError(context, "descriptionAdditionalMustfilledIn".tr);
        DInfo.closeDialog(context,
            durationBeforeClose: const Duration(seconds: 2));
        return false;
    }

    bool? yes = await DInfo.dialogConfirmation(
        context, 'updateWords'.tr, 'updateWords'.tr);
    if (yes != null) {
      bool success = await SourcePesertaDtks.updateKata(
        widget.peserta!.id.toString(),
        controllerKata.text , 
        controllerKeterangan1.text ,
        controllerKeterangan2.text ,  
      );
      if (success) {
        DInfo.dialogSuccess(context, 'successUpdateWord'.tr);
        DInfo.closeDialog(context, actionAfterClose: () {
          Get.back(result: true);
        });
      } else {
        DInfo.dialogError(context, 'failedUpdateWord'.tr);
        DInfo.closeDialog(
          context,
        );
      }
    }
  }

  updateCatatanDtks(String kdDataPesertaDtks,inputData,pencatat) async {          
        
        bool success = await SourcePesertaDtks.updateCatatan(kdDataPesertaDtks,inputData,cUser.data.nama);

        if (success) {            
              Get.snackbar("Info", "Berhasil input catatan", 
               icon: const Icon(Icons.person, color: Colors.white), 
               snackPosition: SnackPosition.BOTTOM,    
               backgroundColor: Colors.blue  ,  
               colorText:      Colors.white 
               ); 
               Navigator.pop(context);
         } else {              
              Get.snackbar("Perhatian", "Gagal input data", 
               icon: const Icon(Icons.person, color: Colors.red), 
               snackPosition: SnackPosition.BOTTOM,                  
               ); 
               Navigator.pop(context);
         }      
      }

  Future<void> openDialogCatatanDtks(BuildContext context, header, nik) async {
      
      return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title:  Text('$header'),
            content: TextField(
              keyboardType: TextInputType.text,
              maxLines: 10, //or null
              onChanged: (value) {
                setState(() {
                  valueText = value;
                });
              },
              controller:catatanController ,
              decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      width: 3, color: Colors.black12), 
                ),
              ),
            ),
            actions: <Widget>[
              MaterialButton(
                color: Colors.red,
                textColor: Colors.white,
                child: const Text('Batal'),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
              ),
              MaterialButton(
                color: Colors.green,
                textColor: Colors.white,
                child: const Text('OK'),
                onPressed: () {                 
                    if (catatanController.text.isEmpty) {                    
                      DInfo.dialogError(context, "Mohon di isi.");
                      DInfo.closeDialog(context);
                    } else {                      
                      updateCatatanDtks(nik!,catatanController.text,"pencatat");
                    }

                  setState(() {
                    codeDialog = valueText;
                    // Navigator.pop(context);
                  });
                },
              ),
            ],
          );
        });
    }
  @override
  void initState() {
    if (widget.peserta != null) {
      controllerKata.text = widget.peserta!.kata!;
      controllerKeterangan1.text = widget.peserta!.keterangan!;
      controllerKeterangan2.text = widget.peserta!.keterangan2!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DView.appBarLeft(
        widget.peserta == null ?  'addWords'.tr : 'updateWords'.tr
        
        ),
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
           
            //Input Search to filter DTKS
            DView.spaceHeight(),
            input(controllerKata, TextInputType.text,
                Icons.find_in_page_outlined, 'insertWord'.tr),

            DView.spaceHeight(),
            input(controllerKeterangan1, TextInputType.text,
                Icons.find_in_page_outlined, 'cueDescription'.tr),
            const SizedBox(
              height: 10,
            ),

            DView.spaceHeight(),
            input(controllerKeterangan2, TextInputType.text,
                Icons.find_in_page_outlined, 'additionalInformation'.tr),
            //ComboBox Penerima bantuan / DTKS
            DView.spaceHeight(),

            DView.spaceHeight(),
            ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  if (widget.peserta == null) {
                    add();
                  } else {
                    updateKata();
                  }
                }
              },
              child: Text(
                  widget.peserta == null ? 'addWords'.tr : 'updateWords'.tr),
            ),

            DView.spaceHeight(),
            DView.spaceHeight(),
            DView.spaceHeight(),
            // Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceAround,
            //     children: [                  
            //       //Menu Pencatatan
            //       Container(
            //         height: 100,
            //         width:  80,
            //         decoration: BoxDecoration(
            //           color: Color.fromARGB(255, 35, 41, 77),
            //           borderRadius: const BorderRadius.all(
            //             Radius.circular(15),
            //           ),
            //           boxShadow: [
            //             BoxShadow(
            //               color: const Color(0xFF1C1C1C).withOpacity(0.2),
            //               spreadRadius: 3,
            //               blurRadius: 4,
            //               offset: const Offset(0, 3),
            //             ),
            //           ],
            //         ),
                    
            //         child: Center(                     
            //             child: GestureDetector(
            //               onTap: () {
            //                 if(kdDataPesertaDtks==null){
            //                   DInfo.dialogError(context, "Silahkan pilih DTKS");
            //                   DInfo.closeDialog(context);
            //                 }else{
            //                   openDialogCatatanDtks(context,  "Isi Catatan", kdDataPesertaDtks);
            //                 }
                            
            //                 },
            //               child:  const Column(
            //                 children: [
            //                    Icon(
            //                     Icons.note_alt,
            //                     color: Colors.white,
            //                     size: 60.0,
            //                     ),
            //                   Text("Catatan",
            //                       style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,
            //                   color: Colors.white,
            //             ),
            //           ),
            //                 ],
            //               ),
            //         )),
            //       ),                  
            //     ],
            //   ),


            
          ],
        ),
      ),
    );
  }

  Widget input(
    TextEditingController formBantuanController,
    TextInputType inputType,
    IconData icon,
    String hint, [
    bool obsecure = false,
  ]) {
    return TextField(
      keyboardType: inputType,
      controller: formBantuanController,
      decoration: InputDecoration(
        //fillColor: Colors.yellow,
        // filled: true,
        border: OutlineInputBorder(
          // borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(6),
        ),
        prefixIcon: Icon(icon, color: Colors.black12),
        hintText: hint,
      ),
      obscureText: obsecure,
    );
  }
}
