import 'package:get_it/get_it.dart';
import 'package:simple_feed_app/bloc/feed/bloc.dart';
import 'package:simple_feed_app/bloc/feed/feed_repo_api_abstract.dart';
import 'package:simple_feed_app/bloc/feed/like_feed_api_abstract.dart';
import 'package:simple_feed_app/bloc/feed/repo.dart';
getIt<T>() => GetIt.instance.get<T>();

class DependencyInjection{
  static void registerAllDependencies(){
    GetIt.instance.registerSingleton<FeedApiRepository>(FeedApiRepo());
    GetIt.instance.registerSingleton<FeedBloc>(FeedBloc(
      feedApiRepository: getIt(),
    ));

  }
}
