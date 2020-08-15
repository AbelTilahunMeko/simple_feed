class UserModel {
  final int posts;
  final int followers;
  final int following;
  final String id;
  final String account;
  final String userName;
  final String name;
  final String profilePic;
  final String bio;
  final String createdAt;
  final String updatedAt;
  final String error;

  UserModel(
  {this.posts,
    this.followers,
    this.following,
    this.id,
    this.account,
    this.userName,
    this.name,
    this.profilePic,
    this.bio,
    this.createdAt,
    this.error,
    this.updatedAt});


  UserModel.fromJson(Map<String, dynamic> json)
      : posts = json['posts'],
        bio = json['bio'],
        followers = json['followers'],
        id = json['id'],
        account = json['account'],
        following = json['following'],
        userName = json['username'],
        name = json['name'],
        profilePic = json['profilePic'],
        createdAt = json['created_at'],
        error = "",
        updatedAt = json['updated_at'];

  UserModel.withError(String error)
      : posts = 0,
        bio = "",
        followers = 0,
        id = "",
        account = "",
        following = 0,
        userName = '',
        name = "",
        profilePic = "",
        createdAt = "",
        error = error,
        updatedAt = "";
}
