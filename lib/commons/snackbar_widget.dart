import 'package:flutter/material.dart';

class SnackBarWidget {
  displaySnackBar(BuildContext context, _scaffoldKey, String message) {
    final snackBar = SnackBar(content: Text(message));
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }
}