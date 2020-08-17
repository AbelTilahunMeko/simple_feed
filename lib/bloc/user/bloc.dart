import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_feed_app/bloc/user/user_api_repository.dart';
import 'package:simple_feed_app/model/user_model.dart';

class UserBloc extends Cubit<UserModel> {
  final UserApiRepository _userApiRepository;
  UserBloc({UserApiRepository userApiRepository})
      : _userApiRepository = userApiRepository,
        super(null);

  Future getProfile() async {
    var user = await _userApiRepository.getUserProfile();
    emit(user);
  }

  Future updateProfile(UpdateProfilePayload data) async {
    var user = await _userApiRepository.updateUserProfile(data);
    emit(user);
  }
}
