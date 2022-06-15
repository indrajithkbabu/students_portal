// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hivedb/db/functions/db_functions.dart';
import 'package:hivedb/db/model/data_model.dart';
import 'package:hivedb/screens/widgets/add_student_widget.dart';

var photo;

class ListDetails extends StatelessWidget {
  const ListDetails({Key? key, required this.index}) : super(key: key);
  final int index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 10, 44, 72),
          //automaticallyImplyLeading: false,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.edit,
                color: Colors.white,
              ),
              onPressed: () async {
                // do something
                showAlertDialog(context, index);
              },
            )
          ],
        ),
        body: ValueListenableBuilder(
          valueListenable: studentListNotifier,
          builder:
              (BuildContext context, List<StudentModel> value, Widget? child) {
            return Container(
              color: Color.fromARGB(0, 255, 255, 255),
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Container(
                  child: Column(
                    children: [
                      Container(
                        width: 500,
                        height: 320,
                        child: Image(
                          image: FileImage(File(value[index].pic)),
                          // height: 400,
                          //  width: 500,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Name :' + value[index].name,
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Age:' + value[index].age,
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Branch :' + value[index].branch,
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Mobile :' + value[index].number,
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ));
  }
}

showAlertDialog(BuildContext context, int index) {
  showDialog(
      context: context,
      builder: (context) {
        final nameController = TextEditingController();
        final ageController = TextEditingController();
        final branchController = TextEditingController();
        final numberController = TextEditingController();

        nameController.text = studentListNotifier.value[index].name;
        ageController.text = studentListNotifier.value[index].age;
        branchController.text = studentListNotifier.value[index].branch;
        numberController.text = studentListNotifier.value[index].number;

        return AlertDialog(
          title: Text('Edit details'),
          content: Container(
            height: 250,
            child: Column(
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(hintText: 'Enter name'),
                ),
                TextField(
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  controller: ageController,
                  decoration: InputDecoration(hintText: 'Enter age'),
                ),
                TextField(
                  controller: branchController,
                  decoration: InputDecoration(hintText: 'Enter branch'),
                ),
                TextField(
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  controller: numberController,
                  decoration: InputDecoration(hintText: 'Enter number'),
                ),
                TextButton(
                    onPressed: () async {
                      await getImage();
                      photo = img;
                    },
                    child: Text('image'))
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
                  editDetails(index, _student);

                  Navigator.of(context).pop();
                },
                child: Text("Submit")),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Cancel"))
          ],
        );
      });
}
