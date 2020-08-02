import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:simple_feed_app/config/constants.dart';

class DioProvider {
  final Dio dio = Dio();
  static final DioProvider instance = DioProvider._();
  DioProvider._();
  Future<String> get _token async {
    var user = await FirebaseAuth.instance.currentUser();
    var idToken = await user.getIdToken();
    return idToken.token;
  }

  init() async {
    dio.options.baseUrl = CONSTANTS.baseURL;
    dio.options.headers['content-type'] = 'application/json';
    dio.options.headers["authorization"] = "Bearer ${await _token}";
    return true;
  }
}

Dio get dio => DioProvider.instance.dio;
