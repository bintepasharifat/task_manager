import 'package:flutter/material.dart';
import 'package:task_manager/data/models/task_model.dart';
import 'package:task_manager/data/service/network_caller.dart';
import 'package:task_manager/data/urls.dart';
import 'package:task_manager/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:task_manager/ui/widgets/snack_bar_message.dart';

enum TaskType { tNew, progress, completed, cancelled }

class TaskCard extends StatefulWidget {
  const TaskCard({
    super.key,
    required this.taskType,
    required this.taskModel,
    required this.onStatusUpdate,
  });

  final TaskType taskType;
  final TaskModel taskModel;
  final VoidCallback onStatusUpdate;

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  bool _updateTaskStatusInProgress = false;
  // bool _completedTaskStatusInProgress = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.taskModel.title,
                style: Theme.of(context).textTheme.titleMedium),
            Text(widget.taskModel.description,
                style: TextStyle(color: Colors.black54)),
            Text('Date: ${widget.taskModel.createdDate}'),
            const SizedBox(height: 8),
            Row(
              children: [
                Chip(
                  label: Text(_getTaskTypeName(),
                      style: TextStyle(color: Colors.white)),
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  backgroundColor: _getTaskChipColor(),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide.none,
                  ),
                ),
                Spacer(),
                IconButton(onPressed: () {}, icon: Icon(Icons.delete)),
                Visibility(
                  visible: !_updateTaskStatusInProgress,
                  replacement: CenteredCircularProgressIndicator(),
                  child: IconButton(
                    onPressed: _showEditTaskStatusDialog,
                    icon: Icon(Icons.edit),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getTaskChipColor() {
    switch (widget.taskType) {
      case TaskType.tNew:
        return Colors.blue;
      case TaskType.progress:
        return Colors.red;
      case TaskType.completed:
        return Colors.green;
      case TaskType.cancelled:
        return Colors.red;
    }
  }

  String _getTaskTypeName() {
    switch (widget.taskType) {
      case TaskType.tNew:
        return 'New';
      case TaskType.progress:
        return 'Progress';
      case TaskType.completed:
        return 'Completed';
      case TaskType.cancelled:
        return 'Cancelled';
    }
  }

  void _showEditTaskStatusDialog() {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text('Change Status'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: TaskType.values.map((type) {
              return ListTile(
                title: Text(_getTaskTypeNameFromType(type)),
                trailing: widget.taskType == type ? Icon(Icons.check) : null,
                onTap: () {
                  if (widget.taskType != type) {
                    _updateTaskStatus(_getTaskTypeNameFromType(type));
                  }
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }

  String _getTaskTypeNameFromType(TaskType type) {
    switch (type) {
      case TaskType.tNew:
        return 'New';
      case TaskType.progress:
        return 'Progress';
      case TaskType.completed:
        return 'Completed';
      case TaskType.cancelled:
        return 'Cancelled';
    }
  }

  Future<void> _updateTaskStatus(String status) async {
    Navigator.pop(context);
    _updateTaskStatusInProgress = true;
    if (mounted) setState(() {});

    final response = await NetworkCaller.getRequest(
      url: Urls.updateTaskStatusUrl(widget.taskModel.id, status),
    );

    _updateTaskStatusInProgress = false;
    if (mounted) setState(() {});

    if (response.isSuccess) {
      widget.onStatusUpdate();
    } else {
      if (mounted) {
        showSnackBarMessage(
            context, response.errorMessage ?? 'Something went wrong!');
      }
    }
  }

}