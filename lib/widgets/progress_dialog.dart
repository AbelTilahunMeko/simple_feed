import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProgressDialog {
  Future<void> createDialogProcess(context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext builder) {
          return AlertDialog(
            content: Row(
              children: <Widget>[
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.deepOrange),
                ),
                SizedBox(
                  width: 20,
                ),
                Text("Proccesing"),
              ],
            ),
          );
        });
  }
}