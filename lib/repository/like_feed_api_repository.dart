import 'package:dio/dio.dart';
import 'package:simple_feed_app/config/constants.dart';
import 'package:simple_feed_app/util//logger.dart';
import 'package:simple_feed_app/util/dio_provider.dart';

class FeedLikeApiRepo{

  Future<Response> likeFeed(String feedId) async{
    Response response;
    try{
      response = await dio.put(CONSTANTS.like+ "/$feedId");
    }catch(error){
      logger.d("There is an error " + error.toString());
      response = null;
    }
    return response;
  }

  Future<Response> unlikeFeed( String feedId)async{
    Response response;
    try{
      response = await dio.put(CONSTANTS.unlike+ "/$feedId");
    }catch(error){
      logger.d("There is an error " + error.toString());
      response = null;
    }
    logger.d("The response of " + response.toString());

    return response;
  }
}