import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:simple_feed_app/bloc/user/bloc.dart';
import 'package:simple_feed_app/bloc/user/user_api_repository.dart';
import 'package:simple_feed_app/model/user_model.dart';

class MockUserRepository extends Mock implements UserApiRepository {}

void main() {
  var mockedRepo = MockUserRepository();
  var bloc = UserBloc(userApiRepository: mockedRepo);
  var user = UserModel(userName: "Abel", followers: 1231);

  test('getting the profile data after the repo updates state ', () async {
    when(mockedRepo.getUserProfile()).thenAnswer((_) async => user);
    expectLater(bloc, emits(user));
    await bloc.getProfile();
  });
  
  test('updating the profile of the user and checking it emits the state', () async{
    UpdateProfilePayload data = UpdateProfilePayload(
        name: "abel", username: "beltm", bio: "I'm the bio");
    when(mockedRepo.updateUserProfile(data)).thenAnswer((_)  async => user);
    expectLater(bloc, emits(user));
    await bloc.updateProfile(data);
  });
}
