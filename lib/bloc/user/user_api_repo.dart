import 'package:meta/meta.dart';
import 'package:simple_feed_app/config/constants.dart';
import 'package:simple_feed_app/model/user_model.dart';
import 'package:simple_feed_app/bloc/user/user_api_repository.dart';
import 'package:simple_feed_app/util/http_client/http_client.dart';
import 'package:simple_feed_app/util/logger.dart';

class UserApiRepo implements UserApiRepository {
  final HttpClient _httpClient;
  UserApiRepo({@required HttpClient httpClient})
      : assert(httpClient != null),
        _httpClient = httpClient;

  @override
  Future<UserModel> getUserProfile() async {
    var data = await _httpClient.get<Map>(CONSTANTS.baseURL + CONSTANTS.userPath);
    return UserModel.fromJson(data);
  }

  @override
  Future<UserModel> updateUserProfile(UpdateProfilePayload data) async {
    var updatedUserData =
        await _httpClient.put( CONSTANTS.baseURL + CONSTANTS.updateProfile, data: data);
    logger.d("The data " + updatedUserData.toString());
    return UserModel.fromJson(updatedUserData);
  }
}
