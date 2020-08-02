import 'dart:async';
import 'dart:io';

import 'package:logger/logger.dart';
import 'package:simple_feed_app/auth/firebase_auth_repo.dart';
import 'package:simple_feed_app/bloc/pick_image_bloc.dart';
import 'package:simple_feed_app/model/all_feeds_model.dart';
import 'package:simple_feed_app/repository/repository.dart';

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

  Logger _logger = Logger();

  void dispose() {
    _codeSentStreamController.close();
    _allFeedsStreamController.close();
    _pickImageStreamController.close();
    _uploadCompletedController.close();
  }

  uploadFeedToDB(File file, String caption) {
    _repository.uploadFeed(file, caption).then((value) {
      if (value != null) {
        fetchAllFeeds(pageNumber: "1");
      } else {
        logger.d("There is an error buddy...");
      }
    }).catchError((e) {
      _logger.d("There is an error " + e.toString());
    });
  }

  likeFeed(String feedId) {
    _repository.likeFeed(feedId).then((value) {
      if (value != null) {
        logger.d("I have succesfully updated it" + value.toString());
      }
    }).catchError((e) {
      logger.d("There is an error " + e.toString());
    });
  }

  dislikeFeed(String feedId) {
    _repository.unlikeFeed(feedId).then((value) {
      if (value != null) {
        logger.d("I have succesfully updated it" + value.toString());
      }
    }).catchError((e) {
      logger.d("There is an error " + e.toString());
    });
  }

  //This method gets the image and adds it to the sink so that the ui can use it.
  pickImage() {
    getImage().then((file) {
      _pickImageStreamController.sink.add(file);
    });
  }

  // Used to fetch all feeds. It has optional argument.
  // Because on refresh we can't call method we pass reference of the method
  Future fetchAllFeeds({String pageNumber}) async {
    if (pageNumber == "") {
      pageNumber = "1";
    }
    AllFeeds allFeeds = await _repository.getAllFeeds(pageNumber);

    _allFeedsStreamController.sink.add(allFeeds);
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
