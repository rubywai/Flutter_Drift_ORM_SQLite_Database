
import 'package:drift/drift.dart' as drift;
import 'package:drift_database/database/student_dao.dart';
import 'package:drift_database/database/student_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class AddStudent extends StatefulWidget {
  const AddStudent({Key? key}) : super(key: key);

  @override
  _AddStudentState createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {
  GlobalKey<FormState> _key = GlobalKey();
  StudentDao studentDao = Get.find();
  String? name, address, phone,age;
  DateTime? birthday;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Student'),
      ),
      body: Form(
        key: _key,
        child: ListView(
          padding: const EdgeInsets.all(15),
          children: [
            const Text('Name:'),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              validator: (str) {
                if (str == null || str.isEmpty) {
                  return 'Please Enter Name';
                }
                return null;
              },
              onSaved: (str) {
                name = str;
              },
              decoration: const InputDecoration(
                  prefixIcon: const Icon(Icons.person),
                  hintText: 'Enter Name',
                  border: const OutlineInputBorder()),
            ),
            const Text('Address:'),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              validator: (str) {
                if (str == null || str.isEmpty) {
                  return 'Please Enter Address';
                }
                return null;
              },
              onSaved: (str) {
                address = str;
              },
              decoration: const InputDecoration(
                  prefixIcon: const Icon(Icons.location_city),
                  hintText: 'Enter Address',
                  border: OutlineInputBorder()),
            ),
           
            const Text('Phone:'),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              validator: (str) {
                if (str == null || str.isEmpty) {
                  return 'Please Enter Phone';
                }
                return null;
              },
              onSaved: (str) {
                phone = str;
              },
              decoration: const InputDecoration(
                  prefixIcon: const Icon(Icons.phone),
                  hintText: 'Enter Phone',
                  border: const OutlineInputBorder()),
            ),
             const Text('Age:'),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              validator: (str) {
                if (str == null || str.isEmpty) {
                  return 'Please Enter Age';
                }
                return null;
              },
              onSaved: (str) {
                age = str;
              },
              decoration: const InputDecoration(
                  prefixIcon: const Icon(Icons.person_add),
                  hintText: 'Enter Age',
                  border: const OutlineInputBorder()),
            ),
            Text('Birthday'),
            TextButton.icon(
              onPressed: () async{
                print('birthday click');
               birthday = await showDatePicker(
               context: context, 
               initialDate: DateTime(1996), 
               firstDate: DateTime(1900),
                lastDate: DateTime.now());
                setState(() {});
                
              }, icon: Icon(Icons.calendar_today), 
              label: Text('Select Birthday')),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('$birthday'),
              ),
            ElevatedButton.icon(
                onPressed: ()  async{
                  if(birthday == null){
                    ScaffoldMessenger.of(context)
                    .showSnackBar(
                      SnackBar(content: Text('Please select Birthday'),)
                    );
                  }
                  else if (_key.currentState != null &&
                      _key.currentState!.validate()) {
                        _key.currentState?.save();
                        studentDao.insertStudent(
                         StudentTableCompanion(
                           name: drift.Value(name ?? ''),
                           address: drift.Value(address ?? ''),
                           phone: drift.Value(phone ?? ''),
                           age : drift.Value(int.parse((age ?? '0'))),
                           birthday: drift.Value(birthday!)

                         )
                        );
                        
                
                        Navigator.pop(context,'success');
                  }
                },
                icon: const Icon(Icons.save),
                label: const Text('Save'))
          ],
        ),
      ),
    );
  }
}