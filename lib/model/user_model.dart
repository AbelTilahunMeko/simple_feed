import 'package:meta/meta.dart';
class UpdateProfilePayload{
  final String bio;
  final String name;
  final String username;

//<editor-fold desc="Data Methods" defaultstate="collapsed">


  const UpdateProfilePayload({
    @required this.bio,
    @required this.name,
    @required this.username,
  });


  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          (other is UpdateProfilePayload &&
              runtimeType == other.runtimeType &&
              bio == other.bio &&
              name == other.name &&
              username == other.username
          );


  @override
  int get hashCode =>
      bio.hashCode ^
      name.hashCode ^
      username.hashCode;


  @override
  String toString() {
    return 'UpdateProfilePayload{' +
        ' bio: $bio,' +
        ' name: $name,' +
        ' username: $username,' +
        '}';
  }


  UpdateProfilePayload copyWith({
    String bio,
    String name,
    String username,
  }) {
    return new UpdateProfilePayload(
      bio: bio ?? this.bio,
      name: name ?? this.name,
      username: username ?? this.username,
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'bio': this.bio,
      'name': this.name,
      'username': this.username,
    };
  }

  factory UpdateProfilePayload.fromJson(Map<String, dynamic> map) {
    return new UpdateProfilePayload(
      bio: map['bio'] as String,
      name: map['name'] as String,
      username: map['username'] as String,
    );
  }


//</editor-fold>
}

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
