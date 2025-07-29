import 'package:flutter/material.dart';
import 'package:task_manager/data/models/task_model.dart';
import 'package:task_manager/data/models/task_status_count_model.dart';
import 'package:task_manager/data/service/network_caller.dart';
import 'package:task_manager/data/urls.dart';
import 'package:task_manager/ui/screens/add_new_task.dart';
import 'package:task_manager/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:task_manager/ui/widgets/snack_bar_message.dart';
import 'package:task_manager/ui/widgets/task_card.dart';
import 'package:task_manager/ui/widgets/task_count_summary_card.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  bool _getNewTaskInProgress = false;
  bool _getTaskStatusCountInProgress = false;
  List<TaskModel> _newTaskList = [];
  List<TaskStatusCountModel> _taskStatusCount = [];

  @override
  void initState() {
    super.initState();

    _getNewTask();
    __getTaskStatusCount();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 16),
            SizedBox(
              height: 120,
              child: Visibility(
                visible: _getTaskStatusCountInProgress == false,
                replacement: CenteredCircularProgressIndicator(),
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    return TaskCountSummaryCard(
                        title: _taskStatusCount[index].id,
                        count: _taskStatusCount[index].count);
                  },
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 8),
                  itemCount: _taskStatusCount.length,
                  scrollDirection: Axis.horizontal,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Visibility(
              visible: _getNewTaskInProgress == false,
              replacement: CenteredCircularProgressIndicator(),
              child: Expanded(
                child: ListView.builder(
                  itemCount: _newTaskList.length,
                  itemBuilder: (context, index) {
                    return TaskCard(
                      taskType: TaskType.tNew,
                      taskModel: _newTaskList[index],
                      onStatusUpdate: _getNewTask,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onTapAddNewTaskButton,
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _getNewTask() async {
    _getNewTaskInProgress = true;
    setState(() {});

    NetworkResponse response = await NetworkCaller.getRequest(
      url: Urls.getNewTasksUrl,
    );

    _getNewTaskInProgress = false;

    if (response.isSuccess) {
      List<TaskModel> list = [];
      for (Map<String, dynamic> jsonDat in response.body!['data']) {
        list.add(TaskModel.fromJson(jsonDat));
      }
      _newTaskList = list;
    } else {
      if (mounted) {
        showSnackBarMessage(
            context, response.errorMessage ?? 'Something went wrong!');
      }
    }
    _getNewTaskInProgress = false;

    if (mounted) {
      setState(() {});
    }
  }

  Future<void> __getTaskStatusCount() async {
    _getTaskStatusCountInProgress = true;
    setState(() {});

    NetworkResponse response = await NetworkCaller.getRequest(
      url: Urls.getTaskStatusCountUrl,
    );

    if (response.isSuccess) {
      List<TaskStatusCountModel> list = [];
      for (Map<String, dynamic> jsonDat in response.body!['data']) {
        list.add(TaskStatusCountModel.fromJson(jsonDat));
      }
      _taskStatusCount = list;
    } else {
      if (mounted) {
        showSnackBarMessage(
            context, response.errorMessage ?? 'Something went wrong!');
      }
    }
    _getTaskStatusCountInProgress = false;

    if (mounted) {
      setState(() {});
    }
  }

  void _onTapAddNewTaskButton() {
    Navigator.pushNamed(context, AddNewTask.routeName);
  }
}
