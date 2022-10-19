// ignore_for_file: prefer_conditional_assignment, prefer_const_constructors, unused_element

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/rendering.dart';

import 'package:flutter/material.dart';

class Utility {
  static Utility? utility;

  static Utility? getInstance() {
    if (utility == null) {
      utility = Utility();
    }
    return utility;
  }

  //alert function

  showAlertDialog(
    BuildContext context,
    String title,
    String desc, {
    String? txtBtn,
  }) {
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(desc),
      actions: [
        TextButton(
          onPressed: (() => Navigator.pop(context)),
          child: txtBtn != null ? Text(txtBtn) : Text(""),
        ),
      ],
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => alert,
    );
  }

  Future<String> checkNetwork() async {
    var networkActive = await Connectivity().checkConnectivity();
    if (networkActive == ConnectivityResult.wifi) {
      return "wifi";
    } else if (networkActive == ConnectivityResult.bluetooth) {
      return "bluetooth";
    } else if (networkActive == ConnectivityResult.mobile) {
      return "mobile";
    } else if (networkActive == ConnectivityResult.ethernet) {
      return "ethernet";
    } else if (networkActive == ConnectivityResult.none) {
      return "none";
    }
    return "";
  }
}
