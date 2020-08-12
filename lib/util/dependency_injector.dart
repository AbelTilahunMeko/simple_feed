import 'package:get_it/get_it.dart';
import 'package:simple_feed_app/bloc/feed/bloc.dart';
import 'package:simple_feed_app/bloc/feed/feed_repo_api_abstract.dart';
import 'package:simple_feed_app/bloc/feed/like_feed_api_abstract.dart';
import 'package:simple_feed_app/bloc/feed/like_feed_api_repository.dart';
import 'package:simple_feed_app/bloc/feed/repo.dart';
import 'package:simple_feed_app/config/constants.dart';
import 'package:simple_feed_app/repository/user_api_repository.dart';
import 'package:simple_feed_app/repository/user_api_repository_abstract.dart';
import 'package:simple_feed_app/util/http_client.dart';

import 'dio_provider.dart';

getIt<T>() => GetIt.instance.get<T>();

class DependencyInjection {
  static void registerAllDependencies() {
    GetIt.instance.registerSingleton<HttpClient>(
        DioHttpClient(baseUrl: CONSTANTS.baseURL));

    GetIt.instance
        .registerSingleton<UserApiRepository>(UserApiRepo(httpClient: getIt()));

    GetIt.instance.registerSingleton<FeedLikeApiRepository>(
        FeedLikeApiRepo(httpClient: getIt()));

    GetIt.instance
        .registerSingleton<FeedApiRepository>(FeedApiRepo(httpClient: getIt()));

    GetIt.instance.registerSingleton<FeedBloc>(FeedBloc(
      feedApiRepository: getIt(),
    ));
  }
}
