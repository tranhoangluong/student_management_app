import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:student_management_app/screen/reset_password_screen.dart';
import 'package:student_management_app/service/auth.dart';
import 'package:student_management_app/service/validate.dart';
import 'package:student_management_app/screen/home_screen.dart';

TextEditingController usernameController = TextEditingController();
TextEditingController passwordController = TextEditingController();

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  static const routeName = '/LoginScreen';

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    var width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Image.asset('assets/image/logo.png'),
              Container(
                height: height / 5,
                width: width,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(
                          'assets/image/image_1.jpg',
                        ))),
              ),
              SizedBox(
                height: height / 15,
              ),
              Container(
                margin: const EdgeInsets.only(left: 10, right: 10),
                padding: const EdgeInsets.all(10),
                height: height / 3,
                width: width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment(0.8, 1),
                        colors: [
                          Colors.blue,
                          Colors.lightBlueAccent,
                        ])),
                child: const LoginForm(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  bool passwordSecure = true;

  void _toggle() {
    setState(() {
      passwordSecure = !passwordSecure;
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    var width = MediaQuery.sizeOf(context).width;
    return Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: usernameController,
              validator: (value) => Validator.validateEmail(email: value!),
              decoration: const InputDecoration(
                  prefixIcon: Icon(
                    Icons.person,
                    color: Colors.black,
                  ),
                  hintText: 'User name',
                  hintStyle: TextStyle(color: Colors.black)),
            ),
            TextFormField(
              controller: passwordController,
              obscureText: passwordSecure,
              validator: (value) =>
                  Validator.validatePassword(password: value!),
              decoration: InputDecoration(
                  hintText: 'Password',
                  hintStyle: const TextStyle(color: Colors.black),
                  prefixIcon: const Icon(
                    Icons.key,
                    color: Colors.black,
                  ),
                  suffixIcon: GestureDetector(
                    onTap: _toggle,
                    child: Icon(
                      passwordSecure
                          ? Icons.visibility_rounded
                          : Icons.visibility_off_rounded,
                      color: Colors.black,
                    ),
                  )),
            ),
            SizedBox(
              height: height / 20,
            ),
            InkWell(
              onTap: () async {
                final navigator = Navigator.of(context);
                if (_formKey.currentState!.validate()) {
                  User? user = await Auth.signInUsingEmailPassword(
                    email: usernameController.text,
                    password: passwordController.text,
                    context: context,
                  );
                  if (user != null) {
                    navigator.pushNamed(HomeScreen.routeName);
                  }
                }
              },
              child: Container(
                margin: const EdgeInsets.only(left: 10, right: 10),
                height: height / 15,
                width: width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: const Center(
                  child: Text(
                    'Đăng nhập',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const RememberLogin(),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, ResetPasswordScreen.routeName);
                  },
                  child: const Text(
                    'Quên mật khẩu?',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                )
              ],
            ),
          ],
        ));
  }
}

class RememberLogin extends StatefulWidget {
  const RememberLogin({super.key});

  @override
  State<RememberLogin> createState() => _RememberLoginState();
}

class _RememberLoginState extends State<RememberLogin> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Checkbox(
              value: isChecked,
              onChanged: (bool? value) {
                setState(() {
                  isChecked = value!;
                });
              }),
          const Text(
            'Ghi nhớ đăng nhập',
            style: TextStyle(
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}
