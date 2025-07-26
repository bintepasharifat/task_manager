import 'package:flutter/material.dart';
import 'package:task_manager/ui/controllers/auth_controller.dart';
import 'package:task_manager/ui/screens/sign_in_screen.dart';
import 'package:task_manager/ui/screens/update_profile_screen.dart';

class TmAppBar extends StatefulWidget implements PreferredSizeWidget {
  const TmAppBar({super.key});

  @override
  State<TmAppBar> createState() => _TmAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _TmAppBarState extends State<TmAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.green,
      title: GestureDetector(
        onTap: _onTapProfileBar,
        child: Row(
          children: [
            CircleAvatar(),
            SizedBox(
              width: 16,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AuthController.userModel!.firstName +
                        ' ' +
                        AuthController.userModel!.lastName,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                  Text(
                    AuthController.userModel!.email,
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: Colors.white),
                  ),
                ],
              ),
            ),
            IconButton(onPressed: _onTapLogOUtButton, icon: Icon(Icons.logout))
          ],
        ),
      ),
    );
  }

  void _onTapLogOUtButton() async {
    await AuthController.clearData();
    Navigator.pushNamedAndRemoveUntil(
        context, SignInScreen.routeName, (predicate) => false);
  }

  void _onTapProfileBar() {
    if (ModalRoute.of(context)!.settings.name !=
        UpdateProfileScreen.routeName) {
      Navigator.pushNamed(context, UpdateProfileScreen.routeName);
    }
  }
}
