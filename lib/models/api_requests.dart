import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;


String baseUrl='https://codoctor.onrender.com/api';

class Api {
  Future<dynamic> get({required String url, String? token}) async {
    Map<String, String> headers = {};

    if (token != null) {
      headers.addAll({'Authorization': 'Bearer $token','Content-Type': 'application/json'});
    }
    http.Response response = await http.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception(
          'there is a problem with status code ${response.statusCode}');
    }
  }
  Future<dynamic> getMap({required String url, String? token,required String name}) async {
    Map<String, String> headers = {};

    if (token != null) {
      headers.addAll({'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
      });
    }
    http.Response response = await http.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      return jsonDecode(response.body)[name];
    } else {
      throw Exception(
          'there is a problem with status code ${response.statusCode}');
    }
  }

  Future<dynamic> post(
      {required String url,
      @required dynamic body,
      String? token}) async {
    Map<String, String> headers = {};

    if (token != null) {
      headers.addAll({'Authorization': 'Bearer $token','Content-Type': 'application/json'
      
      });
    }
    http.Response response =
        await http.post(Uri.parse(url), body: body, headers: headers);
    if (response.statusCode == 200||response.statusCode == 201) {
      Map<String, dynamic> data = jsonDecode(response.body);

      return data;
    } else {
      throw Exception(
          'there is a problem with status code ${response.statusCode} with body ${jsonDecode(response.body)}');
    }
  }
  Future<http.Response> postRes(
      {required String url,
      @required dynamic body,
      String? token}) async {
    Map<String, String> headers = {};

    if (token != null) {
      headers.addAll({'Authorization': 'Bearer $token','Content-Type': 'application/json'
      
      });
    }
    http.Response response =
        await http.post(Uri.parse(url), body: body, headers: headers);
    if (response.statusCode == 200||response.statusCode == 201) {
      Map<String, dynamic> data = jsonDecode(response.body);

      return response;
    } else {
      throw Exception(
          'there is a problem with status code ${response.statusCode} with body ${jsonDecode(response.body)}');
    }
  }

  Future<dynamic> put(
      {required String url,
      @required dynamic body,
      @required String? token}) async {
    Map<String, String> headers = {};
    headers.addAll({'Content-Type': 'application/x-www-form-urlencoded'});
    if (token != null) {
      headers.addAll({'Authorization': 'Bearer $token'});
    }

    print('url = $url body = $body token = $token ');
    http.Response response =
        await http.put(Uri.parse(url), body: body, headers: headers);
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      print(data);
      return data;
    } else {
      throw Exception(
          'there is a problem with status code ${response.statusCode} with body ${jsonDecode(response.body)}');
    }
  }
}
