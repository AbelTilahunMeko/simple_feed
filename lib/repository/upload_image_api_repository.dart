import 'dart:io';

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:simple_feed_app/config/constants.dart';

class UploadFeedApiRepo {
  final Dio _dio = Dio();
  Logger _logger = Logger();

  Future<Response> uploadImage(File file, String token, String caption) async {
    _dio.options.headers['content-Type'] = 'application/json';
    _dio.options.headers["authorization"] = "Bearer $token";

    String fileName = file.path.split('/').last;
    FormData formData = FormData.fromMap({
      "image": await MultipartFile.fromFile(file.path, filename: fileName),
      "caption": caption
    });
    Response response;
    try {
      response = await _dio.post(CONSTANTS.post, data: formData);
    } catch (error) {
      response = null;
    }
    if (response != null) {
      _logger.d("I have succesfully uploaded the data");
    }
    return response;
  }
}
