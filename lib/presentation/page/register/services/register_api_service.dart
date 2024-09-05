import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../config/api.dart';
import '../models/register_model_user.dart';

class ApiService {

  final String apiUrl = '${Api.kamus}/register.php'; // Ganti dengan URL API Anda

  Future<Map<String, dynamic>> registerUser(RegisterModelUser user) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        body: jsonEncode(user.toJson()),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 201) {
        return {'success': true, 'message': 'Registrasi berhasil'};
      } else {
        final errorData = jsonDecode(response.body);
        return {'success': false, 'message': errorData['message'] ?? 'Terjadi kesalahan'};
      }
    } catch (e) {
      print('Error: $e');
      return {'success': false, 'message': 'Terjadi kesalahan koneksi'};
    }
  }

  Future<List<String>> getDropdownData(String type) async {
    try {
      final response = await http.get(Uri.parse('$apiUrl?type=$type'));
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((item) => item.toString()).toList();
      } else {
        throw Exception('Gagal mengambil data dropdown');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Terjadi kesalahan koneksi');
    }
  }
}
