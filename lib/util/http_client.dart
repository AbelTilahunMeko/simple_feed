import 'package:dio/dio.dart';

abstract class HttpClient {
  void addTokenToHeader(String token);
  void removeTokenToHeader();

  Future<T> post<T>(
    String path, {
    data,
    Map<String, dynamic> queryParameters,
    ProgressCallback onSendProgress,
    ProgressCallback onReceiveProgress,
  });
  Future<T> get<T>(
    String path, {
    Map<String, dynamic> queryParameters,
    ProgressCallback onReceiveProgress,
  });
  Future<T> put<T>(
    String path, {
    data,
    Map<String, dynamic> queryParameters,
    ProgressCallback onSendProgress,
    ProgressCallback onReceiveProgress,
  });
  Future<T> multiPartPost<T>(
    String path, {
    Map data,
    List files,
    String tag = 'image',
    ProgressCallback progressCallback,
  });
}
