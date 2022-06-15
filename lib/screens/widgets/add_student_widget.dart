// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_new, use_build_context_synchronously, unused_element

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hivedb/db/functions/db_functions.dart';
import 'package:hivedb/db/model/data_model.dart';
import 'package:hivedb/screens/home/ScreenEnter.dart';
import 'package:hivedb/screens/widgets/list_details.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';

var img;

class AddStudentWidget extends StatelessWidget {
  final formKey = GlobalKey<FormState>();

  AddStudentWidget({Key? key}) : super(key: key);

  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _branchController = TextEditingController();
  final _numberController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Text("Student's portal",
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue)),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), hintText: 'Name'),
              validator: (value) {
                if (value!.isEmpty ||
                    !RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
                  //allow upper and lower case alphabets and space
                  return "Enter correct name";
                } else {
                  return null;
                }
              },
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                controller: _ageController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Age',
                ),
                validator: (value) {
                  if (value!.isEmpty ||
                      !RegExp(r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$')
                          .hasMatch(value)) {
                    //allow upper and lower case alphabets and space
                    return "Enter correct age";
                  } else {
                    return null;
                  }
                }),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: _branchController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: 'Enter branch'),
              validator: (value) {
                if (value!.isEmpty ||
                    !RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
                  //allow upper and lower case alphabets and space
                  return "Enter correct details";
                } else {
                  return null;
                }
              },
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                controller: _numberController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter phone number'),
                validator: (value) {
                  if (value!.isEmpty ||
                      !RegExp(r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$')
                          .hasMatch(value)) {
                    //allow upper and lower case alphabets and space
                    return "Enter correct number";
                  } else {
                    return null;
                  }
                }),
            ElevatedButton.icon(
              onPressed: () async {
                var imageId = await getImage();

                showAlertDialog(context, img);
              },
              icon: Icon(Icons.add_a_photo_rounded),
              label: Text('add photo'),
            ),
            ElevatedButton.icon(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    onAddStudentButtonClicked(context);
                    onNavigate(context);
                  } else {
                    return;
                  }

                  // Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
                  //   return ScreenEnter();
                  // }));
                },
                icon: Icon(Icons.add),
                label: Text('Add details')),
            // Container(
            //   color: Colors.amber,
            //   height: 200,
            //   width: 200,
            //   //  child:
            // )
          ],
        ),
      ),
    );
  }

  Future<void> onAddStudentButtonClicked(ctx) async {
    final _name = _nameController.text.trim();
    final _age = _ageController.text.trim();
    final _branch = _branchController.text.trim();
    final _number = _numberController.text.trim();
    //snackbar
    if (_name.isEmpty || _age.isEmpty) {
      ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(15),
          backgroundColor: Colors.red,
          content: Text('Add complete details')));
    } else {
      //  print('$_name $_age $_branch $_number');

      final _student = StudentModel(
          name: _name, age: _age, branch: _branch, number: _number, pic: img);

      addStudent(_student);
    }
  }

  void onNavigate(BuildContext context) {
    final _name = _nameController.text.trim();
    final _age = _ageController.text.trim();
    if (_name.isNotEmpty && _age.isNotEmpty) {
      Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
        return ScreenEnter();
      }));
    }
  }
}

Future getImage() async {
  final ImagePicker _picker = ImagePicker();

  XFile? image = await _picker.pickImage(source: ImageSource.gallery);
  img = image!.path;
}

showAlertDialog(BuildContext context, imge) {
  showDialog(
      context: context,
      builder: (context) {
        final nameController = TextEditingController();
        final ageController = TextEditingController();
        final branchController = TextEditingController();
        final numberController = TextEditingController();

        return AlertDialog(
          title: Text('Confirm image'),
          content: Container(
            height: 200,
            child: Column(
              children: [
                Container(
                  decoration: new BoxDecoration(
                      image: new DecorationImage(image: FileImage(File(imge)))),
                  height: 200,
                  width: 200,
                )
                // TextButton(
                //     onPressed: () {
                //       var imgid = getImage();
                //       photo = imgid;
                //     },
                //     child: Text('image'))
              ],
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  //deleteStudent(index);

                  final _student = StudentModel(
                      name: nameController.text,
                      age: ageController.text,
                      branch: branchController.text,
                      number: numberController.text,
                      pic: photo);
                  // editDetails( _student);

                  Navigator.of(context).pop();
                },
                child: Text("Submit")),
            // TextButton(
            //     onPressed: () async {
            //       Navigator.of(context).pop();
            //       getImage();
            //       showAlertDialog(context, img);
            //     },
            //     child: Text("retry"))
          ],
        );
      });
}
