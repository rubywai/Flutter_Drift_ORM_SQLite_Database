import 'package:drift/drift.dart' as db;
import 'package:drift_database/database/student_dao.dart';
import 'package:drift_database/database/student_database.dart';
import 'package:drift_database/ui/add_student_screen.dart';
import 'package:drift_database/ui/update_student_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget {

   Home({ Key? key }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  StudentDao studentDao = Get.find();

 late Stream<List<Student>> _students;
 @override
  void initState() {
    super.initState();
    _students = studentDao.getAllStudent();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Student DB'),
      leading: PopupMenuButton<String>(
        child: Icon(Icons.filter_list),
        onSelected: (str){
         if(str == 'default'){
           setState(() {
             _students = studentDao.getAllStudent();
           });
         }
         else if(str == 'aesc'){
           setState(() {
             _students = studentDao.getAllStudent(mode: db.OrderingMode.asc );
           });
         }
         else if(str == 'desc'){
           setState(() {
             _students = studentDao.getAllStudent(mode: db.OrderingMode.desc);
           });
         }
         else if(str == 'over25'){
           setState(() {
             _students = studentDao.getAllStudent(over25: true);
           });
         }
        },
        itemBuilder: (context){
         return   [
            const PopupMenuItem(child: Text('Default'),value: 'default',),
            const PopupMenuItem(child: Text('Age by Accending'),value: 'aesc',),
            const PopupMenuItem(child: Text('Age by Decending'),value: 'desc',),
            const PopupMenuItem(child: Text('Age over 25'),value: 'over25', )
          ];
        },
      ),
      actions: [
        IconButton(onPressed: (){
          showDialog(context: context, 
          builder: (context){
            return AlertDialog(
              title: const Text('Are you sure to delete all students?'),
              actions: [
                TextButton(onPressed: (){
                   studentDao.deleteAllStudent();

                   Navigator.pop(context);


                }, child: const Text('Yes')),
                TextButton(onPressed: (){
                    Navigator.pop(context);
                }, child: const Text('No'))
              ],
            );
          });

        }, icon: const Icon(Icons.delete)),
        IconButton(onPressed: (){
          Navigator.push(context, 
            MaterialPageRoute(builder: (context) => const AddStudent())
          );
        }, icon: const Icon(Icons.add))
      ],
      ),
      body: StreamBuilder<List<Student>> (
        stream: _students ,
        builder: (context,snapshot){
          if(snapshot.hasData){
           
            return _studentList(snapshot.data ?? []);
          }
          else if(snapshot.hasError){
            return const Text('Error');
          }
          return const Center(child: CircularProgressIndicator(),);
        },


      ),
      
    );
  }

  Widget _studentList(List<Student> student){
    return ListView.builder(
      itemCount: student.length,
      itemBuilder: (context,index){
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children : [
                    ListTile(
                      leading: IconButton(
                        onPressed: (){
                          Navigator.push(context, 
                          MaterialPageRoute(builder: (_) => UpdateStudent(student: student[index])));

                        },
                        icon: const Icon(Icons.edit),
                      ),
                      trailing: IconButton(
                        onPressed: () async{
                         await  studentDao.deleteStudent(student[index]);

                        },
                        icon: const Icon(Icons.delete),
                      ),
                    ),
                    const Divider(color: Colors.blue,),
                    CircleAvatar(child: Text(student[index].id.toString())),
                    const Divider(color: Colors.blue,),
                    Text(student[index].name),
                    const Divider(color: Colors.blue,),
                    Text(student[index].address),
                    const Divider(color: Colors.blue,),
                    Text(student[index].phone),
                    const Divider(color: Colors.blue,),
                    Text("Age - " + student[index].age.toString()),
                    const Divider(color: Colors.blue,),
                    Text(student[index].birthday.toString()),
                    const Divider(color: Colors.blue,),
                ]
              ),
            ),
          ),
        );
      }
      );
  }
}