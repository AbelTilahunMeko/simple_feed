import 'dart:async';
import 'dart:io';

import 'package:logger/logger.dart';
import 'package:simple_feed_app/bloc/feed/bloc.dart';
import 'package:simple_feed_app/bloc/pick_image_bloc.dart';
import 'package:simple_feed_app/model/all_feeds_model.dart';
import 'package:simple_feed_app/repository/repository.dart';

class BlocIn {
  //This stream controller is used for the code.
  //This stream controller is used for getting the feeds.
   //This stream controller is used to getting images.
//
//  Repository _repository =
//      Repository(); // This is the repo where all the fetching is found.
//
//  Logger _logger = Logger();

  void dispose() {
//    _codeSentStreamController.close();
//    _allFeedsStreamController.close();
//    _pickImageStreamController.close();
//    _uploadCompletedController.close();
  }



  //This method gets the image and adds it to the sink so that the ui can use it.
//  pickImage() {
//    getImage().then((file) {
//    });
//  }

  // Used to fetch all feeds. It has optional argument.
  // Because on refresh we can't call method we pass reference of the method
//  Future fetchAllFeeds({String pageNumber}) async {
//    if (pageNumber == "") {
//      pageNumber = "1";
//    }
//    AllFeeds allFeeds = await _repository.getAllFeeds(pageNumber);
//
//    _allFeedsStreamController.sink.add(allFeeds);
//    _uploadCompletedController.sink.add(false);
//  }



}

//All the bloc is connected with the other.

//final bloc = BlocIn(); //SO that it can be accessed throughout the application.
