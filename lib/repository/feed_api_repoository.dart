import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:simple_feed_app/config/constants.dart';
import 'package:simple_feed_app/model/all_feeds_model.dart';
import 'package:simple_feed_app/util/dio_provider.dart';

class FeedApiRepo {
  Logger _logger = Logger();

  Future<AllFeeds> getAllFeeds(String pageNumber) async {
    try {
      Response response = await dio.get(CONSTANTS.feed + "$pageNumber");
      return AllFeeds.fromJson(response.data);
    } catch (error, stacktrace) {
      _logger.d("Error fetching " +
          error.toString() +
          "\nThe stacktarce " +
          stacktrace.toString());
      return AllFeeds.withErrors(error.toString());
    }
  }
}
