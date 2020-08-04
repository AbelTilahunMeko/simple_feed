import 'package:rxdart/rxdart.dart';
import 'package:simple_feed_app/bloc/feed/like_feed_api_repository.dart';
import 'package:simple_feed_app/model/feed_model.dart';

class PostBloc {
  String get feedId => _singleFeedsStreamController.value.id;
  PostBloc(FeedModel model): _singleFeedsStreamController = BehaviorSubject<FeedModel>.seeded(model);

  final FeedLikeApiRepo _feedLikeApiRepo = FeedLikeApiRepo();

  BehaviorSubject<FeedModel> _singleFeedsStreamController;
  BehaviorSubject<FeedModel> get singleFeedsStreamController => _singleFeedsStreamController;

  likeFeed() async {
    var currentFeedValue = _singleFeedsStreamController.value;

    await _feedLikeApiRepo.likeFeed(feedId);

    var updateFeedValue = currentFeedValue.copyWith(
      isLiked: true,
      likes: currentFeedValue.likes +1,
    );

    _singleFeedsStreamController.sink.add(updateFeedValue);

  }

  dislikeFeed() async {
    var currentFeedValue = _singleFeedsStreamController.value;

    await _feedLikeApiRepo.unlikeFeed(feedId);
    var updateFeedValue = currentFeedValue.copyWith(
      isLiked: false,
      likes: currentFeedValue.likes -1,
    );

    _singleFeedsStreamController.sink.add(updateFeedValue);
  }
}


