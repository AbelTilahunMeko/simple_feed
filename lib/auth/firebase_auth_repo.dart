import 'package:firebase_auth/firebase_auth.dart';
import 'package:simple_feed_app/bloc/bloc.dart';
import 'package:simple_feed_app/model/user_model.dart';
import 'package:simple_feed_app/repository/repository.dart';
import 'dart:async';

import 'package:simple_feed_app/service/logger.dart';

class FirebaseAuthBloc {
  bool userSignIn = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  static String verificationId;
  String phoneNumber;

  String token;

  Repository _userRepository = Repository();
  StreamController<UserModel> userAccount = StreamController.broadcast();

  void dispose() {
    userAccount.close();
  }

  logoutUser() {
    _userRepository.logoutUser();
  }

  Future getCurrentUserToken() async {
    FirebaseUser user = await _auth.currentUser();
    var token = await user.getIdToken();
    bloc.token = token.token;
  }

  verifyUser(Map<String, dynamic> data) async {
    userSignIn = true;
    UserModel userModel = await _userRepository.verifyUser(data);
    userAccount.sink.add(userModel);
  }

  signOut() async {
    logger.d("The user logged out succesfuly");
    await _auth.signOut();
    logoutUser();
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
    AuthResult authResult = await _auth.signInWithCredential(authCredential);
    if (authResult != null) {
      var idToken = await authResult.user.getIdToken();
      final tokenOfUser = idToken.token;
      token = tokenOfUser;
      logger.d("Succsfull Completed " + token.toString());
      logger.d("The user in " + authResult.user.uid);

      Map<String, dynamic> verifyBody = {
        'phoneNumber': phoneNumber,
      };
      verifyUser(verifyBody);
    }
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
//    logger.d("Verification id" + verificationId);

    final AuthCredential credential = PhoneAuthProvider.getCredential(
        verificationId: verificationId, smsCode: code);

    Map<String, dynamic> verifyBody = {
      'phoneNumber': phoneNumber,
    };

    AuthResult authResult = await _auth.signInWithCredential(credential);
    if (authResult != null) {
      var idToken = await authResult.user.getIdToken();
      final tokenOfUser = idToken.token;
      token = tokenOfUser;
      verifyUser(verifyBody);
    }
  }
}
