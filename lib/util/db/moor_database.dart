import 'package:moor_flutter/moor_flutter.dart';
import 'package:simple_feed_app/user/dao/moor_user_dao.dart';
import 'package:simple_feed_app/user/dao/user_dao.dart';
import 'package:simple_feed_app/user/model/user_table.dart';

part 'moor_database.g.dart';

@UseMoor(tables:[User], daos: [MoorUserDao])
class UserMoorDatabase extends _$UserMoorDatabase{
  UserMoorDatabase():super(FlutterQueryExecutor.inDatabaseFolder(path: "da.sqlite",logStatements: true));

  @override
  // TODO: implement schemaVersion
  int get schemaVersion => throw UnimplementedError();
}


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