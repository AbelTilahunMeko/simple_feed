import 'package:moor_flutter/moor_flutter.dart';
import 'package:moor/ffi.dart';

class MoorDatabaseSetupOptions {
  static QueryExecutor get inMemoryExecuter => VmDatabase.memory();
}
