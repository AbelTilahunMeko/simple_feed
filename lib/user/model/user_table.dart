import 'package:moor_flutter/moor_flutter.dart';


class User extends Table {
  @override
  Set<Column> get primaryKey => {id};

  @JsonKey("_id")
  TextColumn get id => text()();
  TextColumn get username => text()();
  TextColumn get name => text()();
  TextColumn get bio => text()();
  TextColumn get account => text()();
  TextColumn get profilePic => text()();
  IntColumn get posts => integer()();
  IntColumn get followers => integer()();
  IntColumn get following => integer()();

  @JsonKey("created_at")
  DateTimeColumn get createdAt => dateTime()();

  @JsonKey("updated_at")
  DateTimeColumn get updatedAt => dateTime()();
}
