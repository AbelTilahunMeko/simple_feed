import 'package:simple_feed_app/model/user_model.dart';
import 'package:simple_feed_app/util/db/moor_database.dart';

abstract class UserDao{
  Future<void> addUser(UserData data);
  Future<UserData> getProfile(String id);
  Future<void> updateUser(UserData data);
}