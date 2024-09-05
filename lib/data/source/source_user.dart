import 'dart:convert';

import 'package:d_info/d_info.dart';
import 'package:d_method/d_method.dart';
import '../../config/api.dart';
import '../../config/app_request.dart';
import '../../config/session.dart';
import '../model/user.dart';

class SourceUser {
  static Future<int> count() async {
    String url = '${Api.user}/${Api.count}';
    String? responseBody = await AppRequest.gets(url);
    if (responseBody != null) {
      Map result = jsonDecode(responseBody);
      return result['data'];
    }
    return 0;
  }

  static Future<bool> login(String userId, String password) async {
    String url = '${Api.user}/login.php';
    String? responseBody = await AppRequest.post(url, {
      'userId': userId,
      'password': password,
    });
    if (responseBody != null) {
      Map result = jsonDecode(responseBody);
      if (result['success']) {
        DMethod.printTitle('SourceUser - login', 'Success');
        Map<String, dynamic> userMap = result['data'];
        //User aa = User.fromJson(userMap);
        // print(aa.idUser);
        //DMethod.printTitle('Test - Model', 'test : ${aa.email}');

        Session.saveUser(User.fromJson(userMap));
      } else {
        DMethod.printTitle('SourceUser - login', 'failed');
      }
      return result['success'];
    }

    return false;
  }

  static Future<List<User>> gets() async {
    String url = '${Api.user}/${Api.gets}';
    String? responseBody = await AppRequest.gets(url);
    if (responseBody != null) {
      Map result = jsonDecode(responseBody);
      if (result['success']) {
        List list = result['data'];
        return list.map((e) => User.fromJson(e)).toList();
      }
      return [];
    }
    return [];
  }

  static Future<bool> add(String name, String userId, String password,String nik,String adminTypeValue,
      bool adminUser, bool adminPeserta, bool validator, bool surveyor, bool verifikator, bool adjusment,
      String kdKelurahan
      ) async {
    String url = '${Api.user}/${Api.add}';
    String? responseBody = await AppRequest.post(url, {
      'name': name,      
      'userId': userId,
      'password': password,
      'nik': nik,
      'adminTypeValue': adminTypeValue,
      'adminUser': adminUser.toString(),
      'adminPeserta': adminPeserta.toString(),
      'validator': validator.toString(),
      'surveyor': surveyor.toString(),
      'verifikator': verifikator.toString(),
      'adjusment': adjusment.toString(),
      'kdKelurahan': kdKelurahan.toString(),
    });
    if (responseBody != null) {
      Map result = jsonDecode(responseBody);
      if (result['success']) {
        return true;
      } else {
        if (result['message'] == 'userId') {
          DInfo.toastError('userId sudah digunakan');
        }
        DMethod.printTitle('SQL : ', result['message'] ); 
        return false;
      }
    }

    return false;
  }

  static Future<bool> register(String name, String userId, String password,String telpon,String whatsapp,
                          String kdPropinsi,String kdKabupaten,String kdKecamatan
      ) async {
    String url = '${Api.user}/${Api.register}';
    String? responseBody = await AppRequest.post(url, {
      'name': name,      
      'userId': userId,
      'password': password,
      'telpon': telpon,
      'whatsapp': whatsapp,
      'kdPropinsi': kdPropinsi,
      'kdKabupaten': kdKabupaten,
      'kdKecamatan': kdKecamatan,      
    });
    if (responseBody != null) {
      Map result = jsonDecode(responseBody);
      if (result['success']) {
        return true;
      } else {
        if (result['message'] == 'userId') {
          DInfo.toastError('userId sudah digunakan');
        }
        DMethod.printTitle('SQL : ', result['message'] ); 
        return false;
      }
    }

    return false;
  }

  static Future<bool> delete(String idUser) async {
    String url = '${Api.user}/${Api.delete}';
    String? responseBody = await AppRequest.post(url, {'id_user': idUser});
    if (responseBody != null) {
      Map result = jsonDecode(responseBody);
      return result['success'];
    }
    return false;
  }

  static Future<bool> changePassword(String idUser, String newPassword) async {
    String url = '${Api.user}/change_password.php';
    String? responseBody = await AppRequest.post(
      url,
      {'id_user': idUser, 'password': newPassword},
    );
    if (responseBody != null) {
      Map result = jsonDecode(responseBody);
      return result['success'];
    }
    return false;
  }
}
