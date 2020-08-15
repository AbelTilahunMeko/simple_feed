import 'package:simple_feed_app/model/user_model.dart';
import 'package:simple_feed_app/repository/auth_api_repository.dart';

class Repository {
  //The repo is used to connect every API feed with the bloc.
  AuthApiRepo _userApiRepo = AuthApiRepo();
  Future<UserModel> verifyUser(Map<String, dynamic> data) {
    return _userApiRepo.verifyUser(data);
  }

  Future logoutUser() {
    return _userApiRepo.logoutUser();
  }
}
