import 'package:d_method/d_method.dart';
import 'package:http/http.dart' as http;

class AppRequest {
  static Future<String?> gets(String url, {Map<String, String>? headers,}) async {
    try {
      var response = await http.get(
        Uri.parse(url),
        headers: headers,
      );
      DMethod.printTitle('try - $url', response.body);
      return response.body;
    } catch (e) {
      DMethod.printTitle('catch - $url', e.toString());
      return null;
    }
  }

  static Future<String?> gets2(
    String url,   
    Object? data,   //Edited
    {
    Map<String, String>? headers,
  }) async {
    try {
      var response = await http.get(
        Uri.parse(url),       
          // aa:aa,
          // bb:bb        
        headers: headers,
      );
      DMethod.printTitle('try - $url', data.toString() );
      return response.body;
    } catch (e) {
      DMethod.printTitle('catch - $url', e.toString());
      return null;
    }
  }

  static Future<String?> post(String url, Object? data, {Map<String, String>? headers,}) async {
    try {
      var response = await http.post(
        Uri.parse(url),
        body: data,
        headers: headers,
      );
      DMethod.printTitle('try - $url', response.body);
      DMethod.printTitle('try - $url', data.toString() );

      return response.body;
    } catch (e) {
      DMethod.printTitle('catch - $url', e.toString());
      return null;
    }
  }
}
