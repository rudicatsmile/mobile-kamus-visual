import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../config/api.dart';
import '../../controller/c_user.dart';
import 'list_merchant_page.dart';

class SearchSuggestionScreen extends StatefulWidget {
  final String kriteria; 
  final String? dataSearch;
  const SearchSuggestionScreen({
    Key? key,
    required this.kriteria,  
    required this.dataSearch,
  }) : super(key: key);
  @override
  _SearchSuggestionScreenState createState() => _SearchSuggestionScreenState();
}

class _SearchSuggestionScreenState extends State<SearchSuggestionScreen> {
  TextEditingController _searchController = TextEditingController();
  // List<String> _suggestions = [];
  final cUser = Get.put(CUser());

  List<Map<String, dynamic>> _suggestions = [];
  bool _isLoading = false;
  String _errorMessage = '';
  String? kodeKecamatan;

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
      final response = await http.get(Uri.parse(url)).timeout(Duration(seconds: 30)); // Timeout 5 detik

      if (response.statusCode == 200) {
        // setState(() {
        //   _suggestions = List<String>.from(json.decode(response.body));
        //   _isLoading = false;
        // });

        // Perubahan di sini
      final List<dynamic> data = json.decode(response.body);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pencarian lokasi'),
      ),
      body: 
      Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                _getSuggestions(value);
              },
              decoration: const InputDecoration(
                hintText: 'Cari ...',
              ),
            ),
          ),
          if (_isLoading)
            const CircularProgressIndicator(),
          if (_errorMessage.isNotEmpty)
            Text(_errorMessage, style: const TextStyle(color: Colors.red)),
          Expanded(
            child: ListView.builder(
              itemCount: _suggestions.length,
              itemBuilder: (context, index) {
                final Map<String, dynamic> suggestion = _suggestions[index];
                return ListTile(
                  title: Text(suggestion['deskripsi']),
                  subtitle: Text(suggestion['keterangan']??' -- '),                  
                  onTap: () {
                     _searchController.text = suggestion['deskripsi'];
                    FocusScope.of(context).unfocus();
                    // Hilangkan nilai di ListView
                    setState(() {
                      _suggestions = [];
                    });
                    print('widget.dataSearch :${widget.dataSearch}');
                    // Get.to(() => ListMerchantPage(
                    //                                   kriteria: widget.kriteria, 
                    //                                   nik: cUser.data.userId, 
                    //                                   kdkecamatan: suggestion['kode'],
                    //                                   dataSearch: widget.dataSearch
                    //                                   ));
                    Get.off(ListMerchantPage(
                                                      kriteria: widget.kriteria, 
                                                      nik: cUser.data.userId, 
                                                      kdkecamatan: suggestion['kode'],
                                                      dataSearch: widget.dataSearch
                                                      ));
                  },
                );
              },
            ),
            // child:
            //  ListView.builder(
            //   itemCount: _suggestions.length,
            //   itemBuilder: (context, index) {
            //     final suggestion = _suggestions[index];
            //     return ListTile(
            //       title: Text(suggestion['kode']),
            //       subtitle: Text('${suggestion['deskripsi']} - ${suggestion['alamat']}'),
                  
            //       onTap: () {
            //         //_searchController.text = _suggestions[index];
            //         _searchController.text = suggestion['kode'];
            //         FocusScope.of(context).unfocus();
            //         // Navigasi atau tindakan lain
            //       },
            //     );
            //   },
            // ),
          ),
        ],
      ),
    );
  }
}
