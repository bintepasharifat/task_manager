import 'package:flutter/material.dart';
import 'package:task_manager/ui/screens/add_new_task.dart';
import 'package:task_manager/ui/screens/change_password_screen.dart';
import 'package:task_manager/ui/screens/forgot_password_email.dart';
import 'package:task_manager/ui/screens/main_nave_bar_holdr_screen.dart';
import 'package:task_manager/ui/screens/pin_verification_screen.dart';
import 'package:task_manager/ui/screens/sign_in_screen.dart';
import 'package:task_manager/ui/screens/sign_up_screen.dart';
import 'package:task_manager/ui/screens/splash_screen.dart';
import 'package:task_manager/ui/screens/update_profile_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static GlobalKey<NavigatorState> navigator = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigator,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          hintStyle: TextStyle(color: Colors.grey),
          border: OutlineInputBorder(),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.green, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 2),
          ),
        ),
      ),
      initialRoute: SplashScreen.routeName,
      routes: {
        SplashScreen.routeName: (context) => const SplashScreen(),
        SignInScreen.routeName: (context) => const SignInScreen(),
        SignUpScreen.routeName: (context) => const SignUpScreen(),
        ForgotPasswordEmailScreen.routeName: (context) =>
            const ForgotPasswordEmailScreen(),
        PinVerificationScreen.routeName: (context) =>
            const PinVerificationScreen(),
        ChangePasswordScreen.routeName: (context) =>
            const ChangePasswordScreen(),
        MainNaveBarHoldrScreen.routeName: (context) =>
            const MainNaveBarHoldrScreen(),
        AddNewTask.routeName: (context) => const AddNewTask(),
        UpdateProfileScreen.routeName: (context) => const UpdateProfileScreen(),
      },
    );
  }
}
