// import 'package:email_validator/email_validator.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:task_manager/ui/utils/assets_imagepath.dart';
// import 'package:task_manager/ui/widgets/screen_background.dart';
// import 'package:task_manager/ui/widgets/tm_app_bar.dart';

// class UpdateProfileScreen extends StatefulWidget {
//   const UpdateProfileScreen({super.key});
//   static const String routeName = '/update_profile_screen';

//   @override
//   State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
// }

// class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final TextEditingController _firstNameController = TextEditingController();
//   final TextEditingController _lastNameController = TextEditingController();
//   final TextEditingController _phoneController = TextEditingController();
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: TmAppBar(),
//       body: ScreenBackground(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(16),
//             child: Form(
//               key: _formKey,
//               autovalidateMode: AutovalidateMode.onUserInteraction,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   SizedBox(
//                     height: 80,
//                   ),
//                   Text('Update Profile',
//                       style:
//                           TextStyle(fontSize: 28, fontWeight: FontWeight.w700)),
//                   SizedBox(
//                     height: 24,
//                   ),
//                   TextFormField(
//                     controller: _emailController,
//                     textInputAction: TextInputAction.next,
//                     decoration: InputDecoration(
//                       hintText: 'Email',
//                     ),
//                     validator: (String? value) {
//                       String email = value ?? '';
//                       if (EmailValidator.validate(email) == false) {
//                         return 'Enter a valid email';
//                       }
//                       return null;
//                     },
//                   ),
//                   SizedBox(
//                     height: 24,
//                   ),
//                   TextFormField(
//                     controller: _firstNameController,
//                     textInputAction: TextInputAction.next,
//                     decoration: InputDecoration(
//                       hintText: 'First Name',
//                     ),
//                     validator: (String? value) {
//                       if (value?.trim().isEmpty ?? true) {
//                         return 'Enter your first name';
//                       }

//                       return null;
//                     },
//                   ),
//                   SizedBox(
//                     height: 24,
//                   ),
//                   TextFormField(
//                     controller: _lastNameController,
//                     textInputAction: TextInputAction.next,
//                     decoration: InputDecoration(
//                       hintText: 'Last Name',
//                     ),
//                     validator: (String? value) {
//                       if (value?.trim().isEmpty ?? true) {
//                         return 'Enter your Last name';
//                       }

//                       return null;
//                     },
//                   ),
//                   SizedBox(
//                     height: 24,
//                   ),
//                   TextFormField(
//                     controller: _phoneController,
//                     textInputAction: TextInputAction.next,
//                     obscureText: true,
//                     keyboardType: TextInputType.phone,
//                     decoration: InputDecoration(
//                       hintText: 'Mobil Number',
//                     ),
//                     validator: (String? value) {
//                       if (value?.trim().isEmpty ?? true) {
//                         return 'Enter your mobil number';
//                       }

//                       return null;
//                     },
//                   ),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   TextFormField(
//                     controller: _passwordController,
//                     obscureText: true,
//                     decoration: InputDecoration(
//                       fillColor: Colors.white,
//                       hintText: 'Password',
//                     ),
//                     validator: (String? value) {
//                       if ((value?.length ?? 0) <= 6) {
//                         return 'Enter a valid password';
//                       }
//                       return null;
//                     },
//                   ),
//                   SizedBox(
//                     height: 16,
//                   ),
//                   ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(8)),
//                           padding: EdgeInsets.symmetric(vertical: 12),
//                           backgroundColor: Colors.green,
//                           foregroundColor: Colors.white,
//                           fixedSize: Size.fromWidth(double.maxFinite)),
//                       onPressed: _onTapSubmitButton,
//                       child: Icon(Icons.arrow_circle_down_outlined)),
// //                   SizedBox(
//                     height: 32,
//                   ),
//                   Center(
//                     child: RichText(
//                         text: TextSpan(
//                             text: " Have an acount?",
//                             style: TextStyle(
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.w600,
//                                 color: Colors.black,
//                                 letterSpacing: 0.6),
//                             children: [
//                           TextSpan(
//                               text: "Sign In",
//                               style: TextStyle(
//                                   color: Colors.green,
//                                   fontWeight: FontWeight.w700),
//                               recognizer: TapGestureRecognizer()
//                                 ..onTap = _onTapSubmitButton),
//                         ])),
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   void _onTapSubmitButton() {
//     if (_formKey.currentState!.validate()) {}
//   }

//   @override
//   void dispose() {
//     _emailController.dispose();
//     _passwordController.dispose();
//     _firstNameController.dispose();
//     _lastNameController.dispose();
//     _phoneController.dispose();
//     super.dispose();
//   }
// }
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';
import 'package:task_manager/ui/widgets/tm_app_bar.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  static const String routeName = '/update-profile';

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _phoneTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ImagePicker _imagePicker = ImagePicker();
  XFile? _selectedImage;
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TmAppBar(),
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
                  const SizedBox(height: 40),
                  Text(
                    'Update Profile',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 24),
                  _buildPhotoPicker(),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _emailTEController,
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
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _firstNameTEController,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(hintText: 'First name'),
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return 'Enter your first name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _lastNameTEController,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(hintText: 'Last name'),
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return 'Enter your Last name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _phoneTEController,
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(hintText: 'Phone'),
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return 'Enter your mobile number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 8),
                  
                  TextFormField(
                    controller: _passwordTEController,
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
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
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        padding: EdgeInsets.symmetric(vertical: 12),
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        fixedSize: Size.fromWidth(double.maxFinite)),
                    onPressed: _onTapSubmitButton,
                    child: Icon(Icons.arrow_circle_right_outlined),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPhotoPicker() {
    return GestureDetector(
      onTap: _onTapPhotoPicker,
      child: Container(
        height: 50,
        width: double.maxFinite,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
        ),
        child: Row(
          children: [
            Container(
              width: 100,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                'Photo',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              _selectedImage == null ? 'Select image' : _selectedImage!.name,
              maxLines: 1,
              style: TextStyle(overflow: TextOverflow.ellipsis),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _onTapPhotoPicker() async {
    final XFile? pickedImage =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      _selectedImage = pickedImage;
      setState(() {});
    }
  }

  void _onTapSubmitButton() {
    if (_formKey.currentState!.validate()) {
      // TODO: Update profile with API
    }
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    _firstNameTEController.dispose();
    _lastNameTEController.dispose();
    _phoneTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }
}
