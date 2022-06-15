// ignore_for_file: non_constant_identifier_names

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hivedb/db/functions/db_functions.dart';
import 'package:hivedb/db/model/data_model.dart';
import 'package:hivedb/screens/widgets/list_details.dart';

class ListStudentWidget extends StatelessWidget {
  const ListStudentWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: studentListNotifier,
      builder:
          (BuildContext ctx, List<StudentModel> studentList, Widget? child) {
        return ListView.separated(
          itemBuilder: (ctx, index) {
            final data = studentList[index];
            return ListTile(
              title: Text(data.name),
              subtitle: Text(data.age),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
                  return ListDetails(
                    index: index,
                  );
                }));
              },
              leading: CircleAvatar(backgroundImage: FileImage(File(data.pic))),
              trailing: IconButton(
                  onPressed: () {
                    // deleteStudent(index);
                    showAlertDialog(context, index);
                  },
                  icon: Icon(Icons.delete)),
            );
          },
          separatorBuilder: (ctx, index) {
            return const Divider();
          },
          itemCount: studentList.length,
        );
      },
    );
  }

  showAlertDialog(BuildContext context, int index) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Deleting??'),
            content: Text('are you sure to delete it!!'),
            actions: [
              TextButton(
                  onPressed: () {
                    deleteStudent(index);
                    Navigator.of(context).pop();
                  },
                  child: Text("Yes")),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("No"))
            ],
          );
        });
  }
}
