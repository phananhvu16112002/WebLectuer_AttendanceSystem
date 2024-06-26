import 'package:flutter/material.dart';
import 'package:weblectuer_attendancesystem_nodejs/common/colors/color.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField(
      {super.key,
      required this.controller,
      required this.textInputType,
      required this.obscureText,
      required this.suffixIcon,
      required this.hintText,
      this.validator,
      this.onSaved,
      this.onChanged,
      required this.prefixIcon,
      required this.readOnly,
      this.width = 0,
      this.height = 0});

  final TextEditingController controller;
  final TextInputType textInputType;
  final bool obscureText;
  final IconButton suffixIcon;
  final String hintText;
  final String? Function(String?)? validator; // Specify the type here
  final Function(String?)? onSaved;
  final ValueChanged<String>? onChanged;
  final Icon prefixIcon;
  final bool readOnly;
  double? width;
  double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: TextFormField(
        readOnly: readOnly,
        controller: controller,
        keyboardType: textInputType,
        style: const TextStyle(
            color: AppColors.primaryText,
            fontWeight: FontWeight.normal,
            fontSize: 15),
        obscureText: obscureText,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(20),
            suffixIcon: suffixIcon,
            labelText: hintText,
            labelStyle: const TextStyle(
                fontSize: 12, color: Color.fromARGB(73, 0, 0, 0)),
            enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(width: 1, color: Colors.transparent)),
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(width: 1, color: AppColors.primaryButton),
            )),
        validator: validator,
        onSaved: onSaved,
        onChanged: onChanged,
      ),
    );
  }
}
