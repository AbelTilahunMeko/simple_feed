import 'package:dio/dio.dart';
import 'package:simple_feed_app/config/constants.dart';
import 'package:simple_feed_app/service/dio_configration.dart';
import 'package:simple_feed_app/model/user_model.dart';
import 'package:simple_feed_app/service/logger.dart';

class UserApiRepo{


  Future<UserModel> verifyUser(dataOfUser) async {
    try{
      Response response = await dio.getDio().post(CONSTANTS.verifyAccount, data: dataOfUser);
      return UserModel.fromJson(response.data);
    }catch (error, stacktrace){
      logger.d("Exception occured: $error stackTrace: $stacktrace");
      return UserModel.withError("$error");
    }
  }

  Future logoutUser() async {
    try{
      Response response = await dio.getDio().post(CONSTANTS.logout);
      logger.d("Succesfully logged out");
      return response.data;
    }catch(error){
      logger.d("There is an error on logout " + error.toString());

    }
  }

}