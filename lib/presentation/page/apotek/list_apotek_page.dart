// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:d_info/d_info.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:intl/intl.dart';
import '../../../config/api.dart';
import '../../../config/app_color.dart';
import '../../../data/model/dtks_images.dart';
import '../../../data/model/list_apotek.dart';
import '../../../data/source/source_list_apotek.dart';
import '../../controller/c_list_apotek.dart';
import '../../controller/c_user.dart';
import '../example/appbar_controller.dart';
import 'pesanan_page.dart';
import 'upload_file_page.dart';
import 'package:http/http.dart' as http;

class ListApotekPage extends StatefulWidget {
  // final String kriteria;
  // const ListApotekPage(this.kriteria, {key}) : super(key: key);

  final String kriteria;
  final String? nik;
  final String? kdkecamatan;
  final String? dataSearch;
  const ListApotekPage({
    Key? key,
    required this.kriteria,
    required this.nik,
    required this.kdkecamatan,
    required this.dataSearch,
  }) : super(key: key);

  @override
  State<ListApotekPage> createState() => _ListApotekPageState();
}

class _ListApotekPageState extends State<ListApotekPage> {
  final cListApotek = Get.put(CListApotek());
  final cUser = Get.put(CUser());

  final controllerSearch = TextEditingController();
  final catatanController = TextEditingController();

  String? valueText;
  String? codeDialog;
  bool isExpanded = false;
  String? kodeKecamatan;

  delete(String idPeserta, String tableName, String tahun, String bulan,
      String mode) async {
    bool? yes = await DInfo.dialogConfirmation(
        context, 'Delete Data', 'Ya Untuk Konfirmasi');
    // if (yes != null) {
    if (yes == true) {
      bool success = await SourceListAPotek.delete(idPeserta, tableName);
      if (success) {
        DInfo.dialogSuccess(context, 'Sukses hapus peserta');
        DInfo.closeDialog(
          context,
          // actionAfterClose: () => cListApotek.setList(),

          actionAfterClose: () => tableName == 'ta_dtks'
              ? cListApotek.setListByNik(widget.kriteria, cUser.data.userId,
                  cUser.data.idApotek, widget.dataSearch)
              : cListApotek.setListImage(cUser.data.userId, tahun, bulan, mode),
        );
      } else {
        DInfo.dialogError(context, 'gagal hapus peserta');
        DInfo.closeDialog(
          context,
        );
      }
    }
  }

  openImages(String nik, String tahun, String bulan, String mode) {
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
                        "NIK : $nik",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 15),

                      Obx(() {
                        cListApotek.setListImage(nik, tahun, bulan, mode);
                        if (cListApotek.listImage.isEmpty) {
                          return DView.empty("Belum ada data");
                        }

                        return Container(
                          height: 500.0, // Change as per your requirement
                          width: 300.0, //
                          child: ListView.separated(
                            itemCount: cListApotek.listImage.length,
                            separatorBuilder: (context, index) => const Divider(
                              height: 1,
                              indent: 16,
                              endIndent: 16,
                              color: Colors.black,
                            ),
                            itemBuilder: (context, index) {
                              DtksImages dtksImages =
                                  cListApotek.listImage[index];
                              return
                                  // Container(
                                  //   color: Colors.amber,
                                  //   child:
                                  //       // CircleAvatar(
                                  //       //   radius: 40,
                                  //       //   backgroundColor: Colors.transparent,
                                  //       // child:
                                  //       InstaImageViewer(
                                  //         child: Image(
                                  //             // width: 150,
                                  //             // height: 60,
                                  //             semanticLabel:
                                  //                 '${Api.imagesDtks}/${dtksImages.nik}xyz${dtksImages.tahun}xyz${dtksImages.bulan}xyz${dtksImages.fileName}',
                                  //             fit: BoxFit.contain,
                                  //             image: dtksImages.fileName == ''
                                  //                 ? Image.network(
                                  //                         '${Api.imagesDtks}/default.png')
                                  //                     .image
                                  //                 : Image.network(
                                  //                         '${Api.imagesDtks}/${dtksImages.nik}xyz${dtksImages.tahun}xyz${dtksImages.bulan}xyz${dtksImages.fileName}')
                                  //                     .image),
                                  //       ),
                                  //   //),
                                  //   // ],,
                                  // );
                                  ListTile(
                                      leading: Wrap(
                                        direction: Axis.vertical,
                                        spacing: 0, // space between two icons
                                        children: <Widget>[
                                          Text("${index + 1}. "),
                                          CircleAvatar(
                                            radius: 40,
                                            backgroundColor: Colors.transparent,
                                            child: InstaImageViewer(
                                              child: Image(
                                                  width: 200,
                                                  height: 140,
                                                  fit: BoxFit.fill,
                                                  image: dtksImages.fileName ==
                                                          ''
                                                      ? Image.network(
                                                              '${Api.imagesDtks}/default.png')
                                                          .image
                                                      : Image.network(
                                                              '${Api.imagesDtks}/${dtksImages.nik}xyz${dtksImages.tahun}xyz${dtksImages.bulan}xyz${dtksImages.fileName}')
                                                          .image),
                                            ),
                                          ),
                                        ],
                                      ),
                                      title: Text(
                                          DateFormat('dd MMMM yyyy  HH:mm:ss')
                                              .format(DateTime.parse(
                                                  dtksImages.recorded!))),
                                      titleTextStyle:
                                          const TextStyle(fontSize: 10),
                                      subtitle: Text(
                                        "${dtksImages.title}",
                                        style:
                                            const TextStyle(color: Colors.blue),
                                      ),
                                      subtitleTextStyle:
                                          const TextStyle(fontSize: 9),
                                      //=====Trailing==========
                                      trailing: PopupMenuButton<String>(
                                        onSelected: (value) {
                                          if (value == 'delete') {
                                            // Get.to(() => PengajuanPesertDtks(listApotek: listApotek))!
                                            //     .then((value) {
                                            //   if (value ?? false) {
                                            //     cListApotek.setList();
                                            //   }
                                            // });
                                            delete(
                                                dtksImages.idt.toString(),
                                                "ta_dtks_foto",
                                                tahun,
                                                bulan,
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
                              child: const Text(
                                'Tutup',
                              ),
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(0, 45),
                                backgroundColor:
                                    const Color.fromARGB(184, 4, 16, 80),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: () {
                                // Navigator.pop(context);
                                Get.back();
                              },
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

  updateCatatanDtks(String kdDataListApotek, inputData, pencatat) async {
    bool success = await SourceListAPotek.updateCatatan(
        kdDataListApotek, inputData, cUser.data.nama);

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

  getListAll() {
    cListApotek.setListByNik(
        widget.kriteria, widget.nik, widget.kdkecamatan, widget.dataSearch);
  }

  //---------- Deklarasi Search suggetion -----------

  TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _suggestions = [];
  bool _isLoading = false;
  String _errorMessage = '';

  Future<void> _getSuggestions(String query) async {
    if (query.isEmpty) {
      setState(() {
        _suggestions = [];
        _isLoading = false;
        _errorMessage = '';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      final url = '${Api.location}/searchSuggestion.php?query=$query';
      final response = await http
          .get(Uri.parse(url))
          .timeout(Duration(seconds: 30)); // Timeout 5 detik
      print('URL : '+url);
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        print('DATA : '+data.length.toString());

        setState(() {
          _suggestions = data.map((item) => item as Map<String, dynamic>).toList();
          _isLoading = false;
        });
      } else {
        throw Exception('ailed to load suggestions : ');
      }
    } catch (e) {
      setState(() {
        _suggestions = [];
        _isLoading = false;
        _errorMessage = 'Error bro: ${e.toString()}';
      });
    }
  }
  //---------- END Deklarasi Search suggetion -----------

  @override
  void initState() {
    getListAll();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromRGBO(82, 170, 94, 1.0),
        tooltip: 'Refresh data',
        onPressed: () {
          cListApotek.setListByNik(widget.kriteria, widget.nik,
              widget.kdkecamatan, widget.dataSearch);
        },
        child: const Icon(Icons.refresh, color: Colors.white, size: 28),
      ),
          appBar: 
          //     AppBar(
          //   titleSpacing: 0,
          //   title: Row(
          //     children: [
          //       widget.kriteria == 'apotek'
          //           ? const Text(
          //               'E-Apotek',
          //               style: TextStyle(fontSize: 17),
          //             )
          //           : widget.kriteria == 'warung'
          //               ? const Text(
          //                   'E-Warung',
          //                   style: TextStyle(fontSize: 17),
          //                 )
          //               : const Text(
          //                   'E-Resep',
          //                   style: TextStyle(fontSize: 17),
          //                 ),
          //       search(),
          //     ],
          //   ),
          // ),
          
          AppBar(
            titleSpacing: 0,
            title: GetBuilder<AppBarController>(
              init: AppBarController(),
              builder: (controller) => TextField(
                controller: _searchController,
                onChanged: (value) {
                  _getSuggestions(value);
                  controller.toggleListView;
                  },
                onTap: controller.toggleListView,
                //decoration:  InputDecoration(hintText: 'Search' ),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  isDense: true,
                  filled: true,
                  fillColor: AppColor.input,
                  hintText: 'Pencarian Kecamatan',
                  suffixIcon: IconButton(
                    onPressed: () {
                      if (_searchController.text != '') {
                        // cListApotek.search(_searchController.text);
                        print('cari :'+_searchController.text);
                        print('kode kecamatan :'+ kodeKecamatan!);
                        cListApotek.setListByNik(widget.kriteria, widget.nik,kodeKecamatan, '');
                      }
                    },
                    icon: const Icon(Icons.search, color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
       
      body: GetBuilder<CListApotek>(builder: (_) {
        if (cListApotek.loading) return DView.loadingCircle();
        if (cListApotek.listByNik.isEmpty) return DView.empty();

        return Container(
          height: double.infinity,
          //color: Colors.amber,
          child: Stack(
            children: [
                          
              if (_isLoading) const CircularProgressIndicator(),
              if (_errorMessage.isNotEmpty)
                Text(_errorMessage, style: const TextStyle(color: Colors.red)),

                
                Container(
                  width: double.infinity,
                  // height:double.maxFinite,
                  color: Colors.blue,
                  child: listMerchant(),

                ),    

              Obx(
                () => Visibility(                  
                  visible: Get.find<AppBarController>().showListView.value,
                  child: 
                    SingleChildScrollView(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: _suggestions.length,
                        itemBuilder: (context, index) {
                          final Map<String, dynamic> suggestion = _suggestions[index];
                          return ListTile(
                            title: Text('Kecamatan '+suggestion['deskripsi']),
                            subtitle: Text(suggestion['keterangan']??' -- '),                  
                            onTap: () {
                              _searchController.text = suggestion['deskripsi'];
                              
                              FocusScope.of(context).unfocus();
                              // Hilangkan nilai di ListView
                              setState(() {
                                _suggestions = [];
                                kodeKecamatan = suggestion['kode'];
                              });
                            },
                          );
                        },                    
                      ),
                    ),
                ),
              ), 
            ],
          ),
        );
      }),
    );
  }

  ListView listSearch() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: _suggestions.length,
      itemBuilder: (context, index) {
        final Map<String, dynamic> suggestion = _suggestions[index];
        return ListTile(
          title: Text(suggestion['deskripsi']),
          subtitle: Text(suggestion['keterangan'] ?? ' -- '),
          onTap: () {
            _searchController.text = suggestion['deskripsi'];
            FocusScope.of(context).unfocus();
            // Hilangkan nilai di ListView
            setState(() {
              _suggestions = [];
            });
          },
        );
      },
    );
  }

  SingleChildScrollView listMerchant() {
    return 
    SingleChildScrollView(
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: cListApotek.listByNik.length,
        separatorBuilder: (context, index) => const Divider(
          height: 1,
          indent: 16,
          endIndent: 16,
          color: Colors.white70,
        ),
        itemBuilder: (context, index) {
          ListApotek listApotek = cListApotek.listByNik[index];
          return ListTile(
            leading: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 18,
                  child: Text('${index + 1}'),
                  backgroundColor: Colors.white,
                ),
              ],
            ),
            title: Text(listApotek.deskripsi ?? ''),
            subtitle: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: isExpanded ? null : 0,
              child: SingleChildScrollView(
                // Agar subtitle bisa discroll jika terlalu panjang
                child: Text(listApotek.daftarBarang ?? '',
                    style: const TextStyle(fontSize: 10)),
              ),
            ),
            onTap: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
            trailing: IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () {
                //Get.to(() => HalamanPesanan(dataSearch: widget.dataSearch.toString(), kodeDepo: listApotek.kode.toString(), noRekening: listApotek.noRekening.toString()));
                Get.to(() => UploadFile(
                    dataSearch: widget.dataSearch.toString(),
                    kodeDepo: listApotek.kode.toString(),
                    kodeObat: listApotek.noRekening.toString(), 
                    harga: '0',));
              },
            ),
          );
        },
      ),
    );
  }

  Expanded search2() {
    return Expanded(
      child: Container(
        height: 70,
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            // child:
            TextField(
              controller: _searchController,
              onChanged: (value) {
                _getSuggestions(value);
              },
              decoration: const InputDecoration(
                hintText: 'Search...',
              ),
            ),
            // ),
            if (_isLoading) const CircularProgressIndicator(),
            if (_errorMessage.isNotEmpty)
              Text(_errorMessage, style: const TextStyle(color: Colors.red)),
            Expanded(
              child: ListView.builder(
                itemCount: _suggestions.length,
                itemBuilder: (context, index) {
                  final Map<String, dynamic> suggestion = _suggestions[index];
                  return ListTile(
                    title: Text(suggestion['deskripsi']),
                    subtitle: Text(suggestion['keterangan'] ?? ' -- '),
                    onTap: () {
                      _searchController.text = suggestion['deskripsi'];
                      FocusScope.of(context).unfocus();
                      // Hilangkan nilai di ListView
                      setState(() {
                        _suggestions = [];
                      });
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Expanded search() {
    return Expanded(
      child: Container(
        height: 70,
        padding: const EdgeInsets.all(16),
        child: TextField(
          controller: _searchController,
          onTap: () {},
          onChanged: (value) {
            _getSuggestions(value);
          },
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(30),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            isDense: true,
            filled: true,
            fillColor: AppColor.input,
            hintText: 'Search...',
            suffixIcon: IconButton(
              onPressed: () {
                if (_searchController.text != '') {
                  cListApotek.search(_searchController.text);
                }
              },
              icon: const Icon(Icons.search, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
