import 'dart:io';

import 'package:dio/dio.dart';
import 'package:simple_feed_app/model/all_feeds_model.dart';
import 'package:simple_feed_app/model/user_model.dart';

import 'package:simple_feed_app/repository/feed_api_repoository.dart';
import 'package:simple_feed_app/repository/like_feed_api_repository.dart';
import 'package:simple_feed_app/repository/upload_image_api_repository.dart';
import 'package:simple_feed_app/repository/user_api_repository.dart';

class Repository {
  //The repo is used to connect every API feed with the bloc.
  UserApiRepo _userApiRepo = UserApiRepo();
  FeedApiRepo _feedApiRepo = FeedApiRepo();
  UploadFeedApiRepo _apiRepo = UploadFeedApiRepo();
  FeedLikeApiRepo _likeApiRepo = FeedLikeApiRepo();

  Future<UserModel> verifyUser(Map<String, dynamic> data, String token){
    return _userApiRepo.verifyUser(data, token);
  }

  Future logoutUser(String token){
    return _userApiRepo.logoutUser(token);
  }
  Future<Response> uploadFeed(File file, String token, String caption){
    return _apiRepo.uploadImage(file, token, caption);
  }

  Future<AllFeeds> getAllFeeds(String token, String pageNumber){
//    print("The token is  " + token);
    return _feedApiRepo.getAllFeeds(token, pageNumber);
  }

  Future likeFeed(String token, String feedId) {
    return _likeApiRepo.likeFeed(token, feedId);
  }

  Future unlikeFeed(String token, String feedId){
    return _likeApiRepo.unlikeFeed(token, feedId);
  }
}