import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';

abstract class Internet {
  static final Map<String, String> headersCook = {'Accept': 'application/json'};
  static final Map<String, String> headersCookPut = {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
  };

  static String rawwCookie = "";

  //obtener verssion de aplicativio
  static Future<String> getAppVersion() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    print(info.version);
    return info.version;
  }

  ///Peticion por Post
  static Future httpPost(
      {required String url,
      required Map<String, dynamic> body,
      bool timeOut = false,
      required int seconds}) async {
    try {
      debugPrint("service from $url");
      final queryUrl = Uri.parse(url);
      debugPrint("send $body to $url");
      final response = timeOut
          ? await http.post(queryUrl,
              body: body,
              headers: {"Accept": "*/*"}).timeout(Duration(seconds: seconds))
          : await http.post(queryUrl, body: body, headers: {"Accept": "*/*"});
      debugPrint("response  ${response.statusCode} from $url");
      var decodedData = json.decode(response.body);

      debugPrint("response  $decodedData from $url");

      return decodedData;
    } on TimeoutException catch (e) {
      return {
        'valor': '0',
        'message': 'Límite de tiempo de espera excedido.',
        'exception': e
      };
    } catch (e) {
      return {
        'valor': '0',
        'message': 'Ocurrió un error, vuelva a intentarlo.',
        'exception': e
      };
    }
  }

  ///Peticion tipo Get
  static Future httpGet({required String url, required String body}) async {
    try {
      final queryUrl = Uri.encodeFull(url) + body + '?overview=false';
      print('queryUrl  $queryUrl');
      final response = await http.get(Uri.parse(queryUrl));
      var decodedData = json.decode(response.body);
      return decodedData;
    } on TimeoutException catch (e) {
      return {
        'valor': 0,
        'message': 'Límite de tiempo de espera excedido.',
        'exception': e
      };
    } catch (e) {
      return {
        'valor': '0',
        'message': 'Ocurrió un error, vuelva a intentarlo.',
        'exception': e
      };
    }
  }

  static Future httpPost2(
      {required String url,
      required Map<String, dynamic> body,
      bool timeOut = false,
      required int seconds}) async {
    try {
      final queryUrl = Uri.parse(url);
      final response = timeOut
          ? await http.post(queryUrl,
              body: body,
              headers: {"Accept": "*/*"}).timeout(Duration(seconds: seconds))
          : await http.post(queryUrl, body: body, headers: {"Accept": "*/*"});
      var decodedData = json.decode(response.body);
      return decodedData;
    } on TimeoutException catch (e) {
      return {
        'status': 'error',
        'message': 'Límite de tiempo de espera excedido.',
        'exception': e
      };
    } catch (e) {
      return {
        'status': 'error',
        'message': 'Ocurrió un error, vuelva a intentarlo.',
        'exception': e
      };
    }
  }

  static Future httpPost3(
      {required String url,
      required Map<String, dynamic> body,
      bool timeOut = false,
      required int seconds}) async {
    try {
      debugPrint("service from $url");

      final queryUrl = Uri.parse(url);
      debugPrint("send $body to $url");

      final response = timeOut
          ? await http.post(queryUrl,
              body: body,
              headers: {"Accept": "*/*"}).timeout(Duration(seconds: seconds))
          : await http.post(queryUrl, body: body, headers: {"Accept": "*/*"});
      debugPrint("response  ${response.statusCode} from $url");
      var decodedData = json.decode(response.body);

      debugPrint("response  $decodedData from $url");
      return decodedData;
    } on TimeoutException catch (e) {
      return {
        'value': null,
        'message': 'Límite de tiempo de espera excedido.',
        'exception': e
      };
    } catch (e) {
      return {
        'value': null,
        'message': 'Ocurrió un error, vuelva a intentarlo.',
        'exception': e
      };
    }
  }

  static Future httpPostcookRow({
    required String url,
    required Map<String, dynamic> body,
    bool timeOut = false,
  }) async {
    int seconds = 0;
    debugPrint("Request to $url");
    debugPrint("Send $body to $url");
    try {
      final queryUrl = Uri.parse(url);
      final headers = Map<String, String>.from(headersCook);
      headers['Content-Type'] = 'application/json';
      final response = timeOut
          ? await http
              .post(queryUrl, body: json.encode(body), headers: headers)
              .timeout(Duration(seconds: seconds))
          : await http.post(queryUrl,
              body: json.encode(body), headers: headers);
      var decodedData = json.decode(response.body);

      debugPrint("Request status code ${response.statusCode} from $url");
      debugPrint("Request response $decodedData from $url");
      return decodedData;
    } on TimeoutException catch (e) {
      return {
        'valor': '0',
        'message': 'Límite de tiempo de espera excedido.',
        'exception': e
      };
    } catch (e) {
      return {
        'valor': '0',
        'message': 'Ocurrió un error, vuelva a intentarlo.',
        'exception': e
      };
    }
  }

  /// httpos and get with cookies
  static Future httpPostcook(
      {required String url,
      required Map<String, dynamic> body,
      bool timeOut = false}) async {
    int seconds = 0;
    debugPrint("Request to $url");
    debugPrint("Send $body to $url");
    try {
      final queryUrl = Uri.parse(url);
      final response = timeOut
          ? await http
              .post(queryUrl, body: body, headers: headersCook)
              .timeout(Duration(seconds: seconds))
          : await http.post(queryUrl, body: body, headers: headersCook);
      var decodedData = json.decode(response.body);
      //updateCookie(response, headersCook);
      debugPrint("Request status code ${response.statusCode} from $url");
      debugPrint("Request response $decodedData from $url");
      return decodedData;
    } on TimeoutException catch (e) {
      return {
        'valor': '0',
        'message': 'Límite de tiempo de espera excedido.',
        'exception': e
      };
    } catch (e) {
      return {
        'valor': '0',
        'message': 'Ocurrió un error, vuelva a intentarlo.',
        'exception': e
      };
    }
  }

  static Future httpGetcook(
      {required String url, bool timeOut = false, String body = ''}) async {
    int seconds = 0;
    try {
      final queryUrl = Uri.encodeFull(url) + body + '?overview=false';
      final response = timeOut
          ? await http
              .get(Uri.parse(queryUrl), headers: headersCook)
              .timeout(Duration(seconds: seconds))
          : await http.get(Uri.parse(queryUrl), headers: headersCook);
      //updateCookie(response, headersCook);
      var decodedData = json.decode(response.body);
      return decodedData;
    } on TimeoutException catch (e) {
      return {
        'valor': '0',
        'message': 'Límite de tiempo de espera excedido.',
        'exception': e
      };
    } catch (e) {
      return {
        'valor': '0',
        'message': 'Ocurrió un error, vuelva a intentarlo.',
        'exception': e
      };
    }
  }

  static Future httpPutcook({
    required String url,
    bool timeOut = false,
    required String body,
  }) async {
    int seconds = 0;
    print('put');
    headersCookPut['cookie'] = headersCook['cookie'].toString();
    try {
      final queryUrl = Uri.parse(url);
      final response = timeOut
          ? await http
              .put(queryUrl, body: body, headers: headersCookPut)
              .timeout(Duration(seconds: seconds))
          : await http.put(queryUrl, body: body, headers: headersCookPut);
      var decodedData = json.decode(response.body);
      //updateCookie(response, headersCookPut);
      return decodedData;
    } on TimeoutException catch (e) {
      return {
        'valor': '0',
        'message': 'Límite de tiempo de espera excedido.',
        'exception': e
      };
    } catch (e) {
      return {
        'valor': '0',
        'message': 'Ocurrió un error, vuelva a intentarlo.',
        'exception': e
      };
    }
    /*   var f = await http.put(
      url,
      //headers: headers,
      body: comments,//jsonEncode(comments),
    );*/
  }

  // static updateCookie(http.Response response, header) {
  //   String rawCookie = response.headers['set-cookie'] ?? '';
  //   if (header.containsKey("cookie") == false) {
  //     if (rawCookie != '') {
  //       int index = rawCookie.indexOf(';');
  //       header['cookie'] =
  //           (index == 1) ? rawCookie : rawCookie.substring(0, index);
  //       rawwCookie = header['cookie'];
  //       prefs.cookie = rawwCookie;
  //     }
  //   }
  //   print("0000000");
  //   print(rawwCookie);
  // }

  // static Future httpFile({required String url, file}) async {
  //   Dio dio = new Dio();
  //   final uri = Uri.parse(url);
  //   FormData formData = new FormData.fromMap({"files": file});

  //   Response response = await dio.post(url, data: formData);
  //   return response.data['url'];
  // }

  // static Future httpFile2({required String url, file}) async {
  //   Dio dio = new Dio();
  //   final uri = Uri.parse(url);
  //   FormData formData = new FormData.fromMap({"file": file});

  //   Response response = await dio.post(url, data: formData);
  //   return response.data['url'];
  // }
}
