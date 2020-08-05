import 'dart:async';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_feed_app/bloc/feed/like_feed_api_repository.dart';
import 'package:simple_feed_app/bloc/feed/repo.dart';
import 'package:simple_feed_app/model/all_feeds_model.dart';
import 'package:simple_feed_app/util/logger.dart';

class FeedBloc extends Cubit<AllFeeds> {

  FeedBloc({AllFeeds allFeeds}):super(allFeeds);

  static final FeedApiRepo _feedApiRepo = FeedApiRepo();

   Future fetchAllFeeds({String pageNumber,  bool initialLoad:true}) async {
    if (pageNumber == "") {
      pageNumber = "1";
    }
    AllFeeds allFeeds = await _feedApiRepo.getAllFeeds(pageNumber);
    if(initialLoad){
      emit(allFeeds);
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
     fetchAllFeeds(pageNumber: "1", initialLoad: true);
    }
    return true;
  }


}
