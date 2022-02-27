
import 'package:drift/drift.dart';
import 'package:drift_database/database/student_database.dart';
import 'package:drift_database/database/student_table.dart';

part 'student_dao.g.dart';
@DriftAccessor(tables: [StudentTable])
class StudentDao extends DatabaseAccessor<StudentDatabse> with _$StudentDaoMixin{
  StudentDao(StudentDatabse studentDatabse) : super(studentDatabse);
   Future<int> insertStudent(StudentTableCompanion s) async {
    return  await into(studentTable).insert(s);
  } 

  Stream<List<Student>> getAllStudent({OrderingMode? mode}){
    if(mode == null){
      return select(studentTable).watch();
    }
    else {
    return (select(studentTable)
    ..orderBy([(studentTable) => OrderingTerm(expression: studentTable.age,mode: mode)])
    ) .watch();
    }
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

}