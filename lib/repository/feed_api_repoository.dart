import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:simple_feed_app/config/constants.dart';
import 'package:simple_feed_app/model/all_feeds_model.dart';

class FeedApiRepo{
  final Dio _dio = Dio();
  Logger _logger = Logger();

  Future<AllFeeds> getAllFeeds(String token, String pageNumber) async {

    try{
      _dio.options.headers['content-Type'] = 'application/json';
      _dio.options.headers["authorization"] = "Bearer $token";

      Response response = await _dio.get(CONSTANTS.feed+"$pageNumber");
      return AllFeeds.fromJson(response.data);
    }catch(error, stacktrace){
      _logger.d("Error fetching " + error.toString() + "\nThe stacktarce " + stacktrace.toString());
      return AllFeeds.withErrors(error.toString());
    }
  }
}