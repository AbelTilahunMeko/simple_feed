import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:simple_feed_app/config/constants.dart';
import 'package:simple_feed_app/model/user_model.dart';
import 'package:simple_feed_app/bloc/user/user_api_repo.dart';
import 'package:simple_feed_app/util/http_client/http_client.dart';

import 'placehoder_data/user_response_data.dart';

class MockHttpClient extends Mock implements HttpClient {}

void main() {
  var mockHttpClient = MockHttpClient();

  test('Fetch user Profile ', () async {
    when(mockHttpClient.get(
      CONSTANTS.baseURL + CONSTANTS.userPath,
    )).thenAnswer((_) async => userData);
    var repo = UserApiRepo(httpClient: mockHttpClient);
    var user = await repo.getUserProfile();
    expect(user.userName.toLowerCase(), "habib23me");
    verify(mockHttpClient.get(CONSTANTS.baseURL + CONSTANTS.userPath));
  });

  test("Update user profile", () async {
    UpdateProfilePayload body = UpdateProfilePayload(name: "abel", username: "beltm", bio: "I'm the bio");

    when(mockHttpClient.put(CONSTANTS.baseURL + CONSTANTS.updateProfile,
            data: body))
        .thenAnswer((_) async => body.toJson());
    var repo = UserApiRepo(httpClient: mockHttpClient);
    UserModel updatedProfile = await repo.updateUserProfile(body);
    expect(updatedProfile.name, "abel");
  });
}
