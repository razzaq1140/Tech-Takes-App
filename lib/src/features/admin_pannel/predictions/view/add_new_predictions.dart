// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_takes_app/src/common/constants/global_variable.dart';
import 'package:tech_takes_app/src/common/widgets/custom_appbar.dart';
import 'package:tech_takes_app/src/common/widgets/loginbutton.dart';
import 'package:tech_takes_app/src/features/admin_pannel/admin_home/pages/predictions_view.dart';
import 'package:tech_takes_app/src/features/user/forgot_password/controller/password_visiblity_controller.dart';

import '../../../../common/widgets/textformfield_widget.dart';

class AddNewPredictionScreen extends StatefulWidget {
  const AddNewPredictionScreen({super.key});

  @override
  _AddNewPredictionScreenState createState() => _AddNewPredictionScreenState();
}

class _AddNewPredictionScreenState extends State<AddNewPredictionScreen> {
  final TextEditingController oddsController = TextEditingController();
  final TextEditingController unitSizeController = TextEditingController();
  final TextEditingController predictionController = TextEditingController();
  final TextEditingController gameController = TextEditingController();
  final TextEditingController startTimeController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      Get.to(() => const PredictionsPage());
    }
  }

  @override
  Widget build(BuildContext context) {
    Get.put(PasswordVisibilityController());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
          preferredSize: const Size(double.infinity, 80),
          child: DecoratedAppBar(
            leadingWidget: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Icon(
                Icons.arrow_back,
                color: colorScheme(context).surface,
              ),
            ),
            endWidget: const SizedBox(),
            title: 'Add new Prediction',
          )),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey, // Assign the form key to the Form widget
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Add Odds",
                    style: textTheme(context).bodyLarge?.copyWith(
                        color: colorScheme(context).onSurface,
                        fontWeight: FontWeight.w600,
                        fontSize: 15)),
                const SizedBox(height: 10),
                LoginTextfield(
                  controller: oddsController,
                  hintText: "Add Odds",
                  keyboard1: TextInputType.number,
                  texttype: "odds",
                  validator1: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the odds';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                Text("Unit Size",
                    style: textTheme(context).bodyLarge?.copyWith(
                        color: colorScheme(context).onSurface,
                        fontWeight: FontWeight.w600,
                        fontSize: 15)),
                const SizedBox(height: 10),
                LoginTextfield(
                  controller: unitSizeController,
                  hintText: "Unit Size",
                  keyboard1: TextInputType.text,
                  texttype: "unitSize",
                  validator1: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the unit size';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                Text("Teams Logo",
                    style: textTheme(context).bodyLarge?.copyWith(
                        color: colorScheme(context).onSurface,
                        fontWeight: FontWeight.w600,
                        fontSize: 15)),
                const SizedBox(height: 8),
                Image.asset(
                  "assets/images/blue.png", // Replace with the actual image path
                  width: 80,
                  height: 80,
                ),
                const SizedBox(height: 16),
                Text("Prediction",
                    style: textTheme(context).bodyLarge?.copyWith(
                        color: colorScheme(context).onSurface,
                        fontWeight: FontWeight.w600,
                        fontSize: 15)),
                const SizedBox(height: 10),
                LoginTextfield(
                  controller: predictionController,
                  hintText: "Prediction",
                  keyboard1: TextInputType.text,
                  texttype: "prediction",
                  validator1: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the prediction';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                Text("Game",
                    style: textTheme(context).bodyLarge?.copyWith(
                        color: colorScheme(context).onSurface,
                        fontWeight: FontWeight.w600,
                        fontSize: 15)),
                const SizedBox(height: 10),
                LoginTextfield(
                  controller: gameController,
                  hintText: "Game",
                  keyboard1: TextInputType.text,
                  texttype: "game",
                  validator1: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the game';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                Text("Start Time",
                    style: textTheme(context).bodyLarge?.copyWith(
                        color: colorScheme(context).onSurface,
                        fontWeight: FontWeight.w600,
                        fontSize: 15)),
                const SizedBox(height: 10),
                LoginTextfield(
                  controller: startTimeController,
                  hintText: "Start Time",
                  keyboard1: TextInputType.datetime,
                  sufficon: IconButton(
                    onPressed: () async {
                      TimeOfDay? pickedTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );

                      if (pickedTime != null) {
                        // Update the text field with selected time
                        final formattedTime = pickedTime.format(context);
                        startTimeController.text = formattedTime;
                      }
                    },
                    icon: const Icon(
                      Icons.timer,
                      color: Colors.black,
                    ),
                  ),
                  texttype: "startTime",
                  validator1: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the start time';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 40),
                LoginButton(
                  text: 'Save',
                  func: _submitForm,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
