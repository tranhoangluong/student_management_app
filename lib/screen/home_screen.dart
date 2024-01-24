import 'package:flutter/material.dart';
import 'package:student_management_app/database/sqlite_controller.dart';
import 'package:student_management_app/model/student_model.dart';

import 'package:student_management_app/screen/login_screen.dart';
import 'package:student_management_app/service/auth.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const routeName = '/HomeScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.menu,
            color: Colors.white,
          ),
        ),
        title: const Text(
          'Trang sinh viên',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        actions: [
          TextButton(
              onPressed: () {
                Auth.signOut();
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ));
                usernameController.clear();
                passwordController.clear();
              },
              child: const Text(
                'Đăng xuất',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ))
        ],
      ),
      body: Column(
        children: [
          Center(
            child: Stack(
              children: [
                Container(
                  margin: const EdgeInsets.all(8),
                  height: 200,
                  width: 200,
                  child: const CircleAvatar(
                    backgroundImage: AssetImage('assets/image/image_1.jpg'),
                  ),
                ),
              ],
            ),
          ),
          const InformationStudentWidget(),
        ],
      ),
    );
  }
}

class InformationStudentWidget extends StatefulWidget {
  const InformationStudentWidget({super.key});

  @override
  State<InformationStudentWidget> createState() =>
      _InformationStudentWidgetState();
}

class _InformationStudentWidgetState extends State<InformationStudentWidget> {
  late SqliteController sqliteController;
  final Student _student = Student(
      id: 2051120140,
      name: 'Trần Chu Hoàng Lương',
      address: 'Xã Ia Bang',
      sex: 'Nam',
      birth: '03/09/2002',
      whereBorn: 'Gia Lai',
      classOfStudent: 'CN20B',
      course: 2020,
      educationLevel: 'Đại học',
      typeOfEducation: 'Chính quy',
      major: 'Công nghệ thông tin');

  @override
  void initState() {
    sqliteController = SqliteController();
    sqliteController.insertStudent(_student);
    sqliteController.student();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          textDirection: TextDirection.ltr,
          children: [
            Text(
              'MSSV: ${_student.id}',
            ),
            Text(
              'Họ và tên: ${_student.name}',
            ),
            Text(
              'Giới tính: ${_student.sex}',
            ),
            Text(
              'Ngày sinh: ${_student.birth}',
            ),
            Text(
              'Nơi sinh: ${_student.whereBorn}',
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          textDirection: TextDirection.ltr,
          children: [
            Text(
              'Lớp học: ${_student.classOfStudent}',
            ),
            Text(
              'Khóa học: ${_student.course}',
            ),
            Text(
              'Bậc đào tạo: ${_student.educationLevel}',
            ),
            Text(
              'Loại hình đào tạo: ${_student.typeOfEducation}',
            ),
            Text(
              'Ngành: ${_student.major}',
            ),
          ],
        )
      ],
    );
  }
}
