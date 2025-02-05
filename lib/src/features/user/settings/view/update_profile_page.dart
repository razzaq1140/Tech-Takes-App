import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tech_takes_app/src/common/constants/app_colors.dart';
import 'package:tech_takes_app/src/common/constants/global_variable.dart';
import 'package:tech_takes_app/src/common/widgets/custom_appbar.dart';
import 'package:tech_takes_app/src/common/widgets/loginbutton.dart';
import 'package:tech_takes_app/src/common/widgets/textformfield_widget.dart';
import 'package:tech_takes_app/src/features/user/forgot_password/controller/password_visiblity_controller.dart';
import 'package:tech_takes_app/src/features/user/settings/view/settings_view.dart';
import 'package:tech_takes_app/src/features/user/user_bottom_navigation/view/bottom_navigation_view.dart';
import 'package:tech_takes_app/src/theme/app_color_scheme.dart';

class UpdateProfilePage extends StatefulWidget {
  const UpdateProfilePage({super.key});

  @override
  State<UpdateProfilePage> createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  final name = TextEditingController();
  final email = TextEditingController();
  final phoneNumber = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final ImagePicker _picker = ImagePicker();
  final ValueNotifier<File?> _profileImageNotifier = ValueNotifier<File?>(null);

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      _profileImageNotifier.value = File(pickedFile.path);
    }
  }

  // Validation for Full Name
  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your full name';
    }
    return null;
  }

  // Validation for Phone Number
  String? _validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your phone number';
    }
    if (value.length < 10) {
      return 'Phone number should be at least 10 digits';
    }
    return null;
  }

  // Validation for Bio (Email field in your code)
  String? _validateBio(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a bio';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    // Regular expression for email validation
    final emailRegExp =
        RegExp(r'^[a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (!emailRegExp.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    Get.put(PasswordVisibilityController());

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size(double.infinity, 80),
          child: DecoratedAppBar(
            endWidget: SizedBox(),
            title: 'Update Profile',
            leadingWidget: GestureDetector(
              onTap: () {
                Get.off(BottomNavigationPage());
              },
              child: Icon(
                Icons.arrow_back,
                color: colorScheme(context).surface,
                size: 19,
              ),
            ),
          )),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Center(
                child: Stack(
                  children: [
                    Container(
                      height: 110,
                      width: 130,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: colorScheme(context).primary, width: 5),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ValueListenableBuilder<File?>(
                            valueListenable: _profileImageNotifier,
                            builder: (context, profileImage, child) {
                              return CircleAvatar(
                                radius: 50,
                                backgroundImage: profileImage != null
                                    ? FileImage(profileImage) as ImageProvider
                                    : NetworkImage(
                                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSwRPWpO-12m19irKlg8znjldmcZs5PO97B6A&s'), // Default image URL
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () {
                          _pickImage();
                        },
                        child: Container(
                          padding: EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: colorScheme(context).primary, width: 4),
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.white,
                          ),
                          child: Icon(Icons.photo_outlined,
                              color: colorScheme(context).primary, size: 20),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text('James S. Hernandez',
                  style: textTheme(context).headlineSmall?.copyWith(
                      color: colorScheme(context).onSurface,
                      fontWeight: FontWeight.bold)),
              SizedBox(
                height: 5,
              ),
              Text('hernandex.redial@gmail.ac.in',
                  style: textTheme(context).bodySmall?.copyWith(
                      color: colorScheme(context).onSurface,
                      fontSize: 10,
                      fontWeight: FontWeight.w500)),
              const SizedBox(
                height: 50,
              ),
              LoginTextfield(
                hintText: 'Full Name',
                controller: name,
                keyboard1: TextInputType.text,
                validator1: _validateName,
              ),
              SizedBox(
                height: 20,
              ),
              LoginTextfield(
                hintText: 'Email',
                controller: phoneNumber,
                keyboard1: TextInputType.phone,
                validator1: _validateEmail,
              ),
              const SizedBox(
                height: 20,
              ),
              LoginTextfield(
                hintText: 'Phone Number',
                controller: email,
                keyboard1: TextInputType.text,
                validator1: _validatePhoneNumber,
              ),
              const SizedBox(
                height: 30,
              ),
              LoginButton(
                text: 'Update Profile',
                func: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    Get.to(BottomNavigationPage());
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
