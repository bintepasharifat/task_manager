// import 'package:flutter/material.dart';
// import 'package:task_manager/ui/screens/new_task_screen.dart';
// import 'package:task_manager/ui/screens/progress_task_list_screen.dart';

// import 'package:task_manager/ui/widgets/tm_app_bar.dart';

// class MainNaveBarHoldrScreen extends StatefulWidget {
//   const MainNaveBarHoldrScreen({super.key});
//   static const String routeName = '/main-navi-bar';

//   @override
//   State<MainNaveBarHoldrScreen> createState() => _MainNaveBarHoldrScreenState();
// }

// class _MainNaveBarHoldrScreenState extends State<MainNaveBarHoldrScreen> {
//   List<Widget> _screens = [
//     NewTaskScreen(),
//     ProgressTaskListScreen(),
//   ];
//   int _slectedIndex = 0;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: TmAppBar(),
//       body: _screens[_slectedIndex],
//       bottomNavigationBar: NavigationBar(
//           selectedIndex: _slectedIndex,
//           onDestinationSelected: (int index) {
//             _slectedIndex = index;
//             setState(() {});
//           },
//           destinations: [
//             NavigationDestination(
//                 icon: Icon(Icons.new_label_outlined), label: 'New'),
//             NavigationDestination(
//                 icon: Icon(Icons.arrow_circle_down_outlined),
//                 label: 'Progress'),
//             NavigationDestination(icon: Icon(Icons.done), label: 'Complated'),
//             NavigationDestination(icon: Icon(Icons.cancel), label: 'Cancelled'),
//           ]),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:task_manager/ui/screens/cancelled_task_list_screen.dart';
import 'package:task_manager/ui/screens/completed_task_list_screen.dart';
import 'package:task_manager/ui/screens/new_task_screen.dart';
import 'package:task_manager/ui/screens/progress_task_list_screen.dart';
import 'package:task_manager/ui/widgets/tm_app_bar.dart';

class MainNaveBarHoldrScreen extends StatefulWidget {
  const MainNaveBarHoldrScreen({super.key});
  static const String routeName = '/main-navi-bar';

  @override
  State<MainNaveBarHoldrScreen> createState() => _MainNaveBarHoldrScreenState();
}

class _MainNaveBarHoldrScreenState extends State<MainNaveBarHoldrScreen> {
  final List<Widget> _screens = [
    NewTaskScreen(),
    ProgressTaskListScreen(),
    CompletedTaskListScreen(),
    CancelledTaskListScreen(),
    Center(child: Text('Progress Screen')),
    Center(child: Text('Completed Screen')),
    Center(child: Text('Cancelled Screen')),
  ];

  int _slectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TmAppBar(),
      body: _screens[_slectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _slectedIndex,
        onDestinationSelected: (int index) {
          setState(() {
            _slectedIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
              icon: Icon(Icons.new_label_outlined), label: 'New'),
          NavigationDestination(
              icon: Icon(Icons.arrow_circle_down_outlined), label: 'Progress'),
          NavigationDestination(icon: Icon(Icons.done), label: 'Completed'),
          NavigationDestination(icon: Icon(Icons.cancel), label: 'Cancelled'),
        ],
      ),
    );
  }
}
