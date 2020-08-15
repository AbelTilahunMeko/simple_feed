import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:simple_feed_app/config/constants.dart';
import 'package:simple_feed_app/model/user_model.dart';
import 'package:simple_feed_app/repository/user_repository/user_api_repo.dart';
import 'package:simple_feed_app/util/http_client.dart';

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
    Map<String, dynamic> data = {"bio": "I am the bio", "name": "Abel", "username": "beltm"};
    var body = json.encode(data);

    when(mockHttpClient.put(CONSTANTS.baseURL + CONSTANTS.updateProfile,
            data: body))
        .thenAnswer((_) async => data);
    var repo = UserApiRepo(httpClient: mockHttpClient);
    UserModel updatedProfile = await repo.updateUserProfile(body);
    expect(updatedProfile.name, "Abel");
  });
}
