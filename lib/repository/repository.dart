import 'dart:io';

import 'package:dio/dio.dart';
import 'package:simple_feed_app/model/all_feeds_model.dart';
import 'package:simple_feed_app/model/user_model.dart';

import 'package:simple_feed_app/repository/feed_api_repoository.dart';
import 'package:simple_feed_app/bloc/feed/like_feed_api_repository.dart';
import 'package:simple_feed_app/repository/upload_image_api_repository.dart';
import 'package:simple_feed_app/repository/user_api_repository.dart';

class Repository {
  //The repo is used to connect every API feed with the bloc.
  UserApiRepo _userApiRepo = UserApiRepo();
//  UploadFeedApiRepo _apiRepo = UploadFeedApiRepo();
//  FeedLikeApiRepo _likeApiRepo = FeedLikeApiRepo();

  Future<UserModel> verifyUser(Map<String, dynamic> data, String token) {
    return _userApiRepo.verifyUser(data, token);
  }

  Future logoutUser(String token) {
    return _userApiRepo.logoutUser(token);
  }

//  Future<Response> uploadFeed(File file, String caption) {
//    return _apiRepo.uploadImage(file, caption);
//  }

//  Future likeFeed(String feedId) {
//    return _likeApiRepo.likeFeed(feedId);
//  }
//
//  Future unlikeFeed(String feedId) {
//    return _likeApiRepo.unlikeFeed(feedId);
//  }
}
