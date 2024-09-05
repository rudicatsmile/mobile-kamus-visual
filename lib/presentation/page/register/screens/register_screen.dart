import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/register_model_user.dart';
import '../services/register_api_service.dart'; // Untuk format tanggal

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final ApiService _apiService = ApiService();
  TextEditingController _userIdController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _namaController = TextEditingController();
  TextEditingController _idApotekController = TextEditingController();
  TextEditingController _telponController = TextEditingController();
  TextEditingController _whatsappController = TextEditingController();
  TextEditingController _pencatatController = TextEditingController();

  String _selectedAdmType = '1'; // Nilai default dropdown AdmType
  String _selectedKdPro = ''; // Nilai default dropdown KdPro
  String _selectedKdKab = ''; // Nilai default dropdown KdKab
  String _selectedKdKec = ''; // Nilai default dropdown KdKec
  String _selectedActive = 'Y'; // Nilai default radio button Active

  // ... (Data untuk dropdown KdPro, KdKab, KdKec, misal dari API atau lokal)
  List<String> _kdProList = [];
  List<String> _kdKabList = [];
  List<String> _kdKecList = [];

  @override
  void initState() {
    super.initState();
    _fetchDropdownData();
  }

  Future<void> _fetchDropdownData() async {
    try {
      _kdProList = await _apiService.getDropdownData('kd_pro');
      if (_kdProList.isNotEmpty) {
        _selectedKdPro = _kdProList[0]; // Set default value
        _kdKabList = await _apiService.getDropdownData('kd_kab&kd_pro=$_selectedKdPro');
        if (_kdKabList.isNotEmpty) {
          _selectedKdKab = _kdKabList[0]; // Set default value
          _kdKecList = await _apiService.getDropdownData('kd_kec&kd_kab=$_selectedKdKab');
          if (_kdKecList.isNotEmpty) {
            _selectedKdKec = _kdKecList[0]; // Set default value
          }
        }
      }
      setState(() {}); // Refresh UI setelah data dimuat
    } catch (e) {
      // Handle error, misalnya tampilkan pesan error
      print('Error fetching dropdown data: $e');
    }
  }

  Future<void> _fetchKdKabData() async {
    try {
      _kdKabList = await _apiService.getDropdownData('kd_kab&kd_pro=$_selectedKdPro');
      if (_kdKabList.isNotEmpty) {
        _selectedKdKab = _kdKabList[0]; // Set default value
        _fetchKdKecData(); // Fetch data KdKec saat KdKab berubah
      }
      setState(() {}); // Refresh UI setelah data dimuat
    } catch (e) {
      // Handle error
      print('Error fetching KdKab data: $e');
    }
  }

  Future<void> _fetchKdKecData() async {
    try {
      _kdKecList = await _apiService.getDropdownData('kd_kec&kd_kab=$_selectedKdKab');
      if (_kdKecList.isNotEmpty) {
        _selectedKdKec = _kdKecList[0]; // Set default value
      }
      setState(() {}); // Refresh UI setelah data dimuat
    } catch (e) {
      // Handle error
      print('Error fetching KdKec data: $e');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Registrasi')),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              TextFormField(
                controller: _userIdController,
                decoration: InputDecoration(labelText: 'User ID'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'User ID harus diisi';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password harus diisi';
                  }
                  return null;
                },
              ),
              // ... (TextField untuk Nama, IdApotek, Telpon, Whatsapp, Pencatat)
              TextFormField(
                controller: _namaController,
                decoration: InputDecoration(labelText: 'Nama'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama harus diisi';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _idApotekController,
                decoration: InputDecoration(labelText: 'ID Apotek'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'ID Apotek harus diisi';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _telponController,
                decoration: InputDecoration(labelText: 'Telepon'),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Telepon harus diisi';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _whatsappController,
                decoration: InputDecoration(labelText: 'WhatsApp'),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'WhatsApp harus diisi';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _pencatatController,
                decoration: InputDecoration(labelText: 'Pencatat'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Pencatat harus diisi';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                value: _selectedAdmType,
                items: ['1', '2', '3'].map((value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedAdmType = value!;
                  });
                },
                decoration: InputDecoration(labelText: 'Adm Type'),
              ),
              // ... (Dropdown untuk KdPro, KdKab, KdKec)

              FutureBuilder<List<String>>(
                future: _apiService.getDropdownData('kd_pro'),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator(); // Tampilkan loading indicator
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}'); // Tampilkan pesan error
                  } else if (snapshot.hasData) {
                    _kdProList = snapshot.data!;
                    return DropdownButtonFormField<String>(
                      value: _selectedKdPro,
                      items: _kdProList.map((kdPro) {
                        return DropdownMenuItem<String>(
                          value: kdPro,
                          child: Text(kdPro),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedKdPro = value!;
                          _fetchKdKabData(); // Fetch data KdKab saat KdPro berubah
                        });
                      },
                      decoration: InputDecoration(labelText: 'Kode Provinsi'),
                    );
                  } else {
                    return Text('Tidak ada data'); // Jika tidak ada data
                  }
                },
              ),


              // DropdownButtonFormField<String>(
              //   value: _selectedKdPro,
              //   items: _kdProList.map((kdPro) {
              //     return DropdownMenuItem<String>(
              //       value: kdPro,
              //       child: Text(kdPro),
              //     );
              //   }).toList(),
              //   onChanged: (value) {
              //     setState(() {
              //       _selectedKdPro = value!;
              //       // Update dropdown KdKab berdasarkan KdPro yang dipilih
              //     });
              //   },
              //   decoration: InputDecoration(labelText: 'Kode Provinsi'),
              // ),

              DropdownButtonFormField<String>(
                value: _selectedKdKab,
                items: _kdKabList.map((kdKab) {
                  return DropdownMenuItem<String>(
                    value: kdKab,
                    child: Text(kdKab),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedKdKab = value!;
                    // Update dropdown KdKec berdasarkan KdKab yang dipilih
                  });
                },
                decoration: InputDecoration(labelText: 'Kode Kabupaten'),
              ),
              DropdownButtonFormField<String>(
                value: _selectedKdKec,
                items: _kdKecList.map((kdKec) {
                  return DropdownMenuItem<String>(
                    value: kdKec,
                    child: Text(kdKec),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedKdKec = value!;
                  });
                },
                decoration: InputDecoration(labelText: 'Kode Kecamatan'),
              ),
              Row(
                children: [
                  Radio<String>(
                    value: 'Y',
                    groupValue: _selectedActive,
                    onChanged: (value) {
                      setState(() {
                        _selectedActive = value!;
                      });
                    },
                  ),
                  Text('Y'),
                  Radio<String>(
                    value: 'N',
                    groupValue: _selectedActive,
                    onChanged: (value) {
                      setState(() {
                        _selectedActive = value!;
                      });
                    },
                  ),
                  Text('N'),
                ],
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final user = RegisterModelUser(
                      userId: _userIdController.text,
                      password: _passwordController.text,
                      nama: _namaController.text, 
                      admType: _selectedAdmType,
                      idApotek: _idApotekController.text, 
                      telpon: _telponController.text, 
                      whatsapp: _whatsappController.text, 
                      kdPro: _selectedKdPro, 
                      kdKab: _selectedKdKab, 
                      kdKec: _selectedKdKec, 
                      active: _selectedActive,
                      recorder: DateTime.now(),
                      pencatat: _pencatatController.text, 
                                            
                    );

                    final result = await _apiService.registerUser(user);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(result['message'])),
                    );
                  }
                },
                child: Text('Daftar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
