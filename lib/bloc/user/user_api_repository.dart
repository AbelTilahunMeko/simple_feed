import 'package:simple_feed_app/model/user_model.dart';

abstract class UserApiRepository{
  Future<UserModel> getUserProfile();
  Future<UserModel> updateUserProfile(UpdateProfilePayload data);
}