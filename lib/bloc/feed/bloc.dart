import 'dart:async';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_feed_app/bloc/feed/feed_repo_api_abstract.dart';
import 'package:simple_feed_app/bloc/feed/repo.dart';
import 'package:simple_feed_app/model/all_feeds_model.dart';
import 'package:simple_feed_app/util/logger.dart';

class FeedBloc extends Cubit<AllFeeds> {
  File imageFile;
  final FeedApiRepo _feedApiRepo;

  FeedBloc({FeedApiRepository feedApiRepository}): _feedApiRepo = feedApiRepository, super(null);


  Future fetchAllFeeds({ String pageNumber, bool initialLoad: true}) async {
    if (pageNumber == "") {
      pageNumber = "1";
    }

    AllFeeds allFeeds = await _feedApiRepo.getAllFeeds(pageNumber);
    if (initialLoad) {
      emit(allFeeds);
    } else {
      return allFeeds;
    }
  }

  Future uploadFeedToDB(String caption) async {
    await _feedApiRepo.uploadFeedToDatabase(imageFile, caption).catchError((e) {
      logger.d("There is an error " + e.toString());
    });
    fetchAllFeeds(pageNumber: "1", initialLoad: true);

    return true;
  }
}
