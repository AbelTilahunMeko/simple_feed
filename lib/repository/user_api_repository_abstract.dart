import 'package:simple_feed_app/model/user_model.dart';

abstract class UserApiRepository{
  Future<UserModel> verifyUser(dataOfUser);
  Future logoutUser();
}