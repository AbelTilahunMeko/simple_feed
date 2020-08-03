import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:simple_feed_app/util/logger.dart';


class DioProvider {
  final Dio dio = Dio();
  static final DioProvider instance = DioProvider._();
  DioProvider._();

  Future<String> get _getCurrentUserToken async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    var tokenId = await user.getIdToken();
    return tokenId.token;
  }

  init() async {
//    dio.options.baseUrl = CONSTANTS.baseURL;
    dio.options.headers['content-type'] = 'application/json';
    dio.options.headers["authorization"] = "Bearer ${await _getCurrentUserToken}";
    return true;
  }
}

Dio get dio => DioProvider.instance.dio;
