import 'package:dio/dio.dart';
import 'package:simple_feed_app/config/constants.dart';

class AddFeedApiRepo{
  final Dio _dio = Dio();

  Future<Response> uploadFeed(String token, Map<String, dynamic> data) async {
    _dio.options.headers['content-Type'] = 'application/json';
    _dio.options.headers["authorization"] = "Bearer $token";

    Response response = await _dio.post(CONSTANTS.post);
    return response;
  }
}