
import 'package:flutter/material.dart';

class TaskCountSummaryCard extends StatelessWidget {
  const TaskCountSummaryCard({
    super.key,
    required this.title,
    required this.count,
  });
  final String title;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('$count',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                )),
            Text(title)
          ],
        ),
      ),
    );
  }
}
