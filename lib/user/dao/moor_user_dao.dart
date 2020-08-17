import 'package:moor_flutter/moor_flutter.dart';
import 'package:simple_feed_app/user/dao/user_dao.dart';
import 'package:simple_feed_app/user/model/user_table.dart';
import 'package:simple_feed_app/util/db/moor_database.dart';

part 'moor_user_dao.g.dart';


@UseDao(tables: [User])
class MoorUserDao extends DatabaseAccessor<UserMoorDatabase> with _$MoorUserDaoMixin implements UserDao{
  MoorUserDao(UserMoorDatabase attachedDatabase) : super(attachedDatabase);

  @override
  Future<void> addUser(UserData data) async {
    await into(user).insert(data);
  }

  @override
  Future<UserData> getProfile(String id) async {
    return await (select(this.user)..where((tbl) => tbl.id.equals(id))).getSingle();
  }

  @override
  Future<void> updateUser(UserData data) async {
    // TODO: implement updateUser
    await update(user).replace(data);
  }
}