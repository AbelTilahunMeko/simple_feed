import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:simple_feed_app/model/user_model.dart';
import 'package:simple_feed_app/pages/home_page.dart';
import 'package:simple_feed_app/pages/sign_in_page.dart';
import 'package:simple_feed_app/pages/verification_page.dart';
import 'package:simple_feed_app/repository/repository.dart';
import 'dart:async';

import 'package:simple_feed_app/util/dio_provider.dart';
import 'package:simple_feed_app/util/logger.dart';

class FirebaseAuthBloc {
  static FirebaseAuthBloc instance = FirebaseAuthBloc._();

  FirebaseAuthBloc._();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  static String verificationId;
  String phoneNumber;

  Future<String> get token async {
    var user = await FirebaseAuth.instance.currentUser();
    var idToken = await user.getIdToken();
    return idToken.token;
  }

  Repository _userRepository = Repository();


  Future logoutUser() async {}

  verifyUser() async {
    Map<String, dynamic> data = {
      'phoneNumber': phoneNumber,
    };
    UserModel userModel = await _userRepository.verifyUser(data);
    //TODO emit this but creating it's own bloc.
  }

  signOut() async {
    await _auth.signOut();
    await _userRepository.logoutUser();
    logger.d("########DONE DONE########");
//    Get.to(SignInPage());
  }

  Future sendVerificationCode() {
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
    try {
      await _auth.signInWithCredential(authCredential).catchError((e){
        logger.d("There is an error " + e.toString());
      });
      await DioProvider.instance.init();
      logger.d("########DONE DONE DONE SHould########");

//      Get.to(HomePage());
      verifyUser();
    } catch (e) {
      logger.d(e);
    }
  }

  _verificationFailed(AuthException authException) {
    Get.snackbar("Verification Failed",authException.message.toString());
    logger.d("verifcation failed " + authException.message.toString());
  }

  void _verificationCodeSent(String verificationIdIn, [code]) {
    logger.d("CODE SENT ");
    Get.to(VerificationPage());
//    codeSentStreamController.sink.add(true);
    verificationId = verificationIdIn;
  }

  void _phoneCodeRetrievalTimeOut(String verificationIdIn) {
    verificationId = verificationIdIn;
  }

  Future<FirebaseUser> checkCurrentUser() {
    return _auth.currentUser();
  }

  Future verifyCode(String code) async {
    final AuthCredential credential = PhoneAuthProvider.getCredential(
        verificationId: verificationId, smsCode: code);
    return _verificationCompleted(credential);
  }
}
