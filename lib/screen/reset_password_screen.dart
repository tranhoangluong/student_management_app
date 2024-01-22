import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:student_management_app/service/validate.dart';

class ResetPasswordScreen extends StatefulWidget {
  static const routeName = '/ResetPasswordScreen';

  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    super.dispose();
  }

  Future<void> resetPassword() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      await auth.sendPasswordResetEmail(email: usernameController.text.trim());
    } on FirebaseAuthException catch (error) {
      print(error);
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Đã gửi email đặt lại mật khẩu'),
              content: const Text('Vui lòng kiểm tra!'),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'OK'),
                  child: const Text('OK'),
                ),
              ],
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Đặt lại mật khẩu'),
        leading: const Icon(Icons.arrow_back),
      ),
      body: SafeArea(
          child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: usernameController,
                    validator: (value) =>
                        Validator.validateEmail(email: value!),
                    decoration: const InputDecoration(
                        prefixIcon: Icon(
                          Icons.email,
                          color: Colors.black,
                        ),
                        hintText: 'Vui lòng nhập email của bạn',
                        hintStyle: TextStyle(color: Colors.black)),
                  ),
                  InkWell(
                    onTap: () async {
                      if (usernameController.text.isEmpty) {
                        return;
                      } else {
                        await resetPassword();
                      }
                    },
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      height: 50,
                      width: 200,
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(10)),
                      child: const Center(
                        child: Text(
                          'Đặt lại mật khẩu',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ))),
    );
  }
}
