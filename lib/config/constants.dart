import 'package:flutter/material.dart';

class CONSTANTS {
  //The constant are used through all of the projects.
  static const String baseURL = "https://simple-feed-test.herokuapp.com";
  static const String verifyAccount = "/v1/accounts/verify";
  static const String logout = "/v1/accounts/logout";
  static const String feed = "/v1/posts/?page=";
  static const String post = "/v1/posts";
  static const String like = "/v1/posts/like";
  static const String unlike = "/v1/posts/unlike";
}
