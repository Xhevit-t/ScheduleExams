import 'package:flutter/material.dart';
import 'package:schedule_exams/data/exams.dart';
import 'package:schedule_exams/models/exam.dart';
import 'package:schedule_exams/screens/exam_detail_screen.dart';
import 'package:schedule_exams/widgets/exam_card.dart';
import 'package:schedule_exams/widgets/total_badge.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const String indexNumber = '211279'; // your index here
  late List<Exam> _items;

  @override
  void initState() {
    super.initState();
    _items = List<Exam>.from(kExams)
      ..sort((a, b) => a.dateTime.compareTo(b.dateTime)); // chronological
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).padding.bottom;
    final bottomPad = kBottomNavigationBarHeight + bottomInset + 16;

    return Scaffold(
      appBar: AppBar(
        title: Text('Распоред за испити - $indexNumber'),
      ),
      bottomNavigationBar: TotalBadge(count: _items.length),
      body: ListView.separated(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.fromLTRB(12, 12, 12, bottomPad),
        itemCount: _items.length,
        separatorBuilder: (_, __) => const SizedBox(height: 6),
        itemBuilder: (context, i) {
          final exam = _items[i];
          return ExamCard(
            exam: exam,
            onTap: () {
              Navigator.pushNamed(
                context,
                ExamDetailScreen.routeName,
                arguments: exam,
              );
            },
          );
        },
      ),
    );
  }
}
