import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_takes_app/src/common/constants/global_variable.dart';
import 'package:tech_takes_app/src/common/widgets/custom_appbar.dart';
import 'package:tech_takes_app/src/common/widgets/loginbutton.dart';
import 'package:tech_takes_app/src/features/admin_pannel/admin_home/pages/predictions_view.dart';
import 'package:tech_takes_app/src/features/user/forgot_password/controller/password_visiblity_controller.dart';

import '../../../common/widgets/textformfield_widget.dart';

class AddNewUser extends StatefulWidget {
  const AddNewUser({super.key});

  @override
  State<AddNewUser> createState() => _AddNewUserState();
}

class _AddNewUserState extends State<AddNewUser> {
  // Form and Text Editing Controllers
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  // Validate and Submit
  void _validateAndSubmit() {
    if (_formKey.currentState!.validate()) {
      // Form data is valid, proceed with submission
      // Add any additional logic needed for form submission here
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile Updated Successfully!')),
      );
      // Navigate to next page
      Get.offAll(() => PredictionsPage());
    }
  }

  // Validators
  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your name';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? _validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your phone number';
    }
    final phoneRegex = RegExp(r'^\d{10}$'); // Assuming a 10-digit phone number
    if (!phoneRegex.hasMatch(value)) {
      return 'Please enter a valid 10-digit phone number';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    Get.put(PasswordVisibilityController());
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   centerTitle: true,
      //   backgroundColor: Colors.white,
      //   title: const Text(
      //     'Add New User',
      //     style: TextStyle(
      //       fontSize: 20,
      //       fontWeight: FontWeight.w600,
      //     ),
      //   ),
      //   leading: IconButton(
      //     icon: const Icon(Icons.arrow_back),
      //     onPressed: () {
      //       Navigator.of(context).pop();
      //     },
      //   ),
      // ),

      appBar: PreferredSize(
          preferredSize: Size(double.infinity, 80),
          child: DecoratedAppBar(
            title: 'Add New User',
            leadingWidget: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Icon(
                Icons.arrow_back,
                color: colorScheme(context).surface,
              ),
            ),
            endWidget: SizedBox(),
          )),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 30),

                  // Name Field
                  LoginTextfield(
                    controller: _nameController,
                    hintText: 'Name',
                    validator1: _validateName, // Use validator for Name
                  ),
                  const SizedBox(height: 30),

                  // Email Field
                  LoginTextfield(
                    controller: _emailController,
                    hintText: 'Email',
                    validator1: _validateEmail, // Use validator for Email
                  ),
                  const SizedBox(height: 30),

                  // Phone Number Field
                  LoginTextfield(
                    hintText: 'Phone Number',
                    controller: _phoneController,
                    validator1:
                        _validatePhone, // Use validator for Phone Number
                  ),
                  const SizedBox(height: 150),

                  // Save Button
                  LoginButton(
                    func:
                        _validateAndSubmit, // Call _validateAndSubmit when pressed
                    text: 'Save',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
