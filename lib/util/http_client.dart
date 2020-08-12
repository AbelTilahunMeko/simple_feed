import 'package:dio/dio.dart';

abstract class HttpClient {
  void addTokenToHeader(String token);
  void removeTokenToHeader();

  Future<Response<T>> post<T>(
    String path, {
    data,
    Map<String, dynamic> queryParameters,
    ProgressCallback onSendProgress,
    ProgressCallback onReceiveProgress,
  });
  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic> queryParameters,
    ProgressCallback onSendProgress,
  });
  Future<Response<T>> put<T>(
    String path, {
    Map<String, dynamic> queryParameters,
    ProgressCallback onSendProgress,
    ProgressCallback onReceiveProgress,
  });
  Future<Response<T>> multiPartPost<T>(
    String path, {
    Map data,
    List files,
    String params = 'image',
    ProgressCallback progressCallback,
  });
}
