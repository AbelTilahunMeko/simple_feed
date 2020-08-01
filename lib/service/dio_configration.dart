import 'package:dio/dio.dart';
import 'package:simple_feed_app/bloc/bloc.dart';

class DioRequest {
  Dio getDio() {
    final Dio _dio = Dio();
    _dio.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options) async {
      var customHeaders = {'content-type': 'application/json', "authorization":"Bearer ${bloc.token}"};
      options.headers.addAll(customHeaders);
    }));
    return _dio;
  }
}

final dio = DioRequest();
