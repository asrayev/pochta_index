import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pochta_index/utils/my_colors.dart';

class MyUtils {
  static getMyToast({required String message}) => Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM_RIGHT,
    timeInSecForIosWeb: 1,
    backgroundColor: MyColors.C_1C2632,
    textColor: MyColors.C_8A96A4,
    fontSize: 16.0,
  );
}