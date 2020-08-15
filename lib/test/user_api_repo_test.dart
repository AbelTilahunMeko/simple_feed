import 'package:simple_feed_app/model/user_model.dart';
import 'package:test/test.dart';
import 'package:mockito/mockito.dart';
import 'package:simple_feed_app/repository/user_repository/user_api_repo.dart';
import 'package:simple_feed_app/util/http_client.dart';

class MockHttpClient extends Mock implements HttpClient {}

void main() {
  test('Fetch user Profile ', () async {
    var httpClient = MockHttpClient();
    when(httpClient.get(UserApiRepo.userPath))
        .thenAnswer((_) async => <String, dynamic>{});
    var repo = UserApiRepo(httpClient: httpClient);
    var user = await repo.getUserProfile();
    expect(user, isNotNull);
    verify(httpClient.get(UserApiRepo.userPath));
  });
}
