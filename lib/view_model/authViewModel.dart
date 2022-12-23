import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_mvvm_architecture/model/user_model.dart';
import 'package:flutter_mvvm_architecture/repository/authReposirty.dart';
import 'package:flutter_mvvm_architecture/utils/general_utils.dart';
import 'package:flutter_mvvm_architecture/utils/routes/routesName.dart';
import 'package:flutter_mvvm_architecture/view_model/userViewModel.dart';

class AuthViewModel with ChangeNotifier {
  final _myRepo = AuthReposirty();

  bool _loading = false;
  bool get loading => _loading;

  bool _signUploading = false;
  bool get signUploading => _signUploading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  setSignupLoading(bool value) {
    _signUploading = value;
    notifyListeners();
  }

  Future<void> loginApiModel(dynamic data, BuildContext context) async {
    setLoading(true);
    _myRepo.loginApi(data).then((value) {
      setLoading(false);
      Utils.customSnackBar("Login Successful", context);
      UserViewModel().saveUser(UserModel(
        token: value['token'].toString(),
      ));
      if (kDebugMode) {
        print("value is here as ${value['token'].toString()}");
      }
      Navigator.pushNamed(context, RoutesName.home);
    }).onError((error, stackTrace) {
      setLoading(false);
      Utils.customFlush("Error", error.toString(), context);
      if (kDebugMode) {
        print("Error is here as ${error.toString()}");
      }
    });
  }

  Future<void> registerApiModel(dynamic data, BuildContext context) async {
    setSignupLoading(true);
    _myRepo.registerApi(data).then((value) {
      setSignupLoading(false);
      Utils.customSnackBar("Sign Up Successful", context);
      if (kDebugMode) {
        print("value is here as ${value.toString()}");
      }
      Navigator.pushNamed(context, RoutesName.home);
    }).onError((error, stackTrace) {
      setSignupLoading(false);
      Utils.customFlush("Error", error.toString(), context);
      if (kDebugMode) {
        print("Error is here as ${error.toString()}");
      }
    });
  }
}
