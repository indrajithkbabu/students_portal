import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hivedb/db/model/data_model.dart';

ValueNotifier<List<StudentModel>> studentListNotifier = ValueNotifier([]);

Future<void> addStudent(StudentModel value) async {
//  print(value.toString());
  final studentDB = await Hive.openBox<StudentModel>('student_db');

  final _id = await studentDB.add(value);
  value.id = _id;

  // studentListNotifier.value.add(value);
  // studentListNotifier.value.clear();
  studentListNotifier.notifyListeners();
}

Future<void> getAllStudents() async {
  final studentDB = await Hive.openBox<StudentModel>('student_db');

  studentListNotifier.value.clear();
  studentListNotifier.value.addAll(studentDB.values);
  studentListNotifier.notifyListeners();
}

Future<void> deleteStudent(int idx) async {
  final studentDB = await Hive.openBox<StudentModel>('student_db');

  final Key = studentDB.keys;

  final saved_key = Key.elementAt(idx);
  await studentDB.delete(saved_key);

  getAllStudents();
}

Future<void> editDetails(int ind, StudentModel value) async {
  final studentDB = await Hive.openBox<StudentModel>('student_db');

  studentDB.put(ind, value);
  getAllStudents();
}
