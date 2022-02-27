import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:drift_database/database/student_dao.dart';
import 'package:drift_database/database/student_table.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

part 'student_database.g.dart';

@DriftDatabase(tables: [StudentTable],daos: [StudentDao] )
class StudentDatabse extends _$StudentDatabse {
  StudentDatabse() : super(_database());
 

  @override
  int get schemaVersion => 1;
}

LazyDatabase _database() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory(); //internal
    final dbFile = File(join(dbFolder.path, "student.db"));
    return NativeDatabase(dbFile);
  });
}
