import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:student_management_app/model/student_model.dart';
import 'package:sqflite/sqflite.dart';

late Database database;

const DB_NAME = 'student.db';
const TABLE_NAME = 'STUDENT';

class SqliteController {
  Future<Database> initializeDatabase() async {
    WidgetsFlutterBinding.ensureInitialized();

    String path = await getDatabasesPath();
    String createTable =
        'CREATE TABLE $TABLE_NAME (id INTEGER PRIMARY KEY, name TEXT, address TEXT, sex TEXT, birth TEXT, whereBorn TEXT, classOfStudent TEXT, course INTEGER, educationLevel TEXT, typeOfEducation TEXT, major TEXT)';
    return openDatabase(join(path, DB_NAME),
        onCreate: (database, version) async {
      await database.execute(createTable);
    }, version: 1);
  }

  Future<void> insertStudent(Student student) async {
    final db = await database;
    await db.insert(
      TABLE_NAME,
      student.toMap(),
    );
  }

  Future<List<Student>> student() async {
    final db = await database;
    final List<Map<String, dynamic>> maps =
        await db.rawQuery('Select * from $TABLE_NAME');
    return List.generate(
        maps.length,
        (index) => Student(
            id: maps[index]['id'],
            name: maps[index]['name'],
            address: maps[index]['address'],
            sex: maps[index]['sex'],
            birth: maps[index]['birth'],
            whereBorn: maps[index]['whereBorn'],
            classOfStudent: maps[index]['classOfStudent'],
            course: maps[index]['course'],
            educationLevel: maps[index]['educationLevel'],
            typeOfEducation: maps[index]['typeOfEducation'],
            major: maps[index]['major']));
  }

  // Future<void> updateStudent(Student student) async {
  //   final db = await database;
  //   await db.update(
  //     TABLE_NAME,
  //     student.toMap(),
  //     where: 'id = ?, name = ?',
  //     whereArgs: [student.id, student.name],
  //   );
  // }

// Future<void> deleteStudent(String name) async {
//   final db = await database;
//   await db.delete(TABLE_NAME, where: 'name = ?', whereArgs: [name]);
// }
}
