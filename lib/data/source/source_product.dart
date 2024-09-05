import 'dart:convert';
import 'package:d_info/d_info.dart';
import '../../config/api.dart';
import '../../config/app_request.dart';
import '../model/product.dart';

class SourceProduct {
  static Future<int> count() async {
    String url = '${Api.product}/${Api.count}';
    String? responseBody = await AppRequest.gets(url);
    if (responseBody != null) {
      //Output API = {"data":3}
      Map result = jsonDecode(responseBody);
      return result['data'];
    }
    return 0;
  }

  static Future<List<Product>> gets() async {
    String url = '${Api.product}/${Api.gets}';
    String? responseBody = await AppRequest.gets(url);
    if (responseBody != null) {
      //Output API = 
                      /*{
                            "success": true,
                            "data": [
                                {
                                    "code": "ABC12345",
                                    "name": "Coffee ABC 12345",
                                    "stock": "70",
                                    "unit": "Dus",
                                    "price": "50000",
                                    "created_at": "2022-05-17 05:03:42+02:00",
                                    "updated_at": "2023-12-04 10:32:52+00:00"
                                },
                                {
                                    "code": "HGJAUY",
                                    "name": "Monitor",
                                    "stock": "57",
                                    "unit": "Unit",
                                    "price": "2400000",
                                    "created_at": "2022-05-19 01:12:58+02:00",
                                    "updated_at": "2023-12-04 10:38:58+00:00"
                                },
                                {
                                    "code": "JHGAJHSG",
                                    "name": "Headphone",
                                    "stock": "164",
                                    "unit": "Item",
                                    "price": "75000",
                                    "created_at": "2022-05-19 09:46:24+02:00",
                                    "updated_at": "2023-12-04 10:32:52+00:00"
                                }
                            ]
                        }
                      */
      Map result = jsonDecode(responseBody);
      if (result['success']) {
        List list = result['data'];
        return list.map((e) => Product.fromJson(e)).toList();
      }
      return [];
    }
    return [];
  }

  static Future<bool> add(Product product) async {
    String url = '${Api.product}/${Api.add}';
    String? responseBody = await AppRequest.post(url, {
      'code': product.code,
      'name': product.name,
      'stock': product.stock.toString(),
      'unit': product.unit,
      'price': product.price,
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

  static Future<bool> update(String oldCode, Product product) async {
    String url = '${Api.product}/${Api.update}';
    String? responseBody = await AppRequest.post(url, {
      'old_code': oldCode,
      'code': product.code,
      'name': product.name,
      'stock': product.stock.toString(),
      'unit': product.unit,
      'price': product.price,
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
    String url = '${Api.product}/${Api.delete}';
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
    String url = '${Api.product}/stock.php';
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
}
