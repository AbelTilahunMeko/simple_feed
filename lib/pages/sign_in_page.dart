import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:simple_feed_app/bloc/forms/phone_number_form/phone_form_bloc.dart';
import 'package:simple_feed_app/config/theme.dart';


class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final bloc = PhoneNumberFormBloc();

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'assets/chat_image.png',
            width: 150,
            height: 150,
          ),
          RichText(
            text: TextSpan(
                text: "Welcome to",
                style: TextStyle(
                    color: Pallet.lightGrayTextColor, fontSize: 23),
                children: <TextSpan>[
                  TextSpan(
                      text: " Simple Feed",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Pallet.CodGrayTextColor)),
                ]),
          ),
          SizedBox(
            height: 80,
          ),
          Container(
            margin: EdgeInsets.only(
              left: 40,
            ),
            width: MediaQuery.of(context).size.width,
            child: Text(
              "PHONE NUMBER",
              textAlign: TextAlign.left,
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 40, right: 40, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "+251",
                  style: TextStyle(
                      fontSize: 21,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 3,
                ),
                Expanded(
                  child: TextFieldBlocBuilder(
                    decoration: InputDecoration(hintText: "9126821##"),
                    keyboardType: TextInputType.number,
                    style: TextStyle(fontSize: 22),
                    textFieldBloc: bloc.phoneNumberValidator,
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
            width: MediaQuery.of(context).size.width,
            child: RaisedButton(
                color: Pallet.primaryColor,
                child: Text(
                  "Sign In",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                onPressed: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                  bloc.submit();
                }),
          )
        ],
      ),
    );
  }
}
