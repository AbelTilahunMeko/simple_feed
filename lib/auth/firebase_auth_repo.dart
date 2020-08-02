import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';
import 'package:simple_feed_app/bloc/bloc.dart';
import 'package:simple_feed_app/model/user_model.dart';
import 'package:simple_feed_app/repository/repository.dart';
import 'dart:async';

import 'package:simple_feed_app/util/dio_provider.dart';

class FirebaseAuthBloc {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  static String verificationId;
  String phoneNumber;
  Logger logger = Logger();
  Future<String> get token async {
    var user = await FirebaseAuth.instance.currentUser();
    var idToken = await user.getIdToken();
    return idToken.token;
  }

  Repository _userRepository = Repository();
  StreamController<UserModel> userAccount = StreamController.broadcast();

  void dispose() {
    userAccount.close();
  }

  logoutUser() async {
    _userRepository.logoutUser(await token);
  }

  verifyUser() async {
    Map<String, dynamic> data = {
      'phoneNumber': phoneNumber,
    };
    UserModel userModel = await _userRepository.verifyUser(data, await token);
    userAccount.sink.add(userModel);
  }

  signOut() {
    logger.d("The user logged out succesfuly" + token.toString());
    _auth.signOut().then((value) {
      logoutUser();
    }).catchError((e) {
      logger.d("There is an error " + e);
    });
  }

  Future sendVerificationCode(String phoneNumber) {
//    logger.d("The phone number " + phoneNumber);
    return _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: Duration(seconds: 5),
        verificationCompleted: _verificationCompleted,
        verificationFailed: _verificationFailed,
        codeSent: _verificationCodeSent,
        codeAutoRetrievalTimeout: _phoneCodeRetrievalTimeOut);
  }

  _verificationCompleted(AuthCredential authCredential) async {
    await _auth.signInWithCredential(authCredential);
    await DioProvider.instance.init();
    verifyUser();
  }

  _verificationFailed(AuthException authException) {
    logger.d("verifcation failed " + authException.message.toString());
  }

  void _verificationCodeSent(String verificationIdIn, [code]) {
    logger.d("CODE SENT ");
    bloc.codeSentStreamController.sink.add(true);
    verificationId = verificationIdIn;
  }

  void _phoneCodeRetrievalTimeOut(String verificationIdIn) {
    verificationId = verificationIdIn;
  }

  Future<FirebaseUser> checkCurrentUser() {
    return _auth.currentUser();
  }

  verifyCode(String code) async {
    final AuthCredential credential = PhoneAuthProvider.getCredential(
        verificationId: verificationId, smsCode: code);
    _verificationCompleted(credential);
  }
}
