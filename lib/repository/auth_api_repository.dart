import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:simple_feed_app/config/constants.dart';
import 'package:simple_feed_app/model/user_model.dart';
import 'package:simple_feed_app/repository/auth_api_repository_abstract.dart';
import 'package:simple_feed_app/util/dio_provider.dart';
import 'package:simple_feed_app/util/http_client/http_client.dart';
import 'package:simple_feed_app/util/logger.dart';

class AuthApiRepo implements AuthApiRepository{
  final HttpClient _httpClient;
  AuthApiRepo({HttpClient httpClient}): assert(httpClient !=null), _httpClient = httpClient;

  @override
  Future<UserModel> verifyUser(dataOfUser) async {

    try{
      Response response = await _httpClient.post(CONSTANTS.verifyAccount, data: dataOfUser);
      logger.d("Succesfully got the response " + response.data.toString());
      return UserModel.fromJson(response.data);
    }catch (error){
      logger.d("Exception occured: $error");
      return UserModel.withError("$error");
    }
  }

  @override
  Future logoutUser() async {
    try{
      Response response = await _httpClient.post(CONSTANTS.logout);
      logger.d("Succesfully logged out");
      return response.data;
    }catch(error){
      logger.d("There is an error on logout " + error.toString());

    }
  }

}