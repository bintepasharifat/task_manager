import 'package:flutter/material.dart';
import 'package:task_manager/data/models/task_model.dart';
import 'package:task_manager/data/service/network_caller.dart';
import 'package:task_manager/data/urls.dart';
import 'package:task_manager/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:task_manager/ui/widgets/progress_card.dart';
import 'package:task_manager/ui/widgets/snack_bar_message.dart';
import 'package:task_manager/ui/widgets/task_card.dart';

class ProgressTaskListScreen extends StatefulWidget {
  const ProgressTaskListScreen({super.key});

  @override
  State<ProgressTaskListScreen> createState() => _ProgressTaskListScreenState();
}

class _ProgressTaskListScreenState extends State<ProgressTaskListScreen> {
  bool _getProgressTaskInProgress = false;
  List<TaskModel> _progressTaskList = [];

  @override
  void initState() {
    super.initState();

    _getProgressTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Visibility(
        visible: _getProgressTaskInProgress == false,
        replacement: CenteredCircularProgressIndicator(),
        child: ListView.builder(
          itemCount: _progressTaskList.length,
          itemBuilder: (context, index) {
            return TaskCard(
              taskType: TaskType.progress,
              taskModel: _progressTaskList[index],
              onStatusUpdate: () {
                _getProgressTaskList();
              },
            );
          },
        ),
      ),
    );
  }

  Future<void> _getProgressTaskList() async {
    _getProgressTaskInProgress = true;
    setState(() {});

    NetworkResponse response = await NetworkCaller.getRequest(
      url: Urls.getProgressTasksUrl,
    );

    if (response.isSuccess) {
      List<TaskModel> list = [];
      for (Map<String, dynamic> jsonDat in response.body!['data']) {
        list.add(TaskModel.fromJson(jsonDat));
      }
      _progressTaskList = list;
    } else {
      if (mounted) {
        showSnackBarMessage(
            context, response.errorMessage ?? 'Something went wrong!');
      }
    }
    _getProgressTaskInProgress = false;

    if (mounted) {
      setState(() {});
    }
  }
}
