import 'package:flutter/material.dart';
import 'package:todo_app/presentation/pages/start.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ToDo app',
      theme: ThemeData(
        fontFamily: 'OpenSans',
        primarySwatch: Colors.deepPurple,
        unselectedWidgetColor: const Color(0xFF6053B5).withOpacity(0.75),
      ),
      home: const StartPage(),
    );
  }
}
