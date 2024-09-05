// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:d_info/d_info.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import '../../../config/api.dart';
import '../../../data/model/data_image_kata.dart';
// import '../../../data/model/dtks_images.dart';
import '../../../data/model/list_kata.dart';
// import '../../../data/source/source_peserta_dtks.dart';
import '../../../data/source/source_kata.dart';
// import '../../controller/c_perserta_dtks.dart';
import '../../controller/c_kata.dart';
import '../../controller/c_user.dart';
// import '../peserta_dtks/upload_images.dart';
// import '../peserta_dtks/upload_photo.dart';
import 'add_kata_page.dart';
import 'upload_images_kata.dart';
import 'upload_photo_kata.dart';
// import 'package:intl/intl.dart';
// import '../../../config/app_color.dart';
// import '../../../data/model/peserta _dtks.dart';
// import 'pengajuan_dtks_peserta_page.dart';

class ManageKatapage extends StatefulWidget {
  // final String kriteria;
  // const ManageKatapage(this.kriteria, {key}) : super(key: key);

  final String kriteria;
  final String? nik;
  final String? kdlokasi;
  const ManageKatapage({
    Key? key,
    required this.kriteria,
    required this.nik,
    required this.kdlokasi,
  }) : super(key: key);

  @override
  State<ManageKatapage> createState() => _ManageKatapageState();
}

class _ManageKatapageState extends State<ManageKatapage> {
  final cKamusKata = Get.put(CKata());
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
      bool success = await SourceKata.delete(idPeserta, tableName);
      if (success) {
        DInfo.dialogSuccess(context, 'Sukses hapus data');
        DInfo.closeDialog(
          context,
          // actionAfterClose: () => cKamusKata.setList(),
          //1*
          actionAfterClose: () => tableName == 'ta_dtks'
              ? cKamusKata.setListKata(cUser.data.userId, cUser.data.idApotek)
              : cKamusKata.setListImage(cUser.data.userId, tahun, bulan, mode),
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
                        cKamusKata.setListImage(nik, kata, keterangan, mode);
                        if (cKamusKata.listImage.isEmpty) {
                          return DView.empty("Belum ada data");
                        }

                        return Container(
                          height: 500.0, // Change as per your requirement
                          width: 300.0, //
                          child: ListView.separated(
                            itemCount: cKamusKata.listImage.length,
                            separatorBuilder: (context, index) => const Divider(
                              height: 1,
                              indent: 16,
                              endIndent: 16,
                              color: Colors.black,
                            ),
                            itemBuilder: (context, index) {
                              DataImageKata dataImageKatas =
                                  cKamusKata.listImage[index];
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
                                  //             image: dataImageKatas.fileName == ''
                                  //                 ? Image.network(
                                  //                         '${Api.imagesKamus}/default.png')
                                  //                     .image
                                  //                 : Image.network(
                                  //                         '${Api.imagesKamus}/${dataImageKatas.fileName}')
                                  //                     .image),
                                  //         // '${Api.imagesKamus}/${dataImageKatas.nik}xyz${dataImageKatas.tahun}xyz${dataImageKatas.bulan}xyz${dataImageKatas.fileName}')
                                  //       ),
                                  //     ),
                                  //   ],
                                  // ),
                                  // title: Text(
                                  //     DateFormat('dd MMMM yyyy  HH:mm:ss')
                                  //         .format(DateTime.parse(
                                  //             dataImageKatas.recorded!))),
                                  title: CircleAvatar(
                                    radius: 55,
                                    backgroundColor: Colors.transparent,
                                    child: InstaImageViewer(
                                      child: Image(
                                          width: 200,
                                          height: 340,
                                          fit: BoxFit.fill,
                                          image: dataImageKatas.fileName == ''
                                              ? Image.network(
                                                      '${Api.imagesKamus}/default.png')
                                                  .image
                                              : Image.network(
                                                      '${Api.imagesKamus}/${dataImageKatas.fileName}')
                                                  .image),
                                      // '${Api.imagesKamus}/${dataImageKatas.nik}xyz${dataImageKatas.tahun}xyz${dataImageKatas.bulan}xyz${dataImageKatas.fileName}')
                                    ),
                                  ),
                                  // titleTextStyle: const TextStyle(fontSize: 10),
                                  subtitle: Text("${dataImageKatas.title}",
                                      style:
                                          const TextStyle(color: Colors.black)),
                                  subtitleTextStyle:
                                      const TextStyle(fontSize: 12),
                                  //=====Trailing==========
                                  trailing: PopupMenuButton<String>(
                                    onSelected: (value) {
                                      if (value == 'delete') {
                                        // Get.to(() => PengajuanPesertDtks(dataKamusKata: dataKamusKata))!
                                        //     .then((value) {
                                        //   if (value ?? false) {
                                        //     cKamusKata.setList();
                                        //   }
                                        // });
                                        delete(
                                            dataImageKatas.idt.toString(),
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

  updateCatatanDtks(String kdDatadataKamusKata, inputData, pencatat) async {
    // bool success = await SourcedataKamusKata.updateCatatan(kdDatadataKamusKata,inputData,cUser.data.userId);
    bool success = await SourceKata.updateCatatan(
        kdDatadataKamusKata, inputData, 'app_mobile');
    //bool success = await SourcedataKamusKata.retrieveDictionaryText(kdDatadataKamusKata,inputData,cUser.data.userId);

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

  //1*
  getListAll() {
    cKamusKata.setListKata(widget.nik, widget.kdlokasi);
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
          cKamusKata.setListKata(widget.nik, widget.kdlokasi);
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
                  Get.to(() => const AddkataPage())?.then((value) {
                    if (value ?? false) {
                      // cKamusKata.setListKata(cUser.data.userId,cUser.data.idApotek);
                      cKamusKata.setListKata('', '');
                    }
                  });
                },
                icon: const Icon(Icons.add)),
          ]
          //}
          // ,
          ),
      body: GetBuilder<CKata>(builder: (_) {
        if (cKamusKata.loading) return DView.loadingCircle();
        //1*
        if (cKamusKata.listKata.isEmpty) return DView.empty();
        return ListView.separated(
          //1*
          itemCount: cKamusKata.listKata.length,
          separatorBuilder: (context, index) => const Divider(
            height: 1,
            indent: 16,
            endIndent: 16,
            color: Colors.white70,
          ),
          itemBuilder: (context, index) {
            //1*
            ListKata dataKamusKata = cKamusKata.listKata[index];
            return ListTile(
              leading: CircleAvatar(
                radius: 18,
                child: Text('${index + 1}'),
                backgroundColor: dataKamusKata.status == '0'
                    ? Colors.green[400]
                    : Colors.white,
              ),
              title: Text(
                dataKamusKata.kata!.isEmpty
                    ? ''
                    : dataKamusKata.kata!.toUpperCase(),
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text('${dataKamusKata.keterangan}'),
              trailing: PopupMenuButton<String>(
                onSelected: (value) {
                  if (value == 'gambar1') {
                    Get.to(() => UploadImageKataPage(
                              dataKamusKata.id.toString(),
                              tahun: dataKamusKata.kata!,
                              bulan: dataKamusKata.keterangan!,
                              tahap: dataKamusKata.keterangan2!,
                              batch: dataKamusKata.kata!,
                              gelombang: dataKamusKata.kata!,
                              mode: 'gambar',
                            ))!
                        .then((value) {
                      if (value ?? false) {
                        cKamusKata.setList();
                      }
                    });
                  } else if (value == 'gambar2') {
                    Get.to(() => UploadImageKataPage(
                              dataKamusKata.id.toString(),
                              tahun: dataKamusKata.kata!,
                              bulan: dataKamusKata.keterangan!,
                              tahap: dataKamusKata.keterangan2!,
                              batch: dataKamusKata.kata!,
                              gelombang: dataKamusKata.kata!,
                              mode: 'gambar2',
                            ))!
                        .then((value) {
                      if (value ?? false) {
                        cKamusKata.setList();
                      }
                    });
                  } else if (value == 'gambar3') {
                    Get.to(() => UploadImageKataPage(
                              dataKamusKata.id.toString(),
                              tahun: dataKamusKata.kata!,
                              bulan: dataKamusKata.keterangan!,
                              tahap: dataKamusKata.keterangan2!,
                              batch: dataKamusKata.kata!,
                              gelombang: dataKamusKata.kata!,
                              mode: 'gambar3',
                            ))!
                        .then((value) {
                      if (value ?? false) {
                        cKamusKata.setList();
                      }
                    });
                  } else if (value == 'video') {
                    Get.to(() => UploadImageKataPage(
                              dataKamusKata.id.toString(),
                              tahun: dataKamusKata.kata!,
                              bulan: dataKamusKata.keterangan!,
                              tahap: dataKamusKata.keterangan2!,
                              batch: dataKamusKata.kata!,
                              gelombang: dataKamusKata.kata!,
                              mode: 'video',
                            ))!
                        .then((value) {
                      if (value ?? false) {
                        cKamusKata.setList();
                      }
                    });
                  } else if (value == 'view_images') {
                    openImages(dataKamusKata.id.toString(), dataKamusKata.kata!,
                        dataKamusKata.keterangan!, "surveyor");
                  } else if (value == 'photo_verifikator') {
                    Get.to(() => UploadPhotoKataPage(
                              // dataKamusKata.id.toString()!,
                              dataKamusKata.id.toString(),
                              tahun: dataKamusKata.kata!,
                              bulan: dataKamusKata.keterangan!,
                              tahap: dataKamusKata.keterangan2!,
                              batch: dataKamusKata.kata!,
                              gelombang: dataKamusKata.kata!,
                              mode: 'verifikator',
                            ))!
                        .then((value) {
                      if (value ?? false) {
                        cKamusKata.setList();
                      }
                    });
                    //}
                    // else if (value == 'catatan_surveyor') {
                    //   openDialogCatatanDtks(
                    //       context, "Isi Catatan", dataKamusKata.id.toString());
                  } else if (value == 'edit') {
                    Get.to(() => AddkataPage(peserta: dataKamusKata))!
                        .then((value) {
                      if (value ?? false) cKamusKata.setListKata('', '');
                    });

                    // Get.to(() =>  AddPesertDtks(peserta: dataKamusKata))?.then((value) {
                    //       if (value ?? false) {cKamusKata.setListKata('','');}
                    //     });
                  } else if (value == 'delete') {
                    //delete(dataKamusKata.id.toString(),"ta_dtks",dataKamusKata.kata!,dataKamusKata.keterangan!,"");
                  }
                  {
                    //delete(dataKamusKata.idt.toString());
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
                  cKamusKata.search(controllerSearch.text);
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
