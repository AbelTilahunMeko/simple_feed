import 'package:meta/meta.dart';
import 'package:simple_feed_app/model/user_model.dart';
import 'package:simple_feed_app/repository/auth_api_repository_abstract.dart';
import 'package:simple_feed_app/repository/user_repository/user_api_repository.dart';
import 'package:simple_feed_app/util/http_client.dart';

class UserApiRepo implements UserApiRepository{
  static const String userPath = '/users';
  final HttpClient _httpClient;
  UserApiRepo({@required HttpClient httpClient}): assert(httpClient!=null), _httpClient = httpClient;

  @override
  Future<UserModel> getUserProfile() async {
    // TODO: implement getUserProfile
    var data = await _httpClient.get<Map>(userPath);
    return UserModel.fromJson(data);
  }

  @override
  Future updateUserProfile() {
    // TODO: implement updateUserProfile
    throw UnimplementedError();
  }

}