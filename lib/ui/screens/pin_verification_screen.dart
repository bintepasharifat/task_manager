import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_manager/ui/screens/change_password_screen.dart';
import 'package:task_manager/ui/screens/sign_in_screen.dart';
import 'package:task_manager/ui/screens/sign_up_screen.dart';
import 'package:task_manager/ui/utils/assets_imagepath.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';

class PinVerificationScreen extends StatefulWidget {
  const PinVerificationScreen({super.key});
  static const String routeName = '/pin';

  @override
  State<PinVerificationScreen> createState() => _PinVerificationState();
}

class _PinVerificationState extends State<PinVerificationScreen> {
  final TextEditingController _otpController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  get errorController => null;

  get textEditingController => null;

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
                Text('Pin Verification',
                    style:
                        TextStyle(fontSize: 28, fontWeight: FontWeight.w700)),
                SizedBox(
                  height: 20,
                ),
                Text('A 6 dights OTP has been sent to your email address',
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey,
                        fontWeight: FontWeight.w700)),
                const SizedBox(height: 24),
                PinCodeTextField(
                  length: 6,
                  keyboardType: TextInputType.number,
                  animationType: AnimationType.fade,
                  pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: 50,
                      fieldWidth: 40,
                      activeFillColor: Colors.white,
                      selectedColor: Colors.green,
                      inactiveColor: Colors.grey),
                  animationDuration: Duration(milliseconds: 300),
                  backgroundColor: Colors.white,
                  controller: _otpController,
                  appContext: context,
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
                    onPressed: _onTapsubmitButton,
                    child: Text('verify')),
                const SizedBox(height: 32),
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
                            ..onTap = _ontapSignInButton,
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

  void _onTapsubmitButton() {
    if (_formKey.currentState!.validate()) {
      
    }
    Navigator.pushNamed(context, ChangePasswordScreen.routeName);
  }

  void _ontapSignInButton() {
    Navigator.pushNamedAndRemoveUntil(
        context, SignInScreen.routeName, (predicate) => false);

    @override
    void dispose() {
      _otpController.dispose();

      super.dispose();
    }
  }
}

class _emailController {}
