
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:drift_database/database/student_table.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

part 'student_database.g.dart';
@DriftDatabase(tables: [StudentTable])
class StudentDatabse extends _$StudentDatabse{
  StudentDatabse() : super(_database());

  Future<int> insertStudent(StudentTableCompanion s) async {
    return  await into(studentTable).insert(s);
  } 

  Stream<List<Student>> getAllStudent(){
    return select(studentTable).watch();
  }

  Future<bool> updateStudent(StudentTableCompanion student) async{
    return await update(studentTable).replace(student);
  }
  
  Future<int> deleteStudent(Student student) async {
    return await delete(studentTable).delete(student);
  }

  Future<int> deleteAllStudent() async{
    return await (delete(studentTable)..where((tbl) => tbl.id.isBiggerThanValue(0))).go();
  }

  @override
  int get schemaVersion => 1;

}
LazyDatabase _database(){
  return LazyDatabase( () async{
    final dbFolder = await getApplicationDocumentsDirectory();//internal
    final dbFile = File(join(dbFolder.path,"student.db")); 
    return NativeDatabase(dbFile);

  });
}