import 'package:d_info/d_info.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/model/list_kata.dart';
// import '../../../data/model/peserta _dtks.dart';
// import '../../../data/source/source_peserta_dtks.dart';
import '../../../data/source/source_kata.dart';
import '../../controller/c_user.dart';

class AddkataPage extends StatefulWidget {
  // const AddkataPage({Key? key}) : super(key: key);
  const AddkataPage({Key? key, this.peserta}) : super(key: key);
  // final PesertaDtks? peserta;
  final ListKata? peserta;

  @override
  State<AddkataPage> createState() => _AddkataPageState();
}

class _AddkataPageState extends State<AddkataPage> {
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
  String? kdPmks;
  String? kdDataPesertaDtks;

  String? selectedItem;
  String? hSelectedItem;
  String? selectedJenisKelamin;

  //Pencatatan
  String? valueText;
  String? codeDialog;

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
        bool success = await SourceKata.addKata(
          controllerKata.text,
          controllerKeterangan1.text,
          controllerKeterangan2.text,
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
          DInfo.closeDialog(
            context,
          );
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
      bool success = await SourceKata.updateKata(
        widget.peserta!.id.toString(),
        controllerKata.text,
        controllerKeterangan1.text,
        controllerKeterangan2.text,
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
          widget.peserta == null ? 'addWords'.tr : 'updateWords'.tr),
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
