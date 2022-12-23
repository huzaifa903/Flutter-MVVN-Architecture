import 'dart:io';

import 'package:flutter_mvvm_architecture/data/network/baseApiServices.dart';
import 'package:flutter_mvvm_architecture/data/network/networkApiServices.dart';
import 'package:flutter_mvvm_architecture/model/movieList_model.dart';

import '../resources/appUrls.dart';

class HomeRepository {
  BaseApiServices _apiServices = NetApiServices();

  Future<MoviewListModel> fetchMovieList() async {
    try {
      dynamic response = await _apiServices.getGetApiResponse(AppUrl.movieUrl);
      return response = MoviewListModel.fromJson(response);
    } catch (e) {
      throw Exception("login api error $e");
    }
  }
}
