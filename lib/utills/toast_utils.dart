import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:obk/utills/global_value.dart';

class ToastUtils {
  static final FToast fToast = FToast(Global.appContext);

  static showBasicToast(String msg) {
    Widget toast = Container(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0), color: const Color.fromRGBO(0, 0, 0, 0.5)),
        child: Text(msg, style: TextStyle(fontSize: 30, color: Colors.white)));

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.CENTER,
      toastDuration: Duration(seconds: 2),
    );
  }

  /// cancel all the toasts call
  static cancelAllToast() {
    Fluttertoast.cancel();
  }
}
