import 'dart:convert';
import 'dart:io';

import 'package:flutter_mvvm_architecture/data/app_exceptions.dart';
import 'package:flutter_mvvm_architecture/data/network/baseApiServices.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class NetApiServices extends BaseApiServices {
  @override
  Future getGetApiResponse(String url) async {
    dynamic responseJson;

    try {
      final response =
          await http.get(Uri.parse(url)).timeout(const Duration(seconds: 10));

      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException("No Internet Connection");
    }
    return responseJson;
  }

  @override
  Future getPostApiResponse(String url, data) async {
    dynamic responseJson;
    try {
      Response response = await http
          .post(
            Uri.parse(url),
            body: data,
          )
          .timeout(const Duration(seconds: 10));

      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException("No Internet Connection");
    }
    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;

      case 400:
        throw BadRequestException(
            "Invalid Request ${response.statusCode.toString()}");

      case 404:
        throw UnauthorizeException(response.statusCode.toString());

      case 500:

      default:
        throw FetchDataException(
            "Error Occured ${response.statusCode.toString()}");
    }
  }
}
