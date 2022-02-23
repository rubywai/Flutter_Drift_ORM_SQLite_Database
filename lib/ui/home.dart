import 'package:drift_database/database/student_database.dart';
import 'package:drift_database/ui/add_student_screen.dart';
import 'package:drift_database/ui/update_student_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  StudentDatabse studentDatabse = Get.find();
   Home({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Student DB'),
      actions: [
        IconButton(onPressed: (){
          showDialog(context: context, 
          builder: (context){
            return AlertDialog(
              title: Text('Are you sure to delete all students?'),
              actions: [
                TextButton(onPressed: (){
                   studentDatabse.deleteAllStudent();

                   Navigator.pop(context);


                }, child: Text('Yes')),
                TextButton(onPressed: (){
                    Navigator.pop(context);
                }, child: Text('No'))
              ],
            );
          });

        }, icon: Icon(Icons.delete)),
        IconButton(onPressed: (){
          Navigator.push(context, 
            MaterialPageRoute(builder: (context) => AddStudent())
          );
        }, icon: Icon(Icons.add))
      ],
      ),
      body: StreamBuilder<List<Student>> (
        stream: studentDatabse.getAllStudent() ,
        builder: (context,snapshot){
          if(snapshot.hasData){
           
            return _studentList(snapshot.data ?? []);
          }
          else if(snapshot.hasError){
            return Text('Error');
          }
          return Center(child: CircularProgressIndicator(),);
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
                        icon: Icon(Icons.edit),
                      ),
                      trailing: IconButton(
                        onPressed: () async{
                         await  studentDatabse.deleteStudent(student[index]);

                        },
                        icon: Icon(Icons.delete),
                      ),
                    ),
                    Divider(color: Colors.blue,),
                    Text(student[index].name),
                    Divider(color: Colors.blue,),
                    Text(student[index].address),
                    Divider(color: Colors.blue,),
                    Text(student[index].phone),
                    Divider(color: Colors.blue,),
                    Text(student[index].age.toString()),
                    Divider(color: Colors.blue,),
                    Text(student[index].birthday.toString()),
                    Divider(color: Colors.blue,),
                ]
              ),
            ),
          ),
        );
      }
      );
  }
}