import 'dart:async';
import 'dart:io';

import 'package:simple_feed_app/bloc/feed/like_feed_api_repository.dart';
import 'package:simple_feed_app/bloc/feed/repo.dart';
import 'package:simple_feed_app/model/all_feeds_model.dart';
import 'package:simple_feed_app/util/logger.dart';

class FeedBloc {
  static FeedBloc instance = FeedBloc._();

  FeedBloc._();

  static final FeedApiRepo _feedApiRepo = FeedApiRepo();
  static final StreamController<AllFeeds> _allFeedsStreamController =
      StreamController.broadcast();
  StreamController<AllFeeds> get allFeedsStreamController =>
      _allFeedsStreamController;

  void dispose() {
//    _uploadCompletedController.close();
    _allFeedsStreamController.close();
    instance = FeedBloc._();
  }

  Future fetchAllFeeds({String pageNumber,  bool initialLoad:true}) async {
    if (pageNumber == "") {
      pageNumber = "1";
    }
    AllFeeds allFeeds = await _feedApiRepo.getAllFeeds(pageNumber);
    if(initialLoad){
      _allFeedsStreamController.sink.add(allFeeds);
    }else{
      return allFeeds;
    }
  }

  Future uploadFeedToDB(File file, String caption) async {
    var value =
        await _feedApiRepo.uploadFeedToDatabase(file, caption).catchError((e) {
      logger.d("There is an error " + e.toString());
    });
    if (value != null) {
      FeedBloc.instance.fetchAllFeeds(pageNumber: "1");
    }
    return true;
  }


}
