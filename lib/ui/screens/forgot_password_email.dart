import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:task_manager/ui/screens/pin_verification_screen.dart';
import 'package:task_manager/ui/screens/sign_up_screen.dart';
import 'package:task_manager/ui/utils/assets_imagepath.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';

class ForgotPasswordEmail extends StatefulWidget {
  const ForgotPasswordEmail({super.key});
  static const String routeName = '/forgot-password-email';

  @override
  State<ForgotPasswordEmail> createState() => _ForgotPasswordEmailState();
}

class _ForgotPasswordEmailState extends State<ForgotPasswordEmail> {
  final TextEditingController _emailController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
                Text('Your Email Address',
                    style:
                        TextStyle(fontSize: 28, fontWeight: FontWeight.w700)),
                SizedBox(
                  height: 20,
                ),
                Text('A 6 dights OTP will be sent to your email address',
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey,
                        fontWeight: FontWeight.w700)),
                const SizedBox(height: 24),
                TextFormField(
                  controller: _emailController,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(hintText: 'Email'),
                  validator: (String? value) {
                    String email = value ?? '';
                    if (!EmailValidator.validate(email) == false) {
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
                  onPressed: _onTapsubmitButton,
                  child: const Icon(Icons.arrow_circle_down_outlined),
                ),
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
    if (_formKey.currentState!.validate()) {}
    Navigator.pushNamed(context, PinVerificationScreen.routeName);
  }

  void _ontapSignInButton() {
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _emailController.dispose();

    super.dispose();
  }
}
