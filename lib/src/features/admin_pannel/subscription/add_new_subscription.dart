import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_takes_app/src/common/constants/global_variable.dart';
import 'package:tech_takes_app/src/common/widgets/custom_appbar.dart';
import 'package:tech_takes_app/src/common/widgets/loginbutton.dart';
import 'package:tech_takes_app/src/features/admin_pannel/admin_home/pages/predictions_view.dart';
import 'package:tech_takes_app/src/features/user/forgot_password/controller/password_visiblity_controller.dart';

import '../../../common/strings/app_strings.dart';
import '../../../common/widgets/textformfield_widget.dart';

// Make sure to import LoginTextfield

class AddNewSubscriptionScreen extends StatefulWidget {
  const AddNewSubscriptionScreen({super.key});

  @override
  _AddNewSubscriptionScreenState createState() =>
      _AddNewSubscriptionScreenState();
}

class _AddNewSubscriptionScreenState extends State<AddNewSubscriptionScreen> {
  // Text controllers for input fields
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController subscriptionTypeController =
      TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();

  // Form key for validation
  final _formKey = GlobalKey<FormState>();

  // Submit function to validate form
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // If the form is valid, navigate to PredictionsPage
      Get.offAll(() => PredictionsPage());
    }
  }

  @override
  Widget build(BuildContext context) {
    Get.put(PasswordVisibilityController());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
          preferredSize: Size(double.infinity, 80),
          child: DecoratedAppBar(
            title: 'Add New Subscription',
            endWidget: SizedBox(),
            leadingWidget: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Icon(
                Icons.arrow_back,
                color: colorScheme(context).surface,
              ),
            ),
          )),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey, // Assign the global key for validation
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Name Field
              LoginTextfield(
                controller: nameController,
                hintText: "Name",
                keyboard1: TextInputType.text,
                validator1: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              LoginTextfield(
                controller: emailController,
                hintText: "Email",
                keyboard1: TextInputType.emailAddress,
                validator1: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  } else if (!GetUtils.isEmail(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Subscription Type Field
              LoginTextfield(
                controller: subscriptionTypeController,
                hintText: "Subscription Type",
                keyboard1: TextInputType.text,
                validator1: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter subscription type';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Start and End Date Fields (Row Layout)
              Padding(
                padding: EdgeInsets.only(right: 5),
                child: Row(
                  children: [
                    Expanded(
                      child: LoginTextfield(
                        controller: startDateController,
                        hintText: "Start Date",
                        keyboard1: TextInputType.datetime,
                        validator1: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a start date';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: LoginTextfield(
                        controller: endDateController,
                        hintText: "End Date",
                        keyboard1: TextInputType.datetime,
                        validator1: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter an end date';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 120),

              // Save Button
              LoginButton(
                text: AppStrings.save,
                func: _submitForm, // Call _submitForm on button press
              ),
            ],
          ),
        ),
      ),
    );
  }
}
