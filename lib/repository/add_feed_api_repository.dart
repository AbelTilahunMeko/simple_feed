import 'package:dio/dio.dart';
import 'package:simple_feed_app/config/constants.dart';
import 'package:simple_feed_app/service/dio_configration.dart';

class AddFeedApiRepo{
  Future<Response> uploadFeed(String token, Map<String, dynamic> data) async {
    Response response = await dio.getDio().post(CONSTANTS.post);
    return response;
  }
}