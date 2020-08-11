import 'package:dio/dio.dart';
import 'package:simple_feed_app/bloc/feed/like_feed_api_abstract.dart';
import 'package:simple_feed_app/config/constants.dart';
import 'package:simple_feed_app/util/dio_provider.dart';
import 'package:simple_feed_app/util/logger.dart';

class FeedLikeApiRepo implements FeedLikeApiRepository {

  @override
  Future<void> likeFeed(String feedId) async {
    Response response;
    try {
      response = await dio.put(CONSTANTS.like + "/$feedId");
    } catch (error) {
      logger.d("There is an error " + error.toString());
      response = null;
    }
  }

  @override
  Future<void> unlikeFeed(String feedId) async {
    Response response;
    try {
      response = await dio.put(CONSTANTS.unlike + "/$feedId");
    } catch (error) {
      logger.d("There is an error " + error.toString());
      response = null;
    }
    logger.d("The response of " + response.toString());
  }
}
