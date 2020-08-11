abstract class FeedLikeApiRepository{
  Future<void> likeFeed(String feedId);
  Future<void> unlikeFeed(String feedId);
}