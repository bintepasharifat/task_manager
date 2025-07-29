import 'package:flutter/material.dart';
import 'package:task_manager/data/models/task_model.dart';
import 'package:task_manager/data/models/task_status_count_model.dart';
import 'package:task_manager/data/service/network_caller.dart';
import 'package:task_manager/data/urls.dart';
import 'package:task_manager/ui/screens/add_new_task.dart';
import 'package:task_manager/ui/widgets/cencel_task.dart';
import 'package:task_manager/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:task_manager/ui/widgets/snack_bar_message.dart';
import 'package:task_manager/ui/widgets/task_card.dart';

class CancelledTaskListScreen extends StatefulWidget {
  const CancelledTaskListScreen({super.key});

  @override
  State<CancelledTaskListScreen> createState() =>
      _CancelledTaskListScreenState();
}

class _CancelledTaskListScreenState extends State<CancelledTaskListScreen> {
  bool _getCancelledTaskInProgress = false;

  List<TaskModel> _cancelledTaskList = [];

  @override
  void initState() {
    super.initState();
    _getCancelledTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Visibility(
        visible: _getCancelledTaskInProgress == false,
        replacement: CenteredCircularProgressIndicator(),
        child: ListView.builder(
          itemCount: _cancelledTaskList.length,
          itemBuilder: (context, index) {
            return TaskCard(
              taskType: TaskType.progress,
              taskModel: _cancelledTaskList[index],
              onStatusUpdate: () {
                _getCancelledTaskList();
              },
            );
          },
        ),
      ),
    );
  }

  Future<void> _getCancelledTaskList() async {
    _getCancelledTaskInProgress = true;
    setState(() {});

    NetworkResponse response = await NetworkCaller.getRequest(
      url: Urls.getProgressTasksUrl,
    );

    if (response.isSuccess) {
      List<TaskModel> list = [];
      for (Map<String, dynamic> jsonDat in response.body!['data']) {
        list.add(TaskModel.fromJson(jsonDat));
      }
      _cancelledTaskList = list;
    } else {
      if (mounted) {
        showSnackBarMessage(
            context, response.errorMessage ?? 'Something went wrong!');
      }
    }
    _getCancelledTaskInProgress = false;

    if (mounted) {
      setState(() {});
    }
  }
}
