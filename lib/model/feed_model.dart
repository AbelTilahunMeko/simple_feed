import 'package:simple_feed_app/model/user_model.dart';

class FeedModel {
  final int likes;
  final String id;
  final String caption;
  final String image;
  final UserModel user;
  final String created_at;
  final String updated_at;
  final bool isLiked;

  FeedModel(this.likes, this.id, this.caption, this.image, this.user,
      this.created_at, this.updated_at, this.isLiked);

  FeedModel.fromJson(Map<dynamic, dynamic> json):likes = json['likes'], id = json['_id'],
        caption = json['caption'], image = json['image'],
        created_at = json['created_at'], updated_at = json['updated_at'],
        isLiked = json['isLiked'], user = UserModel.fromJson(json['user']);

}
