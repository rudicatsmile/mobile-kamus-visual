// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:d_info/d_info.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import '../../../config/api.dart';
import '../../../data/model/dtks_images.dart';
import '../../../data/model/list_kata.dart';
import '../../../data/source/source_peserta_dtks.dart';
import '../../controller/c_perserta_dtks.dart';
import '../../controller/c_user.dart';
import 'add_peserta_dtks_page.dart';
// import 'package:intl/intl.dart';
// import '../../../config/app_color.dart';
// import '../../../data/model/peserta _dtks.dart';
// import 'pengajuan_dtks_peserta_page.dart';
import 'upload_images.dart';
import 'upload_photo.dart';

class PesertDtks extends StatefulWidget {
  // final String kriteria;
  // const PesertDtks(this.kriteria, {key}) : super(key: key);

  final String kriteria;
  final String? nikSurveyor;
  final String? kdkelurahan;
  const PesertDtks({
    Key? key,
    required this.kriteria,
    required this.nikSurveyor,
    required this.kdkelurahan,
  }) : super(key: key);

  @override
  State<PesertDtks> createState() => _PesertDtksState();
}

class _PesertDtksState extends State<PesertDtks> {
  final cPesertaDtks = Get.put(CPesertaDtks());
  final cUser = Get.put(CUser());
  // final cCaleg = Get.put(CCaleg());

  final controllerSearch = TextEditingController();
  final catatanController = TextEditingController();

  String? valueText;
  String? codeDialog;
  // String? _selection;

  delete(String idPeserta, String tableName, String tahun, String bulan,
      String mode) async {
    bool? yes = await DInfo.dialogConfirmation(
        context, 'Hapus data?', 'Ya Untuk Konfirmasi');
    // if (yes != null) {
    if (yes == true) {
      bool success = await SourcePesertaDtks.delete(idPeserta, tableName);
      if (success) {
        DInfo.dialogSuccess(context, 'Sukses hapus data');
        DInfo.closeDialog(
          context,
          // actionAfterClose: () => cPesertaDtks.setList(),
          //1*
          actionAfterClose: () => tableName == 'ta_dtks'
              ? cPesertaDtks.setListKata(cUser.data.userId, cUser.data.idApotek)
              : cPesertaDtks.setListImage(
                  cUser.data.userId, tahun, bulan, mode),
        );
      } else {
        DInfo.dialogError(context, 'gagal hapus data');
        DInfo.closeDialog(
          context,
        );
      }
    }
  }

  openImages(String nik, String kata, String keterangan, String mode) {
    Get.dialog(
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Material(
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      Text(
                        "Kata : ${kata.capitalizeFirst}",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 15),

                      Obx(() {
                        cPesertaDtks.setListImage(nik, kata, keterangan, mode);
                        if (cPesertaDtks.listImage.isEmpty) {
                          return DView.empty("Belum ada data");
                        }

                        return Container(
                          height: 500.0, // Change as per your requirement
                          width: 300.0, //
                          child: ListView.separated(
                            itemCount: cPesertaDtks.listImage.length,
                            separatorBuilder: (context, index) => const Divider(
                              height: 1,
                              indent: 16,
                              endIndent: 16,
                              color: Colors.black,
                            ),
                            itemBuilder: (context, index) {
                              DtksImages dtksImages =
                                  cPesertaDtks.listImage[index];
                              return ListTile(
                                  // leading: Wrap(
                                  //   direction: Axis.vertical,
                                  //   spacing: 0, // space between two icons
                                  //   children: <Widget>[
                                  //     Text("${index + 1}. "),
                                  //     CircleAvatar(
                                  //       radius: 40,
                                  //       backgroundColor: Colors.transparent,
                                  //       child: InstaImageViewer(
                                  //         child: Image(
                                  //             width: 200,
                                  //             height: 140,
                                  //             fit: BoxFit.fill,
                                  //             image: dtksImages.fileName == ''
                                  //                 ? Image.network(
                                  //                         '${Api.imagesKamus}/default.png')
                                  //                     .image
                                  //                 : Image.network(
                                  //                         '${Api.imagesKamus}/${dtksImages.fileName}')
                                  //                     .image),
                                  //         // '${Api.imagesKamus}/${dtksImages.nik}xyz${dtksImages.tahun}xyz${dtksImages.bulan}xyz${dtksImages.fileName}')
                                  //       ),
                                  //     ),
                                  //   ],
                                  // ),
                                  // title: Text(
                                  //     DateFormat('dd MMMM yyyy  HH:mm:ss')
                                  //         .format(DateTime.parse(
                                  //             dtksImages.recorded!))),
                                  title: CircleAvatar(
                                    radius: 55,
                                    backgroundColor: Colors.transparent,
                                    child: InstaImageViewer(
                                      child: Image(
                                          width: 200,
                                          height: 340,
                                          fit: BoxFit.fill,
                                          image: dtksImages.fileName == ''
                                              ? Image.network(
                                                      '${Api.imagesKamus}/default.png')
                                                  .image
                                              : Image.network(
                                                      '${Api.imagesKamus}/${dtksImages.fileName}')
                                                  .image),
                                      // '${Api.imagesKamus}/${dtksImages.nik}xyz${dtksImages.tahun}xyz${dtksImages.bulan}xyz${dtksImages.fileName}')
                                    ),
                                  ),
                                  // titleTextStyle: const TextStyle(fontSize: 10),
                                  subtitle: Text("${dtksImages.title}",
                                      style:
                                          const TextStyle(color: Colors.black)),
                                  subtitleTextStyle:
                                      const TextStyle(fontSize: 12),
                                  //=====Trailing==========
                                  trailing: PopupMenuButton<String>(
                                    onSelected: (value) {
                                      if (value == 'delete') {
                                        // Get.to(() => PengajuanPesertDtks(pesertaDtks: pesertaDtks))!
                                        //     .then((value) {
                                        //   if (value ?? false) {
                                        //     cPesertaDtks.setList();
                                        //   }
                                        // });
                                        delete(
                                            dtksImages.idt.toString(),
                                            "ta_dtks_foto",
                                            kata,
                                            keterangan,
                                            mode);
                                      } else if (value == 'update') {}
                                    },
                                    icon: const Icon(Icons.more_vert),
                                    itemBuilder: (context) => [
                                      const PopupMenuItem<String>(
                                        value: 'delete',
                                        child: Text('Delete'),
                                      ),
                                    ],
                                  )

                                  //======Trailing=========

                                  );
                            },
                          ),
                        );
                      }),
                      //==================
                      const SizedBox(height: 10),
                      //Buttons
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(0, 45),
                                backgroundColor:
                                    const Color.fromARGB(184, 242, 242, 245),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: () {
                                // Navigator.pop(context);
                                Get.back();
                              },
                              child: const Text(
                                'Tutup',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  updateCatatanDtks(String kdDataPesertaDtks, inputData, pencatat) async {
    // bool success = await SourcePesertaDtks.updateCatatan(kdDataPesertaDtks,inputData,cUser.data.userId);
    bool success = await SourcePesertaDtks.updateCatatan(
        kdDataPesertaDtks, inputData, 'app_mobile');
    //bool success = await SourcePesertaDtks.retrieveDictionaryText(kdDataPesertaDtks,inputData,cUser.data.userId);

    // //DMethod.printTitle('INSERT retrieveTps : ', '------');
    if (success) {
      Get.snackbar("Info", "Berhasil input catatan",
          icon: const Icon(Icons.person, color: Colors.white),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.blue,
          colorText: Colors.white);
      Navigator.pop(context);
    } else {
      Get.snackbar(
        "Perhatian",
        "Gagal input data",
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
            title: Text('$header'),
            content: TextField(
              keyboardType: TextInputType.text,
              maxLines: 10, //or null
              onChanged: (value) {
                setState(() {
                  valueText = value;
                });
              },
              controller: catatanController,
              decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 3, color: Colors.black12),
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
                    updateCatatanDtks(nik!, catatanController.text, "pencatat");
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

  //1*
  getListAll() {
    // cPesertaDtks.setListKata(widget.nikSurveyor,widget.kdkelurahan);
    cPesertaDtks.setListKata(widget.nikSurveyor, widget.kdkelurahan);
  }

  //1*
  @override
  void initState() {
    getListAll();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //1*
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 80, 53, 233),
        tooltip: 'Refresh data',
        onPressed: () {
          cPesertaDtks.setListKata(widget.nikSurveyor, widget.kdkelurahan);
        },
        child: const Icon(Icons.refresh, color: Colors.white, size: 24),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      appBar: AppBar(
          titleSpacing: 0,
          title:
              //Text(cUser.data.verifikator == 'Y' ? 'Verifikasi Peserta DTKS' : 'Survey Peserta DTKS'),
              Row(
            children: [
              const Text(''),
              search(),
            ],
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Get.to(() => const AddPesertDtks())?.then((value) {
                    if (value ?? false) {
                      // cPesertaDtks.setListKata(cUser.data.userId,cUser.data.idApotek);
                      cPesertaDtks.setListKata('', '');
                    }
                  });
                },
                icon: const Icon(Icons.add)),
          ]
          //}
          // ,
          ),
      body: GetBuilder<CPesertaDtks>(builder: (_) {
        if (cPesertaDtks.loading) return DView.loadingCircle();
        //1*
        if (cPesertaDtks.listKata.isEmpty) return DView.empty();
        return ListView.separated(
          //1*
          itemCount: cPesertaDtks.listKata.length,
          separatorBuilder: (context, index) => const Divider(
            height: 1,
            indent: 16,
            endIndent: 16,
            color: Colors.white70,
          ),
          itemBuilder: (context, index) {
            //1*
            ListKata pesertaDtks = cPesertaDtks.listKata[index];
            return ListTile(
              leading: CircleAvatar(
                radius: 18,
                child: Text('${index + 1}'),
                backgroundColor: pesertaDtks.status == '0'
                    ? Colors.green[400]
                    : Colors.white,
              ),
              title: Text(
                pesertaDtks.kata!.isEmpty
                    ? ''
                    : pesertaDtks.kata!.toUpperCase(),
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text('${pesertaDtks.keterangan}'),
              trailing: PopupMenuButton<String>(
                onSelected: (value) {
                  if (value == 'gambar1') {
                    Get.to(() => UploadImageScreen(
                              pesertaDtks.id.toString(),
                              tahun: pesertaDtks.kata!,
                              bulan: pesertaDtks.keterangan!,
                              tahap: pesertaDtks.keterangan2!,
                              batch: pesertaDtks.kata!,
                              gelombang: pesertaDtks.kata!,
                              mode: 'gambar',
                            ))!
                        .then((value) {
                      if (value ?? false) {
                        cPesertaDtks.setList();
                      }
                    });
                  } else if (value == 'gambar2') {
                    Get.to(() => UploadImageScreen(
                              pesertaDtks.id.toString(),
                              tahun: pesertaDtks.kata!,
                              bulan: pesertaDtks.keterangan!,
                              tahap: pesertaDtks.keterangan2!,
                              batch: pesertaDtks.kata!,
                              gelombang: pesertaDtks.kata!,
                              mode: 'gambar2',
                            ))!
                        .then((value) {
                      if (value ?? false) {
                        cPesertaDtks.setList();
                      }
                    });
                  } else if (value == 'gambar3') {
                    Get.to(() => UploadImageScreen(
                              pesertaDtks.id.toString(),
                              tahun: pesertaDtks.kata!,
                              bulan: pesertaDtks.keterangan!,
                              tahap: pesertaDtks.keterangan2!,
                              batch: pesertaDtks.kata!,
                              gelombang: pesertaDtks.kata!,
                              mode: 'gambar3',
                            ))!
                        .then((value) {
                      if (value ?? false) {
                        cPesertaDtks.setList();
                      }
                    });
                  } else if (value == 'video') {
                    Get.to(() => UploadImageScreen(
                              pesertaDtks.id.toString(),
                              tahun: pesertaDtks.kata!,
                              bulan: pesertaDtks.keterangan!,
                              tahap: pesertaDtks.keterangan2!,
                              batch: pesertaDtks.kata!,
                              gelombang: pesertaDtks.kata!,
                              mode: 'video',
                            ))!
                        .then((value) {
                      if (value ?? false) {
                        cPesertaDtks.setList();
                      }
                    });
                  } else if (value == 'view_images') {
                    openImages(pesertaDtks.id.toString(), pesertaDtks.kata!,
                        pesertaDtks.keterangan!, "surveyor");
                  } else if (value == 'photo_verifikator') {
                    Get.to(() => UploadPhoto(
                              // pesertaDtks.id.toString()!,
                              pesertaDtks.id.toString(),
                              tahun: pesertaDtks.kata!,
                              bulan: pesertaDtks.keterangan!,
                              tahap: pesertaDtks.keterangan2!,
                              batch: pesertaDtks.kata!,
                              gelombang: pesertaDtks.kata!,
                              mode: 'verifikator',
                            ))!
                        .then((value) {
                      if (value ?? false) {
                        cPesertaDtks.setList();
                      }
                    });
                  } else if (value == 'catatan_surveyor') {
                    openDialogCatatanDtks(
                        context, "Isi Catatan", pesertaDtks.id.toString());
                  } else if (value == 'edit') {
                    Get.to(() => AddPesertDtks(peserta: pesertaDtks))!
                        .then((value) {
                      if (value ?? false) cPesertaDtks.setListKata('', '');
                    });

                    // Get.to(() =>  AddPesertDtks(peserta: pesertaDtks))?.then((value) {
                    //       if (value ?? false) {cPesertaDtks.setListKata('','');}
                    //     });
                  } else if (value == 'delete') {
                    //delete(pesertaDtks.id.toString(),"ta_dtks",pesertaDtks.kata!,pesertaDtks.keterangan!,"surveyor");
                  }
                  {
                    //delete(pesertaDtks.idt.toString());
                  }
                },
                icon: const Icon(Icons.more_vert),

                itemBuilder: (context) => [
                  PopupMenuItem(
                      value: 'gambar1', child: Text('uploadSignalImage'.tr)),
                  PopupMenuItem(
                      value: 'gambar2', child: Text('uploadCaptionImage'.tr)),
                  PopupMenuItem(
                      value: 'gambar3',
                      child: Text('uploadAdditionalInformationImages'.tr)),
                  const PopupMenuItem(
                      value: 'video', child: Text('Upload Video')),
                  PopupMenuItem(
                      value: 'view_images', child: Text('seeImages'.tr)),
                  const PopupMenuItem(value: 'edit', child: Text('Edit')),
                  const PopupMenuItem(value: 'delete', child: Text('Delete')),

                  // const PopupMenuItem(value: 'catatan_surveyor', child: Text('Catatan')),
                ],

                // itemBuilder: (context) => [
                //   const PopupMenuItem<String>(
                //     value: 'delete',
                //     child: Text('Delete'),
                //   ),
                // ],
              ),
              // PopupMenuButton<String>(
              //     onSelected: (String value) {
              //     setState(() {
              //         _selection = value;
              //     });
              //   },
              //   child: ListTile(
              //     leading: IconButton(
              //       icon: Icon(Icons.add_alarm),
              //       onPressed: () {
              //         print('Hello world');
              //       },
              //     ),
              //     title: Text('Title'),
              //     subtitle: Column(
              //       children: <Widget>[
              //         Text('Sub title'),
              //         Text(_selection == null ? 'Nothing selected yet' : _selection.toString()),
              //       ],
              //     ),
              //     trailing: Icon(Icons.account_circle),
              //   ),
              //   itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              //         const PopupMenuItem<String>(
              //           value: 'Value1',
              //           child: Text('Choose value 1'),
              //         ),
              //         const PopupMenuItem<String>(
              //           value: 'Value2',
              //           child: Text('Choose value 2'),
              //         ),
              //         const PopupMenuItem<String>(
              //           value: 'Value3',
              //           child: Text('Choose value 3'),
              //         ),
              //       ],
              // )
            );
          },
        );
      }),
    );
  }

  Expanded search() {
    return Expanded(
      child: Container(
        height: 70,
        padding: const EdgeInsets.all(16),
        child: TextField(
          controller: controllerSearch,
          onTap: () {},
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(30),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            isDense: true,
            filled: true,
            // fillColor: AppColor.input,
            hintText: 'findWord'.tr,
            suffixIcon: IconButton(
              onPressed: () {
                if (controllerSearch.text != '') {
                  cPesertaDtks.search(controllerSearch.text);
                }
              },
              icon: const Icon(Icons.search, color: Colors.black),
            ),
          ),
        ),
      ),
    );
  }
}
