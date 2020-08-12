import 'dart:io';

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:simple_feed_app/bloc/feed/feed_repo_api_abstract.dart';
import 'package:simple_feed_app/config/constants.dart';
import 'package:simple_feed_app/model/all_feeds_model.dart';
import 'package:simple_feed_app/util/dio_provider.dart';
import 'package:http_parser/http_parser.dart';
import 'package:simple_feed_app/util/http_client.dart';
import 'package:simple_feed_app/util/logger.dart';

class FeedApiRepo implements FeedApiRepository {

  final HttpClient _httpClient;

  FeedApiRepo({HttpClient httpClient}): assert (httpClient!=null), _httpClient = httpClient;
  @override
  Future<AllFeeds> getAllFeeds(String pageNumber) async {
    try {
      var response = await _httpClient.get<Map>(CONSTANTS.feed + "$pageNumber");
      return AllFeeds.fromJson(response);
    } catch (error, stacktrace) {
      logger.d("Error fetching " +
          error.toString() +
          "\nThe stacktarce " +
          stacktrace.toString());
      return AllFeeds.withErrors(error.toString());
    }
  }

  @override
  Future<void> uploadFeedToDatabase(File file, String caption) async {
    String fileName = file.path.split('/').last;
    FormData formData =  FormData.fromMap({
      "image": await MultipartFile.fromFile(
        file.path,
        filename: fileName,
        contentType: MediaType.parse("multipart/form-data"),
      ),
      "caption": caption
    });

    Response response;
    try {
      response = await _httpClient.post(CONSTANTS.post, data: formData);
    } catch (error, stacktrace) {
      response = null;
      logger.d("There is an error uploading " + error.toString() + "\n####Stack" + stacktrace.toString());
    }
    if (response != null) {
      logger.d("I have succesfully uploaded the data");
    }
  }
}
