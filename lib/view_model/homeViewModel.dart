import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_mvvm_architecture/data/response/api_response.dart';
import 'package:flutter_mvvm_architecture/model/movieList_model.dart';
import 'package:flutter_mvvm_architecture/repository/homeRepository.dart';

class HomeViewModel with ChangeNotifier {
  final _myRepo = HomeRepository();

  ApiResponse<MoviewListModel> movieList = ApiResponse.loading();

  setMovieList(ApiResponse<MoviewListModel> response) {
    movieList = response;
    notifyListeners();
  }

  Future<void> fetchMovieListApi() async {
    setMovieList(ApiResponse.loading());

    _myRepo.fetchMovieList().then((value) {
      setMovieList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setMovieList(ApiResponse.error(error.toString()));
    });
  }
}
