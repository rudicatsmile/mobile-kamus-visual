import 'dart:convert';
import 'package:d_info/d_info.dart';
import 'package:d_method/d_method.dart';
import '../../config/api.dart';
import '../../config/app_request.dart';
import '../model/peserta.dart';

class SourcePeserta {


  static Future<int> count() async {
    String url = '${Api.peserta}/${Api.count}';
    String? responseBody = await AppRequest.gets(url);
    if (responseBody != null) {
      Map result = jsonDecode(responseBody);
      return result['data'];
    }
    return 0;
  }

  static Future<List<Peserta>> gets() async {
    String url = '${Api.peserta}/${Api.gets}';
    String? responseBody = await AppRequest.gets(url);
    if (responseBody != null) {
      Map result = jsonDecode(responseBody);
      if (result['success']) {
        List list = result['data'];
        return list.map((e) => Peserta.fromJson(e)).toList();
      }
      return [];
    }
    return [];
  }

  static Future<bool> add(        
    String nik, 
    String nokk, 
    String nama,
    String tempatLahir,
    String tanggalLahir,
    String jenisKelamin,
    String alamat,
    String rtRw,
    String provinsi,
    String kabupaten,
    String kecamatan,
    String desa,
    String rw,
    String rt,
    String agama,
    String statusKawin,
    String pekerjaan,
    String kewarganegaraan,
    ) async {
    String url = '${Api.peserta}/${Api.add}';
    String? responseBody = await AppRequest.post(url, {
      'nik': nik,
      'nokk': nokk,
      'nama': nama,
      'tempatLahir': tempatLahir,
      'tanggalLahir': tanggalLahir,
      'jenisKelamin': jenisKelamin,
      'alamat': alamat,
      'rtRw': rtRw,
      'provinsi': provinsi,
      'kabupaten': kabupaten,
      'kecamatan': kecamatan,
      'desa': desa,
      'kodeRW': rw,
      'kodeRT': rt,
      'agama': agama,
      'statusKawin': statusKawin,
      'pekerjaan': pekerjaan,
      'kewarganegaraan': kewarganegaraan,
    });
    if (responseBody != null) {
      Map result = jsonDecode(responseBody);
      if (result['success']) {
        return true;
      } else {
        if (result['message'] == 'nik') {
          DInfo.toastError('NIK sudah pernah digunakan');
        }
        DMethod.printTitle('SQL : ', result['message'] ); 
        return false;
      }
    }

    return false;
  }

  static Future<bool> update(String oldNik, Peserta peserta) async {
    String url = '${Api.peserta}/${Api.update}';
    String? responseBody = await AppRequest.post(url, {
      'old_nik': oldNik,
      'nik': peserta.nik,
      'nokk': peserta.nokk,
      'nama': peserta.nama,
      'tempatLahir': peserta.tempatLahir,
      'tanggalLahir': peserta.tanggalLahir,
      'jenisKelamin': peserta.jenisKelamin,
      'alamat': peserta.alamatKtp,
      'rtRw': peserta.rtrwKtp,
      'provinsi': peserta.provinsiKtp,
      'kabupaten': peserta.kabupatenKtp,
      'kecamatan': peserta.kecamatanKtp,
      'desa': peserta.kelurahanKtp,
      'agama': peserta.agama,
      'statusKawin': peserta.stakaw,
      'pekerjaan': peserta.pekerjaan,
      'kewarganegaraan': peserta.kewarganegaraan,

     
    });
    if (responseBody != null) {
      Map result = jsonDecode(responseBody);
      // if false
      String message = result['message'] ?? '';
      if (message == 'nik') {
        DInfo.toastError('NIK Sudah digunakan');
      }
      // return follow success Api
      return result['success'];
    }
    return false;
  }

  static Future<bool> updatePengajuan(String nik, String kdPmks, String kdTanggungan) async {
    String url = '${Api.peserta}/add_pengajuan.php';

    String? responseBody = await AppRequest.post(url, {
      'nik': nik,
      'jenisPmks': kdPmks,
      'jenisTanggungan': kdTanggungan,     
    });
    if (responseBody != null) {
      Map result = jsonDecode(responseBody);
      // if false
      String message = result['message'] ?? '';
      if (message == 'nik') {
        DInfo.toastError('Sudah ada pengajuan');
      }
      // return follow success Api
      return result['success'];
    }
    return false;
  }

  static Future<bool> delete(String idPeserta) async {
    String url = '${Api.peserta}/${Api.delete}';
    String? responseBody = await AppRequest.post(url, {'idt': idPeserta});
    if (responseBody != null) {
      Map result = jsonDecode(responseBody);
      return result['success'];
    }
    return false;
  }

  
  
}
