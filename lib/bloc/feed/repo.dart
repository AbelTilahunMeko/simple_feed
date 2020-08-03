import 'dart:io';

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:simple_feed_app/config/constants.dart';
import 'package:simple_feed_app/model/all_feeds_model.dart';
import 'package:simple_feed_app/util/dio_provider.dart';
import 'package:http_parser/http_parser.dart';
import 'package:simple_feed_app/util/logger.dart';

class FeedApiRepo {


  Future<AllFeeds> getAllFeeds(String pageNumber) async {
    try {
      Response response = await dio.get(CONSTANTS.feed + "$pageNumber");
      return AllFeeds.fromJson(response.data);
    } catch (error, stacktrace) {
      logger.d("Error fetching " +
          error.toString() +
          "\nThe stacktarce " +
          stacktrace.toString());
      return AllFeeds.withErrors(error.toString());
    }
  }

  Future<Response> uploadFeedToDatabase(File file, String caption) async {
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
      response = await dio.post(CONSTANTS.post, data: formData);
    } catch (error, stacktrace) {
      response = null;
      logger.d("There is an error uploading " + error.toString() + "\n####Stack" + stacktrace.toString());
    }
    if (response != null) {
      logger.d("I have succesfully uploaded the data");
    }
    return response;
  }
}
