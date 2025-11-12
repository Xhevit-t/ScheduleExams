import 'package:flutter/material.dart';
import 'package:schedule_exams/models/exam.dart';
import 'package:schedule_exams/widgets/info_row.dart';

class ExamDetailScreen extends StatelessWidget {
  static const routeName = '/detail';

  const ExamDetailScreen({super.key});

  String _fmtDate(DateTime dt) {
    String dd = dt.day.toString().padLeft(2, '0');
    String mm = dt.month.toString().padLeft(2, '0');
    String yyyy = dt.year.toString();
    return '$dd.$mm.$yyyy';
  }

  String _fmtTime(DateTime dt) {
    String hh = dt.hour.toString().padLeft(2, '0');
    String min = dt.minute.toString().padLeft(2, '0');
    return '$hh:$min';
  }

  String _remainingText(DateTime examDateTime) {
    final now = DateTime.now();
    final diff = examDateTime.difference(now);
    if (diff.isNegative) {
      return 'Испитот е поминат';
    }
    final days = diff.inDays;
    final hours = diff.inHours % 24;
    return '$days дена, $hours часа';
  }

  @override
  Widget build(BuildContext context) {
    final exam = ModalRoute.of(context)!.settings.arguments as Exam;

    final now = DateTime.now();
    final isPast = exam.dateTime.isBefore(now);
    final Color stripe = isPast ? Colors.grey.shade400 : Colors.green.shade400;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Детали за испит'),
      ),
      body: ListView(
        children: [
          Card(
            margin: const EdgeInsets.all(16),
            elevation: 3,
            child: Row(
              children: [
                Container(width: 10, height: 150, color: stripe),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          exam.subject,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 12),
                        InfoRow(
                          icon: Icons.calendar_today,
                          text: _fmtDate(exam.dateTime),
                        ),
                        const SizedBox(height: 6),
                        InfoRow(
                          icon: Icons.access_time,
                          text: _fmtTime(exam.dateTime),
                        ),
                        const SizedBox(height: 6),
                        InfoRow(
                          icon: Icons.meeting_room,
                          text: exam.rooms.join(', '),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.hourglass_bottom,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(width: 10),

                    Expanded(
                      child: Text(
                        'Преостанато време: ${_remainingText(exam.dateTime)}',
                        style: const TextStyle(fontSize: 16),
                        softWrap: true,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
