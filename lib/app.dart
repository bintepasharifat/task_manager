// import 'package:flutter/material.dart';
// import 'package:task_manager/ui/screens/sign_in_screen.dart';

// import 'package:task_manager/ui/screens/splash_screen.dart';

// class TaskManagerApp extends StatelessWidget {
//   const TaskManagerApp({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData(
//           primarySwatch: Colors.green,
//           textTheme: TextTheme(
//               titleLarge: TextStyle(fontSize: 28, fontWeight: FontWeight.w700)),
//           inputDecorationTheme: InputDecorationTheme(
//               fillColor: Colors.white,
//               contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//               hintStyle: TextStyle(color: Colors.grey),
//               filled: true,
//               border: OutlineInputBorder(
//                 borderSide: BorderSide.none,
//               ),
//               enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
//               focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
//               errorBorder: OutlineInputBorder(borderSide: BorderSide.none)),
//           textButtonTheme: TextButtonThemeData(
//               style: TextButton.styleFrom(foregroundColor: Colors.green))),
//               initialRoute: SplashScreen.name, 
//   routes: {
//     SplashScreen.name: (context) => SplashScreen(),
//     SingInScreen.name: (context) => SignI(),
//   },
      
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:task_manager/ui/screens/sign_in_screen.dart';
import 'package:task_manager/ui/screens/splash_screen.dart';

class TaskManagerApp extends StatelessWidget {
  static var navigator;

  const TaskManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        textTheme: const TextTheme(
          titleLarge: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          fillColor: Colors.white,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          hintStyle: TextStyle(color: Colors.grey),
          filled: true,
          border: OutlineInputBorder(borderSide: BorderSide.none),
          enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
          focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
          errorBorder: OutlineInputBorder(borderSide: BorderSide.none),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(foregroundColor: Colors.green),
        ),
      ),
      initialRoute: SplashScreen.routeName,
      routes: {
        SplashScreen.routeName: (context) => const SplashScreen(),
        SignInScreen.routeName: (context) => const SignInScreen(),
      },
    );
  }
}
