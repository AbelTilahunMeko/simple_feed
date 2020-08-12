import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:simple_feed_app/config/constants.dart';
import 'package:simple_feed_app/util/http_client.dart';
import 'package:meta/meta.dart';

class DioHttpClient implements HttpClient {
  final Dio _dio;

  DioHttpClient({@required String baseUrl})
      : _dio =
            Dio(BaseOptions(baseUrl: baseUrl, responseType: ResponseType.json));

  @override
  void addTokenToHeader(String token) {
    _dio.options.headers["authorization"] = "Bearer $token";
  }

  @override
  void removeTokenToHeader() {}
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
    // TODO: implement post
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
      onSendProgress, data,
      onReceiveProgress}) async {
    var response = await _dio.put(path, data: data,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
        queryParameters: queryParameters);
    return (response.data);
  }

  @override
  Future<T> multiPartPost<T>(String path,
      {Map data, List files, String params = 'image', progressCallback}) {
    // TODO: implement multiPartPost
    throw UnimplementedError();
  }
}
