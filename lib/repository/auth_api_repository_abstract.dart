import 'package:simple_feed_app/model/user_model.dart';

abstract class AuthApiRepository{
  Future<UserModel> verifyUser(dataOfUser);
  Future logoutUser();
}