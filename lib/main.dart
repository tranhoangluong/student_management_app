import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:student_management_app/screen/home_screen.dart';
import 'package:student_management_app/screen/login_screen.dart';
import 'package:student_management_app/screen/reset_password_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      onGenerateRoute: (settings) {
        if (settings.name == HomeScreen.routeName) {
          return MaterialPageRoute(
            settings: settings,
            builder: (BuildContext context) {
              return const HomeScreen();
            },
          );
        }
        if (settings.name == ResetPasswordScreen.routeName) {
          return MaterialPageRoute(
            settings: settings,
            builder: (BuildContext context) {
              return const ResetPasswordScreen();
            },
          );
        }
        return null;
      },
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const LoginScreen(),
    );
  }
}
