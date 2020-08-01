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

  Future<UserModel> verifyUser(Map<String, dynamic> data){
    return _userApiRepo.verifyUser(data);
  }

  Future logoutUser(){
    return _userApiRepo.logoutUser();
  }
  Future<Response> uploadFeed(File file, String caption){
    return _apiRepo.uploadImage(file, caption);
  }

  Future<AllFeeds> getAllFeeds(String pageNumber){
    return _feedApiRepo.getAllFeeds(pageNumber);
  }

  Future likeFeed( String feedId) {
    return _likeApiRepo.likeFeed(feedId);
  }

  Future unlikeFeed(String token, String feedId){
    return _likeApiRepo.unlikeFeed(feedId);
  }
}