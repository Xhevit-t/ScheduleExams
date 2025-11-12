import 'package:flutter/material.dart';
import 'package:schedule_exams/models/exam.dart';
import 'package:schedule_exams/widgets/info_row.dart';

class ExamCard extends StatelessWidget {
  final Exam exam;
  final VoidCallback onTap;

  const ExamCard({super.key, required this.exam, required this.onTap});

  String _fmtDate(DateTime dt) {
    final dd = dt.day.toString().padLeft(2, '0');
    final mm = dt.month.toString().padLeft(2, '0');
    final yyyy = dt.year.toString();
    return '$dd.$mm.$yyyy';
  }

  String _fmtTime(DateTime dt) {
    final hh = dt.hour.toString().padLeft(2, '0');
    final min = dt.minute.toString().padLeft(2, '0');
    return '$hh:$min';
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final isPast = exam.dateTime.isBefore(now);
    final Color stripe = isPast ? Colors.red.shade400 : Colors.green.shade400;
    final Color? bg     = isPast ? Colors.red.shade50  : Colors.green.shade50;

    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 3,
        clipBehavior: Clip.antiAlias,
        child: Container(
          color: bg,
          child: Row(
            children: [
              Container(width: 6, height: 110, color: stripe),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        exam.subject,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      InfoRow(
                        icon: Icons.calendar_today,
                        text: _fmtDate(exam.dateTime),
                      ),
                      const SizedBox(height: 4),
                      InfoRow(
                        icon: Icons.access_time,
                        text: _fmtTime(exam.dateTime),
                      ),
                      const SizedBox(height: 4),
                      InfoRow(
                        icon: Icons.meeting_room,
                        text: exam.rooms.join(', '),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
            ],
          ),
        ),
      ),
    );
  }
}
