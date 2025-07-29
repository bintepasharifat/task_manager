// import 'package:email_validator/email_validator.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:task_manager/ui/screens/pin_verification_screen.dart';
// import 'package:task_manager/ui/screens/sign_up_screen.dart';
// import 'package:task_manager/ui/utils/assets_imagepath.dart';
// import 'package:task_manager/ui/widgets/screen_background.dart';

// class ForgotPasswordEmail extends StatefulWidget {
//   const ForgotPasswordEmail({super.key});
//   static const String routeName = '/forgot-password-email';

//   @override
//   State<ForgotPasswordEmail> createState() => _ForgotPasswordEmailState();
// }

// class _ForgotPasswordEmailState extends State<ForgotPasswordEmail> {
//   final TextEditingController _emailController = TextEditingController();

//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: ScreenBackground(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(16),
//           child: Form(
//             key: _formKey,
//             autovalidateMode: AutovalidateMode.onUserInteraction,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const SizedBox(height: 80),
//                 Text('Your Email Address',
//                     style:
//                         TextStyle(fontSize: 28, fontWeight: FontWeight.w700)),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 Text('A 6 dights OTP will be sent to your email address',
//                     style: TextStyle(
//                         fontSize: 15,
//                         color: Colors.grey,
//                         fontWeight: FontWeight.w700)),
//                 const SizedBox(height: 24),
//                 TextFormField(
//                   controller: _emailController,
//                   textInputAction: TextInputAction.next,
//                   decoration: const InputDecoration(hintText: 'Email'),
//                   validator: (String? value) {
//                     String email = value ?? '';
//                     if (!EmailValidator.validate(email) == false) {
//                       return 'Enter a valid email';
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 16),
//                 ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8)),
//                     padding: const EdgeInsets.symmetric(vertical: 12),
//                     backgroundColor: Colors.green,
//                     foregroundColor: Colors.white,
//                     fixedSize: const Size.fromWidth(double.maxFinite),
//                   ),
//                   onPressed: _onTapsubmitButton,
//                   child: const Icon(Icons.arrow_circle_down_outlined),
//                 ),
//                 const SizedBox(height: 32),
//                 Center(
//                   child: RichText(
//                     text: TextSpan(
//                       text: " Have an account?",
//                       style: const TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.w600,
//                         color: Colors.black,
//                       ),
//                       children: [
//                         TextSpan(
//                           text: " Sign In",
//                           style: const TextStyle(
//                               color: Colors.green, fontWeight: FontWeight.w700),
//                           recognizer: TapGestureRecognizer()
//                             ..onTap = _ontapSignInButton,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   void _onTapsubmitButton() {
//     if (_formKey.currentState!.validate()) {}
//     Navigator.pushNamed(context, PinVerificationScreen.routeName);
//   }

//   void _ontapSignInButton() {
//     Navigator.pop(context);
//   }

//   @override
//   void dispose() {
//     _emailController.dispose();

//     super.dispose();
//   }
// }
import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager/data/models/verifcation_data_model.dart';
import 'package:task_manager/data/service/network_caller.dart';
import 'package:task_manager/data/urls.dart';
import 'package:task_manager/ui/screens/pin_verification_screen.dart';
import 'package:task_manager/ui/screens/sign_in_screen.dart';
import 'package:task_manager/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';
import 'package:task_manager/ui/widgets/snack_bar_message.dart';

class ForgotPasswordEmailScreen extends StatefulWidget {
  const ForgotPasswordEmailScreen({super.key});

  static const String routeName = '/forgot-password-email';

  @override
  State<ForgotPasswordEmailScreen> createState() =>
      _ForgotPasswordEmailScreenState();
}

class _ForgotPasswordEmailScreenState extends State<ForgotPasswordEmailScreen> {
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _emaillisLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 80),
                  Text(
                    'Your Email Address',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'A 6 digits OTP will be sent to your email address',
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(color: Colors.grey),
                  ),
                  const SizedBox(height: 24),
                  TextFormField(
                    controller: _emailController,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(hintText: 'Email'),
                    validator: (String? value) {
                      String email = value ?? '';
                      if (EmailValidator.validate(email) == false) {
                        return 'Enter a valid email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      fixedSize: const Size.fromWidth(double.maxFinite),
                    ),
                    onPressed: _onTapSubmitButton,
                    child: const Icon(Icons.arrow_circle_down_outlined),
                  ),
                  const SizedBox(height: 32),
                  Center(
                    child: RichText(
                      text: TextSpan(
                        text: "Have an account? ",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          letterSpacing: 0.4,
                        ),
                        children: [
                          TextSpan(
                            text: 'Sign In',
                            style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.w700,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = _onTapSubmitButton,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onTapSubmitButton() {
    Navigator.pushNamedAndRemoveUntil(
      context,
      PinVerificationScreen.routeName,
      (predicate) => false,
    );
  }

  Future<void> _getOtpMail() async {
    _emaillisLoading = true;
    if (mounted) {
      setState(() {});
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token') ?? '';

    NetworkResponse response = await NetworkCaller.getRequest(
      url: Urls.recoverVerifyEmailUrl(_emailController.text.trim()),
    );
    if (response.isSuccess) {
      VerificationDataModel emailVerificationDataModel =
          VerificationDataModel.fromJson(response.body!);

      String getStatus = emailVerificationDataModel.status ?? '';
      String getData = emailVerificationDataModel.data ?? '';

      if (getStatus == 'success') {
        _emaillisLoading = false;
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        sharedPreferences.setString('email', _emailController.text.trim());
        if (mounted) {
          _emailController.clear();
          showSnackBarMessage(context, "$getStatus $getData");
          await Future.delayed(Duration(seconds: 1));
          await Navigator.pushNamedAndRemoveUntil(
            context,
            PinVerificationScreen.routeName,
            (predicate) => false,
          );
        }
      } else {
        if (mounted) {
          _emaillisLoading = false;
          showSnackBarMessage(context, "$getStatus $getData");
        }
      }
    } else {
      if (mounted) {
        _emaillisLoading = false;
        showSnackBarMessage(context, response.errorMessage!);
      }
    }

    _emaillisLoading = false;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }
}
