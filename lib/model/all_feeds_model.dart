import 'package:simple_feed_app/model/feed_model.dart';

class AllFeeds {
  final int total;
  final int limit;
  final int pages;
  final String page;
  final List<FeedModel> feedModel;
  final String error;

  AllFeeds(this.total, this.limit, this.pages, this.page, this.feedModel,
      this.error);

  AllFeeds.fromJson(Map<dynamic, dynamic> json)
      : total = json['json'],
        limit = json['limit'],
        page = json['page'],
        pages = json['pages'],
        feedModel = (json['docs'] as List).map((e) => new FeedModel.fromJson(e)).toList(),
        error = "";

  AllFeeds.withErrors(String error)
      : total = 0,
        limit = 0,
        pages = 0,
        page = "",
        error = error,
        feedModel = List();
}
