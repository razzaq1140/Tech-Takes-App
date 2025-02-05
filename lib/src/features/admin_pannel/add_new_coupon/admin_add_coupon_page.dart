import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_takes_app/src/common/constants/app_colors.dart';
import 'package:tech_takes_app/src/common/constants/global_variable.dart';
import 'package:tech_takes_app/src/common/widgets/custom_appbar.dart';
import 'package:tech_takes_app/src/common/widgets/custom_button.dart';
import 'package:tech_takes_app/src/common/widgets/custom_text_fied.dart';
import 'package:tech_takes_app/src/common/widgets/textformfield_widget.dart';
import 'package:tech_takes_app/src/common/widgets/vip_prediction_app_bar.dart';
import 'package:tech_takes_app/src/features/admin_pannel/active_coupon/page/active_coupon.dart';
import 'package:tech_takes_app/src/features/admin_pannel/admin_home/pages/predictions_view.dart';
import 'package:tech_takes_app/src/features/user/forgot_password/controller/password_visiblity_controller.dart';
import 'package:tech_takes_app/src/theme/app_color_scheme.dart';

class AdminAddCouponPage extends StatefulWidget {
  const AdminAddCouponPage({super.key});

  @override
  State<AdminAddCouponPage> createState() => _AdminAddCouponPageState();
}

class _AdminAddCouponPageState extends State<AdminAddCouponPage> {
  // Controllers
  final TextEditingController couponController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController discountController = TextEditingController();
  final TextEditingController couponAmountController = TextEditingController();
  final TextEditingController startLateController = TextEditingController();
  final TextEditingController endLateController = TextEditingController();

  // Form key
  final _formKey = GlobalKey<FormState>();

  // Validators
  String? _validateCouponCode(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a coupon code';
    }
    return null;
  }

  String? _validateDescription(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a description';
    }
    return null;
  }

  String? _validateDiscountType(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select a discount type';
    }
    return null;
  }

  String? _validateCouponAmount(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a coupon amount';
    }
    if (double.tryParse(value) == null) {
      return 'Please enter a valid number';
    }
    return null;
  }

  String? _validateDate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a date';
    }
    return null;
  }

  // Handle form submission
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // If the form is valid, proceed with the action
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Coupon added successfully!')),
      );
      // Navigate to next screen
      Get.offAll(() => const PredictionsPage());
    }
  }

  Future<void> _selectDate(TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      controller.text =
          '${picked.toLocal()}'.split(' ')[0]; // Formatting the date
    }
  }

  @override
  Widget build(BuildContext context) {
    final PasswordVisibilityController passwordVisibilityController =
        Get.put(PasswordVisibilityController());

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size(double.infinity, 80),
          child: DecoratedAppBar(
            title: 'Add Coupon',
            endWidget: SizedBox(),
            leadingWidget: GestureDetector(
                onTap: () {
                  // Get.off(ActiveCoupomPage());
                  Get.back();
                },
                child: Icon(Icons.arrow_back,
                    color: colorScheme(context).surface)),
          )),
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Form(
          key: _formKey, // Use the form key to validate the form
          child: Column(
            children: [
              const SizedBox(height: 50),
              // Coupon Code
              CustomTextFormField(
                borderRadius: 16,
                autoValidateMode: AutovalidateMode.onUserInteraction,
                keyboardType: TextInputType.number,

                fillColor: colorSchemeLight.primary.withOpacity(0.03),
                borderColor: AppColor.appGreenColor,
                isEnabled: true,
                focusBorderColor: AppColor.appGreenColor,
                controller: couponController,
                hint: 'Enter Coupon Code',
                hintColor: const Color(0xff555555),

                validator:
                    _validateCouponCode, // Apply the coupon code validator
              ),
              const SizedBox(height: 20),

              // Description
              CustomTextFormField(
                autoValidateMode: AutovalidateMode.onUserInteraction,
                controller: descriptionController,
                fillColor: colorSchemeLight.primary.withOpacity(0.03),
                borderColor: AppColor.appGreenColor,
                isEnabled: true,
                focusBorderColor: AppColor.appGreenColor,
                borderRadius: 16,
                hint: "Enter description",
                hintColor: const Color(0xff555555),
                validator: _validateDescription,
              ),
              const SizedBox(height: 20),

              // Discount Type Dropdown
              DropdownButtonFormField<String>(
                value: discountController.text.isEmpty
                    ? null
                    : discountController.text,
                onChanged: (String? newValue) {
                  setState(() {
                    discountController.text = newValue!;
                  });
                },
                validator: _validateDiscountType,
                decoration: InputDecoration(
                  labelText: "Discount Type",
                  labelStyle: const TextStyle(color: Color(0xff555555)),
                  filled: true,
                  fillColor: colorSchemeLight.primary.withOpacity(0.03),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: AppColor.appGreenColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: AppColor.appGreenColor),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: AppColor.red),
                  ),
                ),
                items: <String>['Percentage', 'Fixed Amount', 'Buy One Get One']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),

              CustomTextFormField(
                borderRadius: 16,
                fillColor: colorSchemeLight.primary.withOpacity(0.03),
                autoValidateMode: AutovalidateMode.onUserInteraction,
                borderColor: AppColor.appGreenColor,
                keyboardType: TextInputType.number,
                isEnabled: true,
                focusBorderColor: AppColor.appGreenColor,
                controller: couponAmountController,
                hint: "Enter Coupon Amount",
                hintColor: const Color(0xff555555),
                validator: _validateCouponAmount,
              ),
              const SizedBox(height: 20),

              Row(
                children: [
                  Expanded(
                    child: CustomTextFormField(
                      controller: startLateController,
                      borderRadius: 16,
                      fillColor: colorSchemeLight.primary.withOpacity(0.03),
                      borderColor: AppColor.appGreenColor,
                      isEnabled: true,
                      focusBorderColor: AppColor.appGreenColor,
                      hint: "Start Date",
                      hintColor: const Color(0xff555555),
                      validator: _validateDate,
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.calendar_today),
                        onPressed: () => _selectDate(startLateController),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: CustomTextFormField(
                      controller: endLateController,
                      borderRadius: 16,
                      fillColor: colorSchemeLight.primary.withOpacity(0.03),
                      borderColor: AppColor.appGreenColor,
                      isEnabled: true,
                      focusBorderColor: AppColor.appGreenColor,
                      hint: "End Date",
                      hintColor: const Color(0xff555555),
                      validator: _validateDate, // Apply the date validator
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.calendar_today),
                        onPressed: () => _selectDate(endLateController),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),

              // Save Button
              CustomButton(
                color: AppColor.appGreenColor,
                label: 'Save',
                onPressed: _submitForm, // Call _submitForm on press
                borderRadius: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
