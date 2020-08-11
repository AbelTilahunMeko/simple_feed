import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_feed_app/bloc/feed/like_feed_api_repository.dart';
import 'package:simple_feed_app/model/feed_model.dart';

class PostBloc extends Cubit<FeedModel> {
  String get feedId => state.id;
  FeedLikeApiRepo _feedLikeApiRepo;

  PostBloc({@required FeedModel model, @required FeedLikeApiRepo feedLikeApiRepo}):_feedLikeApiRepo = feedLikeApiRepo, super(model);


  likeFeed() async {
    await _feedLikeApiRepo.likeFeed(feedId);

    var updateFeedValue = state.copyWith(
      isLiked: true,
      likes: state.likes +1,
    );

    emit(updateFeedValue);

  }

  dislikeFeed() async {

    await _feedLikeApiRepo.unlikeFeed(feedId);
    var updateFeedValue = state.copyWith(
      isLiked: false,
      likes: state.likes -1,
    );

    emit(updateFeedValue);
  }
}


