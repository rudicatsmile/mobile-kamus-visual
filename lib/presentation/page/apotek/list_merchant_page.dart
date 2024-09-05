// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../config/api.dart';
import '../../../config/app_color.dart';
import '../../../data/model/list_merchant.dart';
import '../../controller/c_list_merchant.dart';
import '../../controller/c_user.dart';
import '../example/appbar_controller.dart';
import 'search_suggestion.dart';
import 'upload_file_page.dart';
import 'package:http/http.dart' as http;
import '../../../config/app_format.dart';


class ListMerchantPage extends StatefulWidget {
  // final String kriteria;
  // const ListMerchantPage(this.kriteria, {key}) : super(key: key);

  final String kriteria;
  final String? nik;
  final String? kdkecamatan;
  final String? dataSearch;
  const ListMerchantPage({
    Key? key,
    required this.kriteria,
    required this.nik,
    required this.kdkecamatan,
    required this.dataSearch,
  }) : super(key: key);

  @override
  State<ListMerchantPage> createState() => _ListMerchantPageState();
}

class _ListMerchantPageState extends State<ListMerchantPage> {
  final cListMerchant = Get.put(CListMerchant());
  final cUser = Get.put(CUser());

  final controllerSearch = TextEditingController();
  final catatanController = TextEditingController();

  String? valueText;
  String? codeDialog;
  bool isExpanded = false;
  String? kodeKecamatan; 


  getListAll() {
    cListMerchant.setListByNik(
        widget.kriteria, widget.nik, widget.kdkecamatan, widget.dataSearch);
  }

  void openKecamatan(String nik, String tahun, String bulan, String mode) {
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
                  child: Container(
                    height: double.infinity,

                    color: Colors.amber,
                    child: Column(                    
                      children: [
                        const SizedBox(height: 10),
                        const Text(
                          "Data Kecamatan  ",
                          style:  TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 15),
                        //Start here
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: _searchController,
                            onChanged: (value) {
                              _getSuggestions(value);
                            },
                            decoration: const InputDecoration(
                              hintText: 'Search...',
                            ),
                          ),
                        ),
                        if (_isLoading)
                          const CircularProgressIndicator(),
                        if (_errorMessage.isNotEmpty)
                          Text(_errorMessage, style: const TextStyle(color: Colors.red)),
                        // Expanded(
                          // child: 
                          
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
                         
                        // ),
                    
                        //End here
                    
                        //Buttons tutup
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
          ),
        ],
      ),
    );
  }

  //---------- Deklarasi Search suggetion -----------

  TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _suggestions = [];
  bool _isLoading = false;
  String _errorMessage = '';
  String _result = '';

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

  Future<void> _getKecamatanName(String? parameter) async {

    final url= Uri.parse('${Api.location}/getLocationName.php?kode=$parameter'); 
    print('URL kec : '+url.toString());

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(' Dataku : '+data['value']);
      setState(() {
        _result = data['value']; 
      });
    } else {
      print(' Dataku : error');
      setState(() {
        _result = 'Error: ${response.statusCode}';
      });
    }
  }
  @override
  void initState() {
    _getKecamatanName(widget.kdkecamatan);
    getListAll();
    _searchController.text = widget.dataSearch.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
         
          floatingActionButton: Column(
              mainAxisAlignment: MainAxisAlignment.end, // Sejajarkan ke bawah
              children: <Widget>[
                FloatingActionButton(                  
                  onPressed: () {
                    //child: Icon(Icons.refresh),
                    Get.off(SearchSuggestionScreen(kriteria: widget.kriteria, dataSearch: _searchController.text == ''? widget.dataSearch:_searchController.text,));
                  },
                  heroTag: null,   // Untuk menghindari konflik animasi hero
                  child:   const Icon(Icons.location_on),                  
                ),
                const SizedBox(height: 16), // Jarak antara tombol
                FloatingActionButton(
                  onPressed: () 
                    {
                      cListMerchant.setListByNik(widget.kriteria, widget.nik,
                      widget.kdkecamatan, widget.dataSearch);
                    },                  
                  heroTag: null,
                  child: const Icon(Icons.refresh),
                ),
              ],
            ),
          
          appBar:   

          //Appbar for search kecamatan. onchange textfield show kecamatan list              
          // AppBar(
          //   titleSpacing: 0,
          //   title: GetBuilder<AppBarController>(
          //     init: AppBarController(),
          //     builder: (controller) => TextField(
          //       controller: _searchController,
          //       onChanged: (value) {
          //         _getSuggestions(value);
          //         controller.toggleListView;
          //         },
          //       onTap: controller.toggleListView,
          //       decoration: InputDecoration(
          //         border: OutlineInputBorder(
          //           borderSide: BorderSide.none,
          //           borderRadius: BorderRadius.circular(30),
          //         ),
          //         contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          //         isDense: true,
          //         filled: true,
          //         fillColor: AppColor.input,
          //         hintText: 'Pencarian Kecamatan',
          //         suffixIcon: IconButton(
          //           onPressed: () {
          //             if (_searchController.text != '') {
          //               // cListMerchant.search(_searchController.text);
          //               print('cari :'+_searchController.text);
          //               print('kode kecamatan :'+ kodeKecamatan!);
          //               cListMerchant.setListByNik(widget.kriteria, widget.nik,kodeKecamatan, '');
          //             }
          //           },
          //           icon: const Icon(Icons.search, color: Colors.white),
          //         ),
          //       ),
          //     ),
          //   ),
          // ),

          //Appbar for just click button searh to change listview obat
          AppBar(
            titleSpacing: 0,
            title: GetBuilder<AppBarController>(
              init: AppBarController(),
              builder: (controller) => TextField(
                controller: _searchController,
                // onChanged: (value) {
                //   _getSuggestions(value);
                //   controller.toggleListView;
                //   },
                // onTap: controller.toggleListView,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  isDense: true,
                  filled: true,
                  fillColor: AppColor.input,
                  hintText: 'Pencarian data...',
                  suffixIcon: IconButton(
                    onPressed: () {
                      if (_searchController.text != '') {
                        // cListMerchant.search(_searchController.text);
                        print('kriteria :${widget.kriteria}');
                        print('cari :${_searchController.text}');
                       // print('kode kecamatan :${kodeKecamatan!}');
                        print('kode kecamatan 2 :${widget.kdkecamatan}');
                        cListMerchant.setListByNik(widget.kriteria, widget.nik, widget.kdkecamatan, _searchController.text);
                      }
                    },
                    icon: const Icon(Icons.search, color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
      body: GetBuilder<CListMerchant>(builder: (_) {
        if (cListMerchant.loading) return DView.loadingCircle();
        //if (cListMerchant.listByNik.isEmpty) return DView.empty();

        return Container(
          height: double.infinity,
          //color: Colors.amber,
          child: Stack(
            children: [
              // Text('Kecamatan ${widget.kdkecamatan}'),
              // const SizedBox(height: 10,),
                          
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


              Positioned(
                bottom: 0, // Jarak dari bawah layar
                left: 0, // Jarak dari kiri layar (opsional)
                right: 0, // Jarak dari kanan layar (opsional)
                child: Container(
                  padding: const EdgeInsets.all(8.0), // Padding internal container
                  decoration: BoxDecoration(
                    color: Colors.black, // Background hitam
                    borderRadius: BorderRadius.circular(8.0), // Opsional: sudut melengkung
                  ),
                  child: Text(
                    'Data Kecamatan : $_result',
                    style: const TextStyle(
                      color: Colors.white, // Warna teks putih
                      fontSize: 12.0, // Ukuran teks
                      fontWeight: FontWeight.bold, // Opsional: teks tebal
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

  ListView listMerchant() {
    return 
    //SingleChildScrollView(
      //child: 
      ListView.separated(
        shrinkWrap: true,
        itemCount: cListMerchant.listByNik.length,
        separatorBuilder: (context, index) => const Divider(
          height: 1,
          indent: 16,
          endIndent: 16,
          color: Colors.white70,
        ),
        itemBuilder: (context, index) {
          ListMerchant listMerchant = cListMerchant.listByNik[index];
          return ListTile(
            leading: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 18,                  
                  backgroundColor: Colors.white,
                  child: Text('${index + 1}'),
                ),
              ],
            ),
            title: Text('${listMerchant.namaObat} @ Rp ${AppFormat.currency(listMerchant.hargaJual ?? '0')}'),
            //subtitle: Text(listMerchant.alamat ?? ''),
            // Subtitle dengan animasi show/hide
            //         style: const TextStyle(fontSize: 10)),
            // subtitle: AnimatedContainer(
            //   duration: const Duration(milliseconds: 300),
            //   height: isExpanded ? null : 0,
            //   child: SingleChildScrollView(
            //     // Agar subtitle bisa discroll jika terlalu panjang
            //     child: Text(listMerchant.alamat ?? '',
            //         style: const TextStyle(fontSize: 10)),
            //   ),
            // ),
            // onTap: () {
            //   setState(() {
            //     isExpanded = !isExpanded;
            //   });
            // },
            trailing: IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () {
                //Get.to(() => HalamanPesanan(dataSearch: widget.dataSearch.toString(), kodeDepo: listMerchant.kode.toString(), noRekening: listMerchant.noRekening.toString()));
                Get.to(() => UploadFile(
                    dataSearch: widget.dataSearch.toString(),
                    kodeDepo: listMerchant.kodeMerchant.toString(),
                    kodeObat: listMerchant.kodeObat.toString(),
                    harga: listMerchant.hargaJual.toString()
                    ));
              },
            ),
          );
        },
      );
    // );
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
                  cListMerchant.search(_searchController.text);
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
