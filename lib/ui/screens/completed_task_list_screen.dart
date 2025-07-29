import 'package:flutter/material.dart';
import 'package:task_manager/data/models/task_model.dart';
import 'package:task_manager/data/models/task_status_count_model.dart';
import 'package:task_manager/data/service/network_caller.dart';
import 'package:task_manager/data/urls.dart';
import 'package:task_manager/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:task_manager/ui/widgets/completed_task.dart';
import 'package:task_manager/ui/widgets/progress_card.dart';
import 'package:task_manager/ui/widgets/snack_bar_message.dart';
import 'package:task_manager/ui/widgets/task_card.dart';
import 'package:task_manager/ui/widgets/task_count_summary_card.dart';

class CompletedTaskListScreen extends StatefulWidget {
  const CompletedTaskListScreen({super.key});

  @override
  State<CompletedTaskListScreen> createState() =>
      _CompletedTaskListScreenState();
}

class _CompletedTaskListScreenState extends State<CompletedTaskListScreen> {
  bool _getCompletedTaskInProgress = false;
  List<TaskModel> _completedTaskList = [];
  

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        _getCompletedTaskList();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Visibility(
        visible: _getCompletedTaskInProgress == false,
        replacement: CenteredCircularProgressIndicator(),
        child: ListView.builder(
          itemCount: _completedTaskList.length,
          itemBuilder: (context, index) {
            return TaskCard(
              taskType: TaskType.progress,
              taskModel: _completedTaskList[index],
              onStatusUpdate: () {
                _getCompletedTaskList();
              },
            );
          },
        ),
      ),
    );
  }

  Future<void> _getCompletedTaskList() async {
    _getCompletedTaskInProgress = true;
    setState(() {});

    NetworkResponse response = await NetworkCaller.getRequest(
      url: Urls.getProgressTasksUrl,
    );

    if (response.isSuccess) {
      List<TaskModel> list = [];
      for (Map<String, dynamic> jsonDat in response.body!['data']) {
        list.add(TaskModel.fromJson(jsonDat));
      }
      _completedTaskList = list;
    } else {
      if (mounted) {
        showSnackBarMessage(
            context, response.errorMessage ?? 'Something went wrong!');
      }
    }
    _getCompletedTaskInProgress = false;

    if (mounted) {
      setState(() {});
    }
  }
}
