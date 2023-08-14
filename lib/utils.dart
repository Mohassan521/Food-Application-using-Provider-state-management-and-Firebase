import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:fluttertoast/fluttertoast.dart';


class Utils{

  static toastMessage(String message) {
    Fluttertoast.showToast(
        msg: message,
        timeInSecForIosWeb: 3,
        // backgroundColor: const Color(0xAA000000)
        backgroundColor: Colors.green,
        textColor: Colors.white,
        toastLength: Toast.LENGTH_LONG);
  }

  static ErrorMessage(String message) {
    Fluttertoast.showToast(
        msg: message,
        timeInSecForIosWeb: 3,
        // backgroundColor: const Color(0xAA000000)
        backgroundColor: Colors.green,
        textColor: Colors.white,
        toastLength: Toast.LENGTH_LONG);
  }

  static flushbarErrorMessage(String message, BuildContext context) {
    showFlushbar(context: context,
        flushbar: Flushbar(
          forwardAnimationCurve: Curves.decelerate,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          padding: const EdgeInsets.all(15),
          message: message,
          flushbarPosition: FlushbarPosition.BOTTOM,
          duration: const Duration(seconds: 5),
          backgroundColor: Colors.red,
          reverseAnimationCurve: Curves.easeInOut,
          positionOffset: 20,
          icon: const Icon(Icons.error, size: 20, color: Colors.white,),
        )..show(context)
    );
  }
}


