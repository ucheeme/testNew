import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class AppUtils{
  static void debug(dynamic msg){
    if (kDebugMode) {
      print(msg);
    }
  }
  static void showSnack(String msg, BuildContext? context){
    CherryToast.error(toastDuration: const Duration(seconds: 2),
        animationType: AnimationType.fromTop,
        title:   Text(msg)
    ).show(context!);
  }
  static void showSuccessSnack(String msg, BuildContext? context){
    CherryToast.success(
        animationType: AnimationType.fromTop,
        title:   Text(msg,)
    ).show(context!);
  }
  static void showInfoSnack(String msg, BuildContext? context){
    CherryToast.info(
        animationType: AnimationType.fromTop,
        title:   Text(msg)
    ).show(context!);
  }
}