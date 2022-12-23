import 'package:flutter/foundation.dart';
import 'package:flutter_mvvm_architecture/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserViewModel with ChangeNotifier {
  Future<bool> saveUser(UserModel user) async {
    // This function helps in storing the User Data and in the next fucntion named 'getData'
    // we use that fuction to get data from Shared preferences

    // We can also store the User Object as well
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('token', user.token.toString());
    notifyListeners();

    return true;
  }

  Future<UserModel> getUser() async {
    // In this function we are retriving the data which we stored in local storage
    final prefs = await SharedPreferences.getInstance();
    final String? _token = prefs.getString('token');

    // print("token is here as $_token");

    return UserModel(
      token: _token.toString(),
    );
  }

  Future<bool> remove() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.clear();
    // notifyListeners();
  }
}
