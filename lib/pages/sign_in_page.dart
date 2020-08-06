import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:logger/logger.dart';
import 'package:simple_feed_app/bloc/firebase_auth_bloc.dart';
import 'package:simple_feed_app/bloc/forms/phone_number_form/phone_form_bloc.dart';
import 'package:simple_feed_app/config/constants.dart';
import 'package:simple_feed_app/pages/verification_page.dart';
import 'package:simple_feed_app/widgets/loading_widget.dart';
import 'package:simple_feed_app/widgets/snackbar_widget.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  Logger logger = Logger();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool showLoading = false;
  final bloc = PhoneNumberFormBloc();
  bool _errorHappened = false;

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  backArrowPressed() {
    showLoading = false;
    FirebaseAuthBloc.instance.codeSentStreamController.sink
        .add(false);
  }

  @override
  void initState() {
    super.initState();
    FirebaseAuthBloc.instance.codeSentStreamController.sink.add(true);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuthBloc.instance.codeSentStreamController.stream,
      builder: (context, snapshot) {
//        logger.d("The data of the stream is " + snapshot.data.toString());
        return snapshot.data == null || !snapshot.data
            ? Scaffold(
                key: _scaffoldKey,
                backgroundColor: Colors.white,
                body: !showLoading
                    ? Column(
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
                                    color: CONSTANTS.lightGrayTextColor,
                                    fontSize: 23),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: " Simple Feed",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: CONSTANTS.CodGrayTextColor)),
                                ]),
                          ),
                          Visibility(
                            visible: _errorHappened,
                            child: Text(
                                "Somthing happeded... Please try again later"),
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
                            margin: EdgeInsets.only(
                                left: 40, right: 40, bottom: 10),
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
                                    decoration:
                                        InputDecoration(hintText: "9126821##"),
                                    keyboardType: TextInputType.number,
                                    style: TextStyle(fontSize: 22),
                                    textFieldBloc: bloc.phoneNumberValidator,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 40, vertical: 10),
                            width: MediaQuery.of(context).size.width,
                            child: RaisedButton(
                                color: CONSTANTS.primaryColor,
                                child: Text(
                                  "Sign In",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                                onPressed: () {
//                                  setState(() {
//                                    showLoading = true;
//                                  });
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                  bloc.submit();
                                }),
                          )
                        ],
                      )
                    : Container(
                        child: LoadingWidget(),
                      ),
              )
            : VerificationPage(
                backArrowPressed: backArrowPressed,
              );
      },
    );
  }
}
