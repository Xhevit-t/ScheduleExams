import 'package:flutter/material.dart';
import 'package:schedule_exams/screens/exam_detail_screen.dart';
import 'package:schedule_exams/screens/home_screen.dart';

void main() {
  runApp(const ExamApp());
}

class ExamApp extends StatelessWidget {
  const ExamApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Распоред за испити',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (_) => const HomeScreen(),
        ExamDetailScreen.routeName: (_) => const ExamDetailScreen(),
      },
    );
  }
}
