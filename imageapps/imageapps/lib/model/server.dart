// ignore_for_file: constant_identifier_names, unused_import
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'image.dart';

class Services {
  static var url = Uri.parse('https://ibb-image.000webhostapp.com/phpapi/images_api.php');
  // static var url = Uri.parse('https://10.4.53.2/phpapi/images_api.php');
  // Variabuls Applications Connections => PHP MYSQL
  static const _CREATE_TABLE_ACTION = 'CREATE_TABLE';
  static const _ADD_IMAGE_ACTION = 'ADD_IMAGE';
  static const _GET_ALL_IMAGES_ACTION = 'GET_ALL';

  // Function Creat Table In The Database
  static Future<String> creatTable() async {
    try {
      var map = <String, dynamic>{};
      map['action'] = _CREATE_TABLE_ACTION;
      final response = await http.post(url, body: map);
      if (kDebugMode) {
        print('Create Table Response: ${response.body}');
      }
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return 'error';
      }
    } catch (e) {
      return ('Error Exciption: $e');
    }
  }

  //Function To Add Image
  static Future<String> addImage(String imageString) async {
    try {
      var map = <String, dynamic>{};
      map['action'] = _ADD_IMAGE_ACTION;
      map['image_code'] = imageString;

      final response = await http.post(url, body: map);
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return 'error';
      }
    } catch (e) {
      return ('Error Exciption : $e');
    }
  }

  //Function Get All Images In Server
  static Future<List<Images>> getAllPosts() async {
    try {
      var map = <String, dynamic>{};
      map['action'] = _GET_ALL_IMAGES_ACTION;
      final response = await http.post(url, body: map);
      if (kDebugMode) {
        print('Get All Posts: ${response.body}');
      }
      if (200 == response.statusCode) {
        List<Images> list = parseResponse(response.body);
        return list;
      }
    } catch (e) {
      return <Images>[];
    }
    return getAllPosts();
  }

  // Function parseResponse
  static List<Images> parseResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Images>((json) => Images.fromJson(json)).toList();
  }
}
