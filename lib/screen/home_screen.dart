import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const routeName = '/HomeScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.menu),
        title: const Text('Trang cá nhân sinh viên'),
        actions: const [
          Icon(Icons.logout),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Container(),
            Container(),
          ],
        ),
      ),
    );
  }
}
