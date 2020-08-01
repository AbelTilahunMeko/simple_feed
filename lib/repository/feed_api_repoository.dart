import 'package:dio/dio.dart';
import 'package:simple_feed_app/config/constants.dart';
import 'package:simple_feed_app/service/dio_configration.dart';
import 'package:simple_feed_app/model/all_feeds_model.dart';
import 'package:simple_feed_app/service/logger.dart';

class FeedApiRepo{
  Future<AllFeeds> getAllFeeds(String pageNumber) async {

    try{
      Response response = await dio.getDio().get(CONSTANTS.feed+"$pageNumber");
      return AllFeeds.fromJson(response.data);
    }catch(error, stacktrace){
      logger.d("Error fetching " + error.toString() + "\nThe stacktarce " + stacktrace.toString());
      return AllFeeds.withErrors(error.toString());
    }
  }
}