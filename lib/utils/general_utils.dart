import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils {
  static void customToast(String msg) {
    Fluttertoast.showToast(msg: msg);
  }

  static void customFlush(String title, String msg, BuildContext context) {
    Flushbar(
      message: msg,
      title: title,
      forwardAnimationCurve: Curves.bounceOut,
      // flushbarPosition: FlushbarPosition.TOP,
      icon: const Icon(
        Icons.error,
        color: Colors.red,
        size: 25,
      ),
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(left: 10, right: 10, bottom: 15),
      duration: const Duration(seconds: 5),
    ).show(context);
  }

  static customSnackBar(String msg, BuildContext context) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
      ),
    );
  }

  static focusFormField(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  static double averageRating(List<int> value) {
    var avgRating = 0;

    for (int i = 0; i < value.length; i++) {
      avgRating = avgRating + value[i];
    }

    return double.parse((avgRating / value.length).toStringAsFixed(1));
  }
}
