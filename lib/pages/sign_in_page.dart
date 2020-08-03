import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:simple_feed_app/bloc/firebase_auth_bloc.dart';
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
  TextEditingController _phoneFieldController = TextEditingController();

  bool _errorHappened = false;

  backArrowPressed() {
    FirebaseAuthBloc.instance.codeSentStreamController.sink
        .add(false); //TODO remember to change this to false
  }

  @override
  void initState(){
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
                body:!showLoading? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset('assets/chat_image.png', width: 150, height: 150,),
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
                      child:
                          Text("Somthing happeded... Please try again later"),
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
                            child: TextFormField(
                              decoration:
                                  InputDecoration(hintText: "9126821##"),
                              controller: _phoneFieldController,
                              keyboardType: TextInputType.number,
                              style: TextStyle(fontSize: 22),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                      width: MediaQuery.of(context).size.width,
                      child: RaisedButton(
                        color: CONSTANTS.primaryColor,
                        child: Text(
                          "Sign In",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        onPressed: () {
                          if (_phoneFieldController.text.isEmpty) {
                            FocusScope.of(context).requestFocus(FocusNode());
                            SnackBarWidget().displaySnackBar(context,
                                _scaffoldKey, "Please input you phone number");
                          } else if (_phoneFieldController.text.length < 9) {
                            FocusScope.of(context).requestFocus(FocusNode());
                            SnackBarWidget().displaySnackBar(context,
                                _scaffoldKey, "Phone number too short.");
                          } else if (_phoneFieldController.text.length > 9) {
                            FocusScope.of(context).requestFocus(FocusNode());
                            SnackBarWidget().displaySnackBar(context,
                                _scaffoldKey, "Phone number too long.");
                          } else {
                            FocusScope.of(context).requestFocus(FocusNode());
//                  ProgressDialog().createDialogProcess(context);
                            String phoneNumber;
                            if (_phoneFieldController.text.startsWith("251")) {
                              phoneNumber = _phoneFieldController.text;
                            } else if (_phoneFieldController.text
                                .startsWith("09")) {
                              phoneNumber = _phoneFieldController.text
                                  .replaceFirst("09", "2519");
                            } else if (_phoneFieldController.text
                                .startsWith("9")) {
                              phoneNumber = "251" + _phoneFieldController.text;
                            }
                            setState(() {
                              showLoading = true;
                            });
                            FirebaseAuthBloc.instance.phoneNumber = "+" + phoneNumber;
                            FirebaseAuthBloc.instance.sendVerificationCode("+" + phoneNumber);
                          }

                        },
                      ),
                    )
                  ],
                ):Container(child: LoadingWidget(),),
              ):VerificationPage(
          backArrowPressed: backArrowPressed,
        );
      },
    );
  }
}
