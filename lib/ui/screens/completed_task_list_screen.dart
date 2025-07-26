import 'package:flutter/material.dart';
import 'package:task_manager/ui/widgets/completed_task.dart';
import 'package:task_manager/ui/widgets/progress_card.dart';
import 'package:task_manager/ui/widgets/task_card.dart';

class CompletedTaskListScreen extends StatefulWidget {
  const CompletedTaskListScreen({super.key});

  @override
  State<CompletedTaskListScreen> createState() =>
      _CompletedTaskListScreenState();
}

class _CompletedTaskListScreenState extends State<CompletedTaskListScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return CompletedTask();
        },
      ),
    );
  }
}
