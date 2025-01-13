import 'dart:developer';

import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import 'package:student_management_app/model/student.dart';

class Controller extends GetxController {
  @override
  void onInit() async {
    super.onInit();
    await initialize();
    await getStudents();
    studentFound.value = student;
  }

  late Database database;
  List<Student> student = [];
  Rx<List<Student>> studentFound = Rx<List<Student>>([]);
  var imagePath = ''.obs;

  //FOR IMMEDIATE DISPLAY OF IMAGE
  void imagePick(String path) {
    imagePath.value = path;
  }

  //TO CREATE A DATABASE AND CREATE AND UPDATE TABLE

  Future<void> initialize() async {
    database = await openDatabase(
      'student.db',
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
            'CREATE TABLE student (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, age INTEGER, department TEXT, imgurl TEXT, email TEXT)');
      },
      onOpen: (db) => log('Database opened'),
    );
  }

//TO INSERT DATA FROM APP TO DATABASE

  Future<void> addStudent(Student val) async {
    try {
      await database.rawInsert(
        'INSERT INTO student(name, age, department, email, imgurl) VALUES (?, ?, ?, ?, ?)',
        [
          val.name,
          val.age,
          val.department,
          val.email,
          val.imgurl,
        ],
      );
      imagePath.value = '';
      update();
      getStudents();
      log(val.toString());
    } catch (e) {
      log('Error adding student: $e');
    }
  }

//TO GET ALL DATA FROM DATABASE

  Future<void> getStudents() async {
    final result = await database.rawQuery('SELECT * FROM student');
    student.clear();
    log(result.toString());
    for (var value in result) {
      student.add(Student.fromMap(value));
    }
    studentFound.value = student;
    update();
    log(student.length.toString());
  }

//TO DELETE A student

  Future<void> deleteStudent(int id) async {
    await database.rawDelete('DELETE FROM student WHERE id = ?', [id]);
    getStudents();
  }

//TO UPDATE ANY RECORD

  Future<void> updateStudent(Student updated) async {
    await database.update(
        'student',
        {
          'name': updated.name,
          'age': updated.age,
          'department': updated.department,
          'email': updated.email,
          'imgurl': updated.imgurl
        },
        where: 'id=?',
        whereArgs: [updated.id]);
    update();
    getStudents();
  }

  //FOR SEARCH
  void search(String name) {
    List<Student> result = [];

    if (name.isEmpty) {
      studentFound.value = List.from(student);
      
      return;
    }
      result = studentFound.value
          .where((element) => element.name
              .toString()
              .toLowerCase()
              .contains(name.toLowerCase()))
          .toList();
     if (result.length != studentFound.value.length ||
        !result.every((student) => studentFound.value.contains(student))){
      log(studentFound.value.toString());
       studentFound.value = result;
      imagePath = ''.obs;
    }
  }

  void resetController() {
    student.clear();
    studentFound.value = [];
    imagePath.value = '';
    getStudents();
  }
}