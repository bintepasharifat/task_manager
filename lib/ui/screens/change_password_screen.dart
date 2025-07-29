import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager/data/models/verifcation_data_model.dart';
import 'package:task_manager/data/service/network_caller.dart';
import 'package:task_manager/data/urls.dart';
import 'package:task_manager/ui/screens/pin_verification_screen.dart';
import 'package:task_manager/ui/screens/sign_in_screen.dart';
import 'package:task_manager/ui/screens/sign_up_screen.dart';
import 'package:task_manager/ui/utils/assets_imagepath.dart';
import 'package:task_manager/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';
import 'package:task_manager/ui/widgets/snack_bar_message.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});
  static const String routeName = '/change-password';

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confrmController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _resetPasswordInProgress = false;

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _confirmPassword = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 80),
                Text(
                  'Set password',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 20),
                Text(
                  'Minnmum length password 8 digit',
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey,
                      fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 24),

                /// 🔐 Password Field
                TextFormField(
                  controller: _passwordController,
                  textInputAction: TextInputAction.next,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                  ),
                  validator: (String? value) {
                    if ((value?.length ?? 0) <= 6) {
                      return 'Enter a valid password';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                /// 🔐 Confirm Password Field
                TextFormField(
                  controller: _confrmController,
                  obscureText: _obscureConfirmPassword,
                  decoration: InputDecoration(
                    hintText: 'Confirm Password',
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureConfirmPassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureConfirmPassword = !_obscureConfirmPassword;
                        });
                      },
                    ),
                  ),
                  validator: (String? value) {
                    if ((value ?? '') != _passwordController.text) {
                      return "Confirm password doesn't match";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                /// ✅ Confirm Button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    fixedSize: const Size.fromWidth(double.maxFinite),
                  ),
                  onPressed: _onTapSignInButton,
                  child: Text('Confirm'),
                ),
                const SizedBox(height: 32),

                /// 🔄 Sign In Option
                Center(
                  child: RichText(
                    text: TextSpan(
                      text: " Have an account?",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(
                          text: " Sign In",
                          style: const TextStyle(
                              color: Colors.green, fontWeight: FontWeight.w700),
                          recognizer: TapGestureRecognizer()
                            ..onTap = _onTapSignInButton,
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
    );
  }

  void _onTapSignInButton() {
    Navigator.pushNamedAndRemoveUntil(
      context,
      SignInScreen.routeName,
      (predicate) => false,
    );
  }

  Future<void> _resetPassword() async {
    _resetPasswordInProgress = true;
    if (mounted) {
      setState(() {});
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();

    Map<String, String> requestBody = {
      "email": prefs.getString('email') ?? '',
      "OTP": prefs.getString('UserOtp') ?? '',
      "password": _confrmController.text,
    };
    NetworkResponse response = await NetworkCaller.postRequest(
      url: Urls.resetPasswordUrl,
      body: requestBody,
      isFromLogin: false,
    );

    if (response.isSuccess) {
      VerificationDataModel PasswordResetVerificationDataModel =
          VerificationDataModel.fromJson(response.body!);

      String getStatus = PasswordResetVerificationDataModel.status ?? '';
      String getData = PasswordResetVerificationDataModel.data ?? '';

      if (getStatus == 'success') {
        _resetPasswordInProgress = false;
        if (mounted) {
          _passwordController.clear();
          _confrmController.clear();
          showSnackBarMessage(context, "$getStatus $getData");
          showSnackBarMessage(context, 'Please Sign In With New Password');
          await Future.delayed(Duration(seconds: 1));
          await Navigator.pushNamedAndRemoveUntil(
            context,
            SignInScreen.routeName,
            (predicate) => false,
          );
        }
      } else {
        if (mounted) {
          _resetPasswordInProgress = false;
          showSnackBarMessage(context, "$getStatus $getData");
        }
      }
    } else {
      if (mounted) {
        _resetPasswordInProgress = false;
        showSnackBarMessage(context, response.errorMessage!);
      }
    }

    _resetPasswordInProgress = false;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confrmController.dispose();
    super.dispose();
  }
}
