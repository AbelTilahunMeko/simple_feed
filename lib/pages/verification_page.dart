import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:simple_feed_app/bloc/firebase_auth_bloc.dart';
import 'package:simple_feed_app/bloc/forms/verification_form/verification_form.dart';
import 'package:simple_feed_app/config/theme.dart';

class VerificationPage extends StatefulWidget {

  @override
  _VerificationPageState createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  final bloc = VerificationFormBloc();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void dispose(){
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
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
                                text: FirebaseAuthBloc.instance.phoneNumber.toString(),
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
                child: TextFieldBlocBuilder(
                  textFieldBloc: bloc.verificationFieldBloc,
                  maxLength: 6,
                  decoration: InputDecoration(hintText: "******"),
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
                      FocusScope.of(context).requestFocus(FocusNode());
                      bloc.submit();
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
