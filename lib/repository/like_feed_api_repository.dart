import 'package:dio/dio.dart';
import 'package:simple_feed_app/config/constants.dart';
import 'package:simple_feed_app/service/dio_configration.dart';
import 'package:simple_feed_app/service/logger.dart';

class FeedLikeApiRepo{

  Future<Response> likeFeed(String feedId) async{
    Response response;
    try{
      response = await dio.getDio().put(CONSTANTS.like+ "/$feedId");
    }catch(error){
      logger.d("There is an error " + error.toString());
      response = null;
    }
    return response;
  }

  Future<Response> unlikeFeed( String feedId)async{
    Response response;
    try{
      response = await dio.getDio().put(CONSTANTS.unlike+ "/$feedId");
    }catch(error){
      logger.d("There is an error " + error.toString());
      response = null;
    }
    logger.d("The response of " + response.toString());

    return response;
  }
}