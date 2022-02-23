import 'package:drift_database/database/student_database.dart';
import 'package:drift_database/ui/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  StudentDatabse studentDatabse = StudentDatabse();
  Get.put(studentDatabse);
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
      
    );
  }
}