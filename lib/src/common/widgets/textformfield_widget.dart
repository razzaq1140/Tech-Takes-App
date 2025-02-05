// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tech_takes_app/src/common/constants/app_colors.dart';
import 'package:tech_takes_app/src/features/user/forgot_password/controller/password_visiblity_controller.dart';
import 'package:tech_takes_app/src/theme/app_color_scheme.dart';

// ignore: must_be_immutable
class LoginTextfield extends StatefulWidget {
  final TextEditingController? controller;
  final String hintText;
  final bool? obscureText;
  final String? hintText1;
  final TextInputType? keyboard1;
  final List<TextInputFormatter>? inputFormatters;
  final FormFieldValidator<String>? validator1;
  String texttype;
  final Widget? sufficon;
  final Widget? preIcon;
  final bool isPassword;
  final double? hintSize;

  void Function(String value)? func;
  LoginTextfield({
    Key? key,
    this.obscureText,
    this.controller,
    required this.hintText,
    this.hintText1,
    this.keyboard1,
    this.inputFormatters,
    this.validator1,
    this.texttype = "",
    this.sufficon,
    this.preIcon,
    this.isPassword = false,
    this.func,
    this.hintSize,
  }) : super(key: key);

  @override
  State<LoginTextfield> createState() => _LoginTextfieldWidgetState();
}

class _LoginTextfieldWidgetState extends State<LoginTextfield> {
  final PasswordVisibilityController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9, // Adjust as needed

      //  height: MediaQuery.of(context).size.height * 0.06,

      child: TextFormField(
        controller: widget.controller,
        inputFormatters: widget.inputFormatters,
        cursorColor: Colors.black,

        // onChanged: (value) => widget.func!(value),
        keyboardType: widget.keyboard1,
        validator: widget.validator1,
        decoration: InputDecoration(
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 2),
          ),
          contentPadding: EdgeInsets.symmetric(
            //vertical: 12, horizontal: 16
            vertical: MediaQuery.of(context).size.height * 0.02,
            horizontal: MediaQuery.of(context).size.width * 0.04,
          ),
          errorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              borderSide: BorderSide(color: AppColor.red)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            borderSide: BorderSide(color: colorSchemeLight.primary, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            borderSide: BorderSide(
                color: colorSchemeLight.primary.withOpacity(0.5), width: 2),
          ),
          filled: true,
          fillColor: colorSchemeLight.primary.withOpacity(0.03),
          hintText: widget.hintText,
          labelText: widget.hintText1,
          hintStyle:
              TextStyle(color: AppColor.grey, fontSize: widget.hintSize ?? 16),
          suffixIcon: widget.sufficon,
          prefixIcon: widget.preIcon,
        ),

        style: const TextStyle(
          color: AppColor.black,
          fontWeight: FontWeight.normal,
          // fontSize: 14
        ),
        autocorrect: false,
        obscureText:
            widget.isPassword ? controller.passwordObsecured.value : false,
        autovalidateMode: AutovalidateMode.onUserInteraction,
      ),
    );
  }
}
