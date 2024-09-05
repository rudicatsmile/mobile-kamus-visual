import 'dart:convert';
import 'package:cross_file/src/types/interface.dart';
import 'package:d_info/d_info.dart';
import 'package:d_method/d_method.dart';
import '../../config/api.dart';
import '../../config/app_request.dart';
import '../model/dtks_images.dart';
import '../model/list_apotek.dart';
import '../model/list_merchant.dart';
import '../model/peserta _dtks.dart';

class SourceListAPotek {
 

  static Future<int> count() async {
    String url = '${Api.pesertaDtks}/${Api.count}';
    String? responseBody = await AppRequest.gets(url);
    if (responseBody != null) {
      Map result = jsonDecode(responseBody);
      return result['data'];
    }
    return 0;
  }

  static Future<int> countOfValid() async {
    String url = '${Api.pesertaDtks}/count_of_valid.php';
    String? responseBody = await AppRequest.gets(url);
    if (responseBody != null) {
      Map result = jsonDecode(responseBody);
      return result['data'];
    }
    return 0;
  }

  static Future<List<ListApotek>> gets() async {
    String url = '${Api.pesertaDtks}/${Api.gets}';
    String? responseBody = await AppRequest.gets(url);
    if (responseBody != null) {
      Map result = jsonDecode(responseBody);
      if (result['success']) {
        List list = result['data'];
        return list.map((e) => ListApotek.fromJson(e)).toList();
      }
      return [];
    }
    return [];
  }

  //1*
  static Future<List<ListApotek>> getsDtks(String nikSurveyor, String kdkelurahan) async {
    String url = '${Api.pesertaDtks}/${Api.gets}';
    // DMethod.printTitle('Source : ', '${'setListByNik Source : '+nikSurveyor} : $kdkelurahan');

    String? responseBody = await AppRequest.post(
      url,
      {
        'nikSurveyor': nikSurveyor,
        'kdkelurahan': kdkelurahan,
        },
    );
    if (responseBody != null) {
      Map result = jsonDecode(responseBody);
      if (result['success']) {
        List list = result['data'];
        return list.map((e) => ListApotek.fromJson(e)).toList();
      }
      return [];
    }
    return [];
  }

  // Get Apotik : Toko to batang / One to many
  static Future<List<ListApotek>> getApotek(String kriteria, String nik, String kdKecamatan,String dataSearch) async {

    String url="";

    if(kriteria=='apotek' || kriteria=='resep'){
       url = '${Api.getApotekLocation}/${Api.gets}';
    }else{
       url = '${Api.getWarungLocation}/${Api.gets}';
    }
    

    String? responseBody = await AppRequest.post(
      url,
      {
        'nik': nik,
        'kdKecamatan': kdKecamatan,
        'dataSearch': dataSearch,
        },
    );
    if (responseBody != null) {
      Map result = jsonDecode(responseBody);
      if (result['success']) {
        List list = result['data'];
        return list.map((e) => ListApotek.fromJson(e)).toList();
      }
      return [];
    }
    return [];
  }

  // Get Merchant : Brang to Toko / One to one
  static Future<List<ListMerchant>> getMerchant(String kriteria, String idUser, String kdKecamatan,String dataSearch) async {

    String url="";

    if(kriteria=='apotek' || kriteria=='resep'){
       url = '${Api.getApotekLocation}/${Api.gets}';
    }else{
       url = '${Api.getWarungLocation}/${Api.gets}';
    }
    

    String? responseBody = await AppRequest.post(
      url,
      {
        'nik': idUser,
        'kdKecamatan': kdKecamatan,
        'dataSearch': dataSearch,
        },
    );
    if (responseBody != null) {
      Map result = jsonDecode(responseBody);
      if (result['success']) {
        List list = result['data'];
        return list.map((e) => ListMerchant.fromJson(e)).toList();
      }
      return [];
    }
    return [];
  }

  static Future<List<ListApotek>> search(String query) async {
    String url = '${Api.pesertaDtks}/${Api.search}';
    String? responseBody = await AppRequest.post(url, {'query': query});
    if (responseBody != null) {
      Map result = jsonDecode(responseBody);
      if (result['success']) {
        List list = result['data'];
        return list.map((e) => ListApotek.fromJson(e)).toList();
      }
      return [];
    }
    return [];
  }

  static Future<List<ListMerchant>> searchMerchant(String query) async {
    String url = '${Api.pesertaDtks}/${Api.search}';
    String? responseBody = await AppRequest.post(url, {'query': query});
    if (responseBody != null) {
      Map result = jsonDecode(responseBody);
      if (result['success']) {
        List list = result['data'];
        return list.map((e) => ListMerchant.fromJson(e)).toList();
      }
      return [];
    }
    return [];
  }

  static Future<bool> add(        
    String nik, 
    String kdTahun, 
    String kdBulan,
    String kdBansos,   
    String kdTahap,
    String kdBatch,
    String kdGelombang, 
    String kdPmks,
    [String? nikSurveyor]    
    ) async {
    String url = '${Api.pesertaDtks}/${Api.add}';
    String? responseBody = await AppRequest.post(url, {
      'nik': nik,
      'kdTahun': kdTahun,
      'kdBulan': kdBulan,   
      'kdBansos': kdBansos,  
      'kdTahap': kdTahap,
      'kdBatch': kdBatch,
      'kdGelombang': kdGelombang,
      'nik_surveyor': nikSurveyor,
      'jenis_pmks': kdPmks,
    });
    if (responseBody != null) {
      Map result = jsonDecode(responseBody);
      if (result['success']) {
        return true;
      } else {
        if (result['message'] == 'nik') {
          DInfo.toastError('Data DTKS belum tersedia');
        }
        DMethod.printTitle('SQL : ', result['message'] ); 
        return false;
      }
    }

    return false;
  }

  static Future<bool> update(
    String nik, 
    String tahun, 
    String bulan, 
    String kdBansos,
    String kdTahap,
    String kdBatch,
    String kdGelombang,
    ) async {
    String url = '${Api.pesertaDtks}/${Api.update}';
    String? responseBody = await AppRequest.post(url, {
      'nik': nik,
      'tahun': tahun,
      'bulan': bulan,
      'kdBansos': kdBansos,
      'kdTahap': kdTahap,
      'kdBatch': kdBatch,
      'kdGelombang': kdGelombang,
     

     
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
    String url = '${Api.pesertaDtks}/add_pengajuan.php';

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

  static Future<bool> updateCatatan(String nik, String inputData, String? pencatat) async {
    String url = '${Api.pesertaDtks}/update_catatan.php';
    String? responseBody = await AppRequest.post(url, {
      'nik': nik,
      'inputData': inputData,
      'pencatat': pencatat,     
    });
    if (responseBody != null) {
      Map result = jsonDecode(responseBody);
      String message = result['message'] ?? '';
      if (message == 'nik') {
        DInfo.toastError('Sudah ada pengajuan');
      }
      // return follow success Api
      return result['success'];
    }
    return false;
  }

  static Future<bool> addPengesahan(String nik, String kdPmks, String kdTanggungan) async {
    String url = '${Api.pesertaDtks}/add_pengesahan.php';

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
        DInfo.toastError('Sudah ada pengesahan');
      }
      // return follow success Api
      return result['success'];
    }
    return false;
  }

  static Future<bool> addPhoto(String nik, String lat, String lng, [XFile? img]) async {
    // String url = '${Api.pesertaDtks}/add_pengesahan.php';
    String url = "${Api.pesertaDtks}/upload_photo.php?nik=$nik&lat=$lat&lng=$lng";

    String? responseBody = await AppRequest.post(url, {
      'nik': nik,
      'img': img,
      'lat': lat,     
      'lng': lng,     
    });
    if (responseBody != null) {
      Map result = jsonDecode(responseBody);
      // if false
      String message = result['message'] ?? '';
      if (message == 'nik') {
        DInfo.toastError('Sudah ada pengesahan');
      }
      // return follow success Api
      return result['success'];
    }
    return false;
  }


  static Future<bool> delete(String idPesertaDtks, String tableName) async {
    String url = '${Api.pesertaDtks}/${Api.delete}';
    String? responseBody = await AppRequest.post(url, {
      'idt': idPesertaDtks,
      'tableName': tableName
      });
    if (responseBody != null) {
      Map result = jsonDecode(responseBody);
      return result['success'];
    }
    return false;
  }

   static Future<bool> deletePhoto(String idPesertaDtks) async {
    String url = '${Api.pesertaDtks}/${Api.delete}';
    String? responseBody = await AppRequest.post(url, {
      'idt': idPesertaDtks
      });
    if (responseBody != null) {
      Map result = jsonDecode(responseBody);
      return result['success'];
    }
    return false;
  }

  static Future<List<DtksImages>> getImage(String nik,String tahun, String bulan, String mode) async {
    String url = '${Api.pesertaDtks}/get_images2.php';
    String? responseBody = await AppRequest.post(
      url,
      {
        'nik': nik, 
        'tahun': tahun,
        'bulan': bulan,
        'mode': mode,
      },
    );
    if (responseBody != null) {
      Map result = jsonDecode(responseBody);
      if (result['success']) {
        List list = result['data'];
        return list.map((e) => DtksImages.fromJson(e)).toList();
      }
      return [];
    }
    return [];
  }

  

  
  
}
