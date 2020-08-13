import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http_parser/http_parser.dart';
import 'package:meta/meta.dart';

import 'package:simple_feed_app/config/constants.dart';
import 'package:simple_feed_app/util/http_client.dart';

class DioHttpClient implements HttpClient {
  static const authorizationKey = "authorization";

  final Dio _dio;

  DioHttpClient({@required String baseUrl})
      : _dio =
            Dio(BaseOptions(baseUrl: baseUrl, responseType: ResponseType.json));

  @override
  void addTokenToHeader(String token) {
    _dio.options.headers[authorizationKey] = "Bearer $token";
  }

  @override
  void removeTokenToHeader() {
    _dio.options.headers.remove(authorizationKey);
  }

  @override
  Future<T> get<T>(String path,
      {Map<String, dynamic> queryParameters, onReceiveProgress}) async {
    var response = await _dio.get(path,
        queryParameters: queryParameters, onReceiveProgress: onReceiveProgress);
    return response.data;
  }

  @override
  Future<T> post<T>(String path,
      {data,
      Map<String, dynamic> queryParameters,
      onSendProgress,
      onReceiveProgress}) async {
    var response = await _dio.post(path,
        data: data,
        queryParameters: queryParameters,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress);
    return (response.data);
  }

  @override
  Future<T> put<T>(String path,
      {Map<String, dynamic> queryParameters,
      onSendProgress,
      data,
      onReceiveProgress}) async {
    var response = await _dio.put(path,
        data: data,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
        queryParameters: queryParameters);
    return (response.data);
  }

  @override
  Future<T> multiPartPost<T>(
    String path, {
    @required Map data,
    @required List files,
    String tag = 'image',
    progressCallback,
  }) async {
    FormData formData = FormData.fromMap(data);
    for (var file in files) {
      String fileName = file.path.split('/').last;
      formData.files.add(
        MapEntry(
          tag,
          await MultipartFile.fromFile(
            file.path,
            filename: fileName,
            contentType: MediaType.parse("multipart/form-data"),
          ),
        ),
      );
    }
    return post<T>(path, data: formData);
  }
}
