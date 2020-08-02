import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:simple_feed_app/auth/firebase_auth_repo.dart';
import 'package:simple_feed_app/bloc/pick_image_bloc.dart';
import 'package:simple_feed_app/model/all_feeds_model.dart';
import 'package:simple_feed_app/repository/repository.dart';
import 'package:simple_feed_app/util/logger.dart';

//All the bloc is connected with the other.
class BlocIn with FirebaseAuthBloc, PickImageWithBloc {
  StreamController<bool> _codeSentStreamController = StreamController
      .broadcast(); //This stream controller is used for the code.
  StreamController<AllFeeds> _allFeedsStreamController = StreamController
      .broadcast(); //This stream controller is used for getting the feeds.
  StreamController<File> _pickImageStreamController = StreamController
      .broadcast(); //This stream controller is used to getting images.
  StreamController<bool> _uploadCompletedController =
      StreamController.broadcast();
  Repository _repository =
      Repository(); // This is the repo where all the fetching is found.


  void dispose() {
    _codeSentStreamController.close();
    _allFeedsStreamController.close();
    _pickImageStreamController.close();
    _uploadCompletedController.close();
  }

  uploadFeedToDB(File file, String caption) async {
   Response value = await _repository.uploadFeed(file, caption).catchError((e) {
      logger.d("There is an error " + e.toString());
    });

   if (value != null) {
     fetchAllFeeds(pageNumber: "1");
   } else {
     logger.d("There is an error buddy...");
   }
  }

  likeFeed(String feedId) async {
   var value = await _repository.likeFeed(feedId);
   if (value != null) {
     logger.d("I have succesfully updated it" + value.toString());
   }
  }

  dislikeFeed(String feedId) async {
   var value = await _repository.unlikeFeed(token, feedId);
   if (value != null) {
     logger.d("I have succesfully updated it" + value.toString());
   }
  }

  //This method gets the image and adds it to the sink so that the ui can use it.
  pickImage() async {
   File file = await getImage();
   if(file!=null){
     _pickImageStreamController.sink.add(file);
   }
  }

  // Used to fetch all feeds. It has optional argument.
  // Because on refresh we can't call method we pass reference of the method
  Future fetchAllFeeds({String pageNumber, bool initialLoad:true}) async {
    if (pageNumber == "") {
      pageNumber = "1";
    }
    AllFeeds allFeeds = await _repository.getAllFeeds(pageNumber);
    logger.d(allFeeds.feedModel.length.toString() +
        " The length is " +
        allFeeds.page.toString() +
        " PageNumber " +
        pageNumber);
    if (initialLoad) {
      _allFeedsStreamController.sink.add(allFeeds);
    } else {
      return allFeeds;
    }
    _uploadCompletedController.sink.add(false);
  }

  StreamController<AllFeeds> get allFeedsStreamController =>
      _allFeedsStreamController;
  StreamController<File> get pickImageController => _pickImageStreamController;
  StreamController<bool> get codeSentStreamController =>
      _codeSentStreamController;
  StreamController<bool> get uploadCompleteController =>
      _uploadCompletedController;
}

final bloc = BlocIn(); //SO that it can be accessed throughout the application.
