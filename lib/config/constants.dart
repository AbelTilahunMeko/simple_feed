import 'package:flutter/material.dart';

class CONSTANTS{
  //The constant are used through all of the projects.
  static const String baseURL = "https://simple-feed-prod.herokuapp.com";
  static const String verifyAccount =  baseURL+"/v1/accounts/verify";
  static const String logout =  baseURL+"/v1/accounts/logout";
  static const String feed =  baseURL+"/v1/posts/?page=";
  static const String post =  baseURL+"/v1/posts";
  static const String like =  baseURL+"/v1/posts/like";
  static const String unlike =  baseURL+"/v1/posts/unlike";
  static const Color primaryColor = Color(0xffE9446A);
  static const Color CodGrayTextColor = Color(0xff0E0E0E);
  static const Color lightGrayTextColor = Color(0xff9B9B9B);

}