import 'dart:io';

import 'package:dio/dio.dart';
import 'package:simple_feed_app/config/constants.dart';
import 'package:simple_feed_app/service/dio_configration.dart';
import 'package:http_parser/http_parser.dart';
import 'package:simple_feed_app/service/logger.dart';


class UploadFeedApiRepo {

  Future<Response> uploadImage(File file, String caption) async {

    String fileName = file.path.split('/').last;
    FormData formData = FormData.fromMap({
      "image": await MultipartFile.fromFile(file.path, filename: fileName, contentType: MediaType.parse("multipart/form-data")),
      "caption": caption
    });
    Response response;
    try {
      response = await dio.getDio().post(CONSTANTS.post, data: formData);
    } catch (error) {
      response = null;
    }
    if (response != null) {
      logger.d("I have succesfully uploaded the data");
    }
    return response;
  }
}
