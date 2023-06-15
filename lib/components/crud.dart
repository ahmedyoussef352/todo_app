// ignore_for_file: avoid_print, prefer_const_constructors, depend_on_referenced_packages

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

// ignore: prefer_interpolation_to_compose_strings
String _basicAuth = 'Basic ' + base64Encode(utf8.encode('ahmed:ahmed1357911'));

Map<String, String> myheaders = {'authorization': _basicAuth};

class Crud {
  getRequest(String url) async {
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var responsebody = jsonDecode(response.body);
        return responsebody;
      } else {
        print("Error ${response.statusCode}");
      }
    } catch (e) {
      print("Erroe $e");
    }
  }

  postRequest(String url, Map data) async {
    // await Future.delayed(Duration(seconds: 2));
    try {
      var response =
          await http.post(Uri.parse(url), body: data, headers: myheaders);
      if (response.statusCode == 200) {
        var responsebody = jsonDecode(response.body);
        return responsebody;
        //  return print(responsebody);
      } else {
        print("Error ${response.statusCode}");
      }
    } catch (e) {
      print("Error $e");
    }
  }

  // fetchData(
  //   var url,
  //   Map data,
  // ) async {
  //   final response = await http.post(Uri.parse(url), headers: myheaders);

  //   if (response.statusCode == 200) {
  //     final json = jsonDecode(response.body);
  //     if (json['status'] == 'success') {
  //       final data = json['data'];
  //       // Process the data as needed
  //       print(data);
  //     } else {
  //       // Handle the error case
  //       print('Request failed');
  //     }
  //   } else {
  //     // Handle the HTTP error case
  //     print('HTTP error ${response.statusCode}');
  //   }
  // }

  postRequestWithFile(String url, Map data, File file) async {
    var request = http.MultipartRequest("POST", Uri.parse(url));
    var length = await file.length();
    var stream = http.ByteStream(file.openRead());
    var multipartFile = http.MultipartFile("file", stream, length,
        filename: basename(file.path));
    request.headers.addAll(myheaders);
    request.files.add(multipartFile);
    data.forEach((key, value) {
      request.fields[key] = value;
    });
    var myrequest = await request.send();

    var response = await http.Response.fromStream(myrequest);
    if (myrequest.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print("Error ${myrequest.statusCode}");
    }
  }
}
