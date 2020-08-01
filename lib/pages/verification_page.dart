import 'package:flutter/material.dart';
import 'package:simple_feed_app/bloc/bloc.dart';
import 'package:simple_feed_app/config/theme.dart';
import 'package:simple_feed_app/widgets/snackbar_widget.dart';

class VerificationPage extends StatefulWidget {
  final Function backArrowPressed;

  const VerificationPage({Key key, this.backArrowPressed}) : super(key: key);

  @override
  _VerificationPageState createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  TextEditingController _verificationCodeFieldController =
      TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Pallet.CodGrayTextColor,
          ),
          onPressed: () {
            widget.backArrowPressed();
          },
        ),
      ),
      body: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.verified_user,
                      size: 100,
                      color: Pallet.primaryColor,
                    ),
                    Text(
                      "Verifiy your number",
                      style: TextStyle(
                          fontSize: 21,
                          color: Pallet.CodGrayTextColor,
                          fontWeight: FontWeight.bold),
                    ),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                          text:
                          "We have sent you a six dig code to your phone number ",
                          style: TextStyle(color: Colors.black),
                          children: <TextSpan>[
                            TextSpan(
                                text: bloc.phoneNumber.toString(),
                                style: TextStyle(fontWeight: FontWeight.bold))
                          ]),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 40, top: 60),
                width: MediaQuery.of(context).size.width,
                child: Text(
                  "Verification Code",
                  textAlign: TextAlign.left,
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 40, right: 40, bottom: 10),
                child: TextFormField(
                  maxLength: 6,
                  decoration: InputDecoration(hintText: "******"),
                  controller: _verificationCodeFieldController,
                  keyboardType: TextInputType.number,
                  style: TextStyle(fontSize: 22),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 40, vertical: 5),
                width: MediaQuery.of(context).size.width,
                child: RaisedButton(
                  color: Pallet.primaryColor,
                  child: Text(
                    "Verify",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  onPressed: () {
                    if (_verificationCodeFieldController.text.isEmpty) {
                      FocusScope.of(context).requestFocus(FocusNode());
                      SnackBarWidget().displaySnackBar(
                          context, _scaffoldKey, "Please input verifiction code");
                    } else if (_verificationCodeFieldController.text.length < 6) {
                      FocusScope.of(context).requestFocus(FocusNode());
                      SnackBarWidget().displaySnackBar(
                          context, _scaffoldKey, "Verifiction code too short.");
                    } else if (_verificationCodeFieldController.text.length > 6) {
                      FocusScope.of(context).requestFocus(FocusNode());
                      SnackBarWidget().displaySnackBar(
                          context, _scaffoldKey, "Verifiction code too long.");
                    } else {
                      FocusScope.of(context).requestFocus(FocusNode());
//                  ProgressDialog().createDialogProcess(context);

                      bloc.verifyCode(_verificationCodeFieldController.text);
                    }
//              bloc.verifyCode(code);
                  },
                ),
              )
            ],
          ),
          SizedBox(height: 20,),
        ],
      ),
    );
  }
}
