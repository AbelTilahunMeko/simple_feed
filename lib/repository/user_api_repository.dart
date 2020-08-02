import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:simple_feed_app/config/constants.dart';
import 'package:simple_feed_app/model/user_model.dart';

class UserApiRepo{
  final Dio _dio = Dio();
  Logger _logger = Logger();

  Future<UserModel> verifyUser(dataOfUser, token) async {
    String tokenIn = "Bearer $token";
//    _logger.d(tokenIn);
    _dio.options.headers['content-Type'] = 'application/json';
    _dio.options.headers["authorization"] = tokenIn;

    try{
      Response response = await _dio.post(CONSTANTS.verifyAccount, data: dataOfUser);
      _logger.d("Succesfully got the response " + response.data.toString());
      return UserModel.fromJson(response.data);
    }catch (error, stacktrace){
      _logger.d("Exception occured: $error stackTrace: $stacktrace");
      return UserModel.withError("$error");
    }
  }

  Future logoutUser(token) async {
    try{
      _dio.options.headers['content-Type'] = 'application/json';
      _dio.options.headers["authorization"] = "Bearer $token";
      Response response = await _dio.post(CONSTANTS.logout);
      _logger.d("Succesfully logged out");
      return response.data;
    }catch(error){
      _logger.d("There is an error on logout " + error.toString());

    }
  }

}