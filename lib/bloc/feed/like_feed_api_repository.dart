import 'package:simple_feed_app/bloc/feed/like_feed_api_abstract.dart';
import 'package:simple_feed_app/config/constants.dart';
import 'package:simple_feed_app/util/http_client.dart';
import 'package:simple_feed_app/util/logger.dart';

class FeedLikeApiRepo implements FeedLikeApiRepository {
  final HttpClient _httpClient;
  FeedLikeApiRepo({HttpClient httpClient}): assert(httpClient!=null), _httpClient = httpClient;

  @override
  Future<void> likeFeed(String feedId) async {
    var response;
    try {
      response = await _httpClient.put(CONSTANTS.like + "/$feedId");
    } catch (error) {
      logger.d("There is an error " + error.toString());
      response = null;
    }
  }

  @override
  Future<void> unlikeFeed(String feedId) async {
    var response;
    try {
      response = await _httpClient.put(CONSTANTS.unlike + "/$feedId");
    } catch (error) {
      logger.d("There is an error " + error.toString());
      response = null;
    }
    logger.d("The response of " + response.toString());
  }
}
