import 'package:flutter_mvvm_architecture/data/network/baseApiServices.dart';
import 'package:flutter_mvvm_architecture/data/network/networkApiServices.dart';
import 'package:flutter_mvvm_architecture/resources/appUrls.dart';

class AuthReposirty {
  BaseApiServices _apiServices = NetApiServices();

  Future<dynamic> loginApi(dynamic data) async {
    try {
      dynamic response =
          await _apiServices.getPostApiResponse(AppUrl.loginUrl, data);
      return response;
    } catch (e) {
      throw Exception("login api error $e");
    }
  }

  Future<dynamic> registerApi(dynamic data) async {
    try {
      dynamic response =
          await _apiServices.getPostApiResponse(AppUrl.registerUrl, data);
      return response;
    } catch (e) {
      throw Exception("Resgister api error $e");
    }
  }
}
