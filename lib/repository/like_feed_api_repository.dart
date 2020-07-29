import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:simple_feed_app/config/constants.dart';

class FeedLikeApiRepo{
  final Dio _dio = Dio();
  Logger _logger = Logger();

  Future<Response> likeFeed(String token, String feedId) async{
    _dio.options.headers['content-Type'] = 'application/json';
    _dio.options.headers["authorization"] = "Bearer $token";
    Response response;
    try{
      response = await _dio.put(CONSTANTS.like+ "/$feedId");
    }catch(error){
      _logger.d("There is an error " + error.toString());
      response = null;
    }
    return response;
  }

  Future<Response> unlikeFeed(String token, String feedId)async{
    _dio.options.headers['content-Type'] = 'application/json';
    _dio.options.headers["authorization"] = "Bearer $token";
    Response response;
    try{
      response = await _dio.put(CONSTANTS.unlike+ "/$feedId");
    }catch(error){
      _logger.d("There is an error " + error.toString());
      response = null;
    }
    _logger.d("The response of " + response.toString());

    return response;
  }
}