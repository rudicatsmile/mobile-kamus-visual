import 'dart:convert';
import 'package:d_info/d_info.dart';
import '../../config/api.dart';
import '../../config/app_request.dart';
import '../model/caleg.dart';
import '../model/data_dashboard.dart';
import '../model/data_tim.dart';


class SourceCaleg {
  static Future<int> count() async {
    String url = '${Api.caleg}/${Api.count}';
    String? responseBody = await AppRequest.gets2(url,{});   //Edited
    if (responseBody != null) {
      Map result = jsonDecode(responseBody);
      return result['data'];
    }
    return 0;
  }

  static Future<List<Caleg>> gets() async {
    String url = '${Api.caleg}/${Api.gets}';

    String? responseBody = await AppRequest.gets2(url,
    {}     //Edited
    );
    if (responseBody != null) {
      Map result = jsonDecode(responseBody);
      if (result['success']) {
        List list = result['data'];
        return list.map((e) => Caleg.fromJson(e)).toList();
      }
      return [];
    }
    return [];
  }

  static Future<List<Caleg>> getsAll(String kodePartai,String kodeTps) async {
    String url = '${Api.caleg}/${Api.getsAll}';
    String? responseBody = await AppRequest.gets2(url ,
    {
       'Kode_Partai': kodePartai,
       'Kode_Tps': kodeTps,
    }//Edited
    );
    if (responseBody != null) {
      Map result = jsonDecode(responseBody);
      if (result['success']) {
        List list = result['data'];
        return list.map((e) => Caleg.fromJson(e)).toList();
      }
      return [];
    }
    return [];
  }

  static Future<List<Caleg>> getCaleg(String kodeDaerah,String kodeKecamatan) async {
    String url = '${Api.dashboard}/${Api.getcountKelurahan}';
    String? responseBody = await AppRequest.post(
      url,
      {'kodeDaerah': kodeDaerah, 'kodeKecamatan': kodeKecamatan},
    );
    if (responseBody != null) {
      Map result = jsonDecode(responseBody);
      if (result['success']) {
        List list = result['data'];
        return list.map((e) => Caleg.fromJson(e)).toList();
      }
      return [];
    }
    return [];
  }

  //  static Future<List<HistoryBantuan>> getHistorybantuan(String idt) async {
  //   String url = '${Api.rootUrl}/${Api.gethistorybantuan}';
  //   String? responseBody = await AppRequest.post(
  //     url,
  //     {'idt': idt},
  //   );
  //   if (responseBody != null) {
  //     Map result = jsonDecode(responseBody);
  //     if (result['success']) {
  //       List list = result['data'];
  //       return list.map((e) => HistoryBantuan.fromJson(e)).toList();
  //     }
  //     return [];
  //   }
  //   return [];
  // }

  static Future<List<DataTim>> getDataTim(String kelompok) async {
    String url = '${Api.rootUrl}/${Api.getdatatim}';
    String? responseBody = await AppRequest.post(
      url,
      {'kelompok': kelompok},
    );
    if (responseBody != null) {
      Map result = jsonDecode(responseBody);
      if (result['success']) {
        List list = result['data'];
        return list.map((e) => DataTim.fromJson(e)).toList();
      }
      return [];
    }
    return [];
  }

  static Future<int> getCountOfTim() async {
    String url = '${Api.dashboard}/${Api.countOfTim}';
    String? responseBody = await AppRequest.gets2(url,
    {});   
    if (responseBody != null) {
      Map result = jsonDecode(responseBody);
      return result['data'];
    }
    return 20;
  }

  static Future<List<DataDashboard>> getDataDashboard() async {
    String url = '${Api.dashboard}/${Api.getdatadashboard}';
    String? responseBody = await AppRequest.gets2(url,
    {}     
    );
    if (responseBody != null) {
      Map result = jsonDecode(responseBody);
      if (result['success']) {
        List list = result['data'];
        return list.map((e) => DataDashboard.fromJson(e)).toList();
      }
      return [];
    }
    return [];
  }

   static Future<bool> tampil5(String code) async {
    String url = '${Api.caleg}/${Api.tampil}';
    String? responseBody = await AppRequest.post(url, {
      'code': code,
    });
    if (responseBody != null) {
      Map result = jsonDecode(responseBody);
      return result['success'];
    }
    return false;
  }


  static Future<bool> add(Caleg caleg) async {
    String url = '${Api.caleg}/${Api.add}';
    String? responseBody = await AppRequest.post(url, {
      'Kode_Partai': '',
      'Kode_Caleg': caleg.kode,
      'Kode_Tps': caleg.kodeTps,
      'Kode_Relawan': '',
      'Input_Suara': caleg.kodeTps,
      'Pencatat': '',
      'Mode_Catat': '',
    });
    if (responseBody != null) {
      Map result = jsonDecode(responseBody);
      // if false
      String message = result['message'] ?? '';
      if (message == 'code') {
        DInfo.toastError('Code already used');
      }
      // return follow success Api
      return result['success'];
    }
    return false;
  }

  static Future<bool> add2(kodePartai,kodeCaleg,kodeTps,inputSuara,pencatat,modeCatat) async {
    String url = '${Api.caleg}/${Api.add}';
    String? responseBody = await AppRequest.post(url, {
      'Kode_Partai': kodePartai,
      'Kode_Caleg': kodeCaleg,
      'Kode_Tps': kodeTps,
      'Kode_Relawan': '',
      'Input_Suara': inputSuara,
      'Pencatat': pencatat,
      'Mode_Catat': modeCatat,
    });
    if (responseBody != null) {
      Map result = jsonDecode(responseBody);
      // if false
      String message = result['message'] ?? '';
      if (message == 'code') {
        DInfo.toastError('Code already used');
      }
      // return follow success Api
      return result['success'];
    }
    return false;
  }

  static Future<bool> retrieveTps(kodeTps,inputData,pencatat,modeCatat) async {
    String url = '${Api.caleg}/${Api.retrieveTps}';
    String? responseBody = await AppRequest.post(url, {      
      'Kode_Tps': kodeTps,
      'Kode_Relawan': '',
      'Input_Data': inputData,
      'Pencatat': pencatat,
      'Mode_Catat': modeCatat,
    });
    if (responseBody != null) {
      Map result = jsonDecode(responseBody);
      // if false
      String message = result['message'] ?? '';
      if (message == 'code') {
        DInfo.toastError('Code already used');
      }
      // return follow success Api
      return result['success'];
    }
    return false;
  }

  static Future<bool> update(String oldCode, Caleg caleg) async {
    String url = '${Api.caleg}/${Api.update}';
    String? responseBody = await AppRequest.post(url, {
      'Kode_Partai': '',
      'Kode_Caleg': caleg.kode,
      'Kode_Tps': caleg.kodeTps,
      'Kode_Relawan': '',
      'Input_Suara': caleg.kodeTps,
      'Pencatat': '',
      'Mode_Catat': '',
    });
    if (responseBody != null) {
      Map result = jsonDecode(responseBody);
      // if false
      String message = result['message'] ?? '';
      if (message == 'code') {
        DInfo.toastError('Code already used');
      }
      // return follow success Api
      return result['success'];
    }
    return false;
  }

  static Future<bool> delete(String code) async {
    String url = '${Api.caleg}/${Api.delete}';
    String? responseBody = await AppRequest.post(url, {
      'code': code,
    });
    if (responseBody != null) {
      Map result = jsonDecode(responseBody);
      return result['success'];
    }
    return false;
  }

  static Future<int> stock(String code) async {
    String url = '${Api.caleg}/stock.php';
    String? responseBody = await AppRequest.post(url, {'code': code});
    if (responseBody != null) {
      Map result = jsonDecode(responseBody);
      if (result['success']) {
        return result['data'];
      }
      return 0;
    }
    return 0;
  }

  static Future<bool> tampil(String code) async {
    String url = '${Api.caleg}/${Api.tampil}';
    String? responseBody = await AppRequest.post(url, {
      'code': code,
    });
    if (responseBody != null) {
      Map result = jsonDecode(responseBody);
      return result['success'];
    }
    return false;
  }
}
