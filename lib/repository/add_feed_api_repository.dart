import 'package:dio/dio.dart';
import 'package:simple_feed_app/config/constants.dart';
import 'package:simple_feed_app/util/dio_provider.dart';

class AddFeedApiRepo{
  Future<Response> uploadFeed(String token, Map<String, dynamic> data) async {
    Response response = await dio.post(CONSTANTS.post);
    return response;
  }
}