import 'package:flutter/material.dart';
import 'package:task_manager/data/service/network_caller.dart';
import 'package:task_manager/data/urls.dart';
import 'package:task_manager/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';
import 'package:task_manager/ui/widgets/snack_bar_message.dart';
import 'package:task_manager/ui/widgets/tm_app_bar.dart';

class AddNewTask extends StatefulWidget {
  const AddNewTask({super.key});
  static const String routeName = '/add-new-scren';
  @override
  State<AddNewTask> createState() => _AddNewTaskState();
}

class _AddNewTaskState extends State<AddNewTask> {
  final TextEditingController _TitleController = TextEditingController();
  final TextEditingController _decriptionController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _addNewTaskInProgress = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMAppBar(),
      body: ScreenBackground(
          child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 40,
              ),
              Text(
                'Add New TAsk',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 28,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: _TitleController,
                validator: (String? value) {
                  if (value?.trim().isEmpty ?? true) {
                    return 'Enter your title';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintText: 'Tile',
                ),
              ),
              SizedBox(
                height: 8,
              ),
              TextFormField(
                controller: _decriptionController,
                maxLines: 5,
                validator: (String? value) {
                  if (value?.trim().isEmpty ?? true) {
                    return 'Enter your Description';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintText: 'Description',
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Visibility(
                visible: _addNewTaskInProgress == false,
                replacement: CenteredCircularProgressIndicator(),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      fixedSize: const Size.fromWidth(double.maxFinite),
                    ),
                    onPressed: _onTapsubmitButton,
                    child: Icon(Icons.arrow_circle_right_outlined)),
              )
            ],
          ),
        ),
      )),
    );
  }

  void _onTapsubmitButton() {
    if (_formKey.currentState!.validate()) {
      _addNewTask();
    }
    // Navigator.pop(context);
  }

  Future<void> _addNewTask() async {
    _addNewTaskInProgress = true;
    setState(() {});

    Map<String, String> requestBody = {
      "title": _TitleController.text.trim(),
      "description": _decriptionController.text.trim(),
      "status": "New"
    };
    NetworkResponse response = await NetworkCaller.postRequest(
        url: Urls.createNewTaskUrl, body: requestBody, isFromLogin: true);
    _addNewTaskInProgress = false;
    setState(() {});
    if (response.isSuccess) {
      _TitleController.clear();
      _decriptionController.clear();
      showSnackBarMessage(context, 'Added new task');
    } else {
      showSnackBarMessage(context, response.errorMessage!);
    }
  }

  @override
  void dispose() {
    _TitleController.dispose();
    _decriptionController.dispose();
    super.dispose();
  }
}
