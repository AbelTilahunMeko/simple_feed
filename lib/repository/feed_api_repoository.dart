import 'package:dio/dio.dart';
import 'package:simple_feed_app/config/constants.dart';
import 'package:simple_feed_app/model/all_feeds_model.dart';
import 'package:simple_feed_app/util//logger.dart';
import 'package:simple_feed_app/util/dio_provider.dart';

class FeedApiRepo{
  Future<AllFeeds> getAllFeeds(String pageNumber) async {

    try{
      Response response = await dio.get(CONSTANTS.feed+"$pageNumber");
      return AllFeeds.fromJson(response.data);
    }catch(error){
      logger.d("Error fetching " + error.toString());
      return AllFeeds.withErrors(error.toString());
    }
  }
}