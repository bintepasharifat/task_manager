import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager/data/models/verifcation_data_model.dart';
import 'package:task_manager/data/service/network_caller.dart';
import 'package:task_manager/data/urls.dart';
import 'package:task_manager/ui/screens/change_password_screen.dart';
import 'package:task_manager/ui/screens/sign_in_screen.dart';
import 'package:task_manager/ui/screens/sign_up_screen.dart';
import 'package:task_manager/ui/utils/assets_imagepath.dart';
import 'package:task_manager/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';
import 'package:task_manager/ui/widgets/snack_bar_message.dart';

class PinVerificationScreen extends StatefulWidget {
  const PinVerificationScreen({super.key});
  static const String routeName = '/pin';

  @override
  State<PinVerificationScreen> createState() => _PinVerificationState();
}

class _PinVerificationState extends State<PinVerificationScreen> {
  final TextEditingController _otpController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _otpisLoading = false;
  // final FocusNode _focusNode = FocusNode();
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
                    onPressed: _onTapSubmitButton,
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
  //

  void _onTapSubmitButton() {
    // if (_formKey.currentState!.validate()) {
    //   // TODO: Sign in with API
    // }
    Navigator.pushNamed(context, ChangePasswordScreen.routeName);
  }

  void _onTapSignInButton() {
    Navigator.pushNamedAndRemoveUntil(
      context,
      SignInScreen.routeName,
      (predicate) => false,
    );
  }

  Future<void> _otpVerification() async {
    _otpisLoading = true;
    if (mounted) {
      setState(() {});
    }

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? Email = sharedPreferences.getString('email') ?? '';
    await sharedPreferences.setString('UserOtp', _otpController.text.trim());

    NetworkResponse response = await NetworkCaller.getRequest(
      url: Urls.veriftOtpdUrl(Email, _otpController.text.trim()),
    );
    if (response.isSuccess) {
      VerificationDataModel emailPinVerificationDataModel =
          VerificationDataModel.fromJson(response.body!);

      String getStatus = emailPinVerificationDataModel.status ?? '';
      String getData = emailPinVerificationDataModel.data ?? '';

      if (getStatus == 'success') {
        _otpisLoading = false;
        if (mounted) {
          _otpController.clear();
          showSnackBarMessage(context, "$getStatus $getData");
          showSnackBarMessage(context, 'Please set your new password');
          await Future.delayed(Duration(seconds: 1));
          await Navigator.pushNamedAndRemoveUntil(
            context,
            ChangePasswordScreen.routeName,
            (predicate) => false,
          );
        }
      } else {
        if (mounted) {
          _otpisLoading = false;
          showSnackBarMessage(context, "$getStatus $getData");
        }
      }
    } else {
      if (mounted) {
        _otpisLoading = false;
        showSnackBarMessage(context, response.errorMessage!);
      }
    }

    _otpisLoading = false;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    // _otpTEController.dispose();
    super.dispose();
  }
}

  
