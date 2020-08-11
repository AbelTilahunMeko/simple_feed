
import 'dart:io';

import 'package:simple_feed_app/model/all_feeds_model.dart';

abstract class FeedApiRepository {
  Future<AllFeeds> getAllFeeds(String pageNumber);
  Future<void> uploadFeedToDatabase(File file, String caption);
}