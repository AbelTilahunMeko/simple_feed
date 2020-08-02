import 'package:dio/dio.dart';
import 'package:simple_feed_app/config/constants.dart';
import 'package:simple_feed_app/model/user_model.dart';
import 'package:simple_feed_app/util//logger.dart';
import 'package:simple_feed_app/util/dio_provider.dart';

class UserApiRepo{


  Future<UserModel> verifyUser(dataOfUser) async {
    try{
      Response response = await dio.post(CONSTANTS.verifyAccount, data: dataOfUser);
      return UserModel.fromJson(response.data);
    }catch (error){
      logger.d("Exception occured: $error");
      return UserModel.withError("$error");
    }
  }

  Future logoutUser() async {
    try{
      Response response = await dio.post(CONSTANTS.logout);
      logger.d("Succesfully logged out");
      return response.data;
    }catch(error){
      logger.d("There is an error on logout " + error.toString());

    }
  }

}