import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.buttonName,
    required this.backgroundColorButton,
    required this.borderColor,
    required this.textColor,
    required this.function,
    required this.height,
    required this.width,
    required this.fontSize,
    required this.colorShadow,
    required this.borderRadius,
  });

  final String buttonName;
  final Color backgroundColorButton;
  final Color borderColor;
  final Color textColor;
  final void Function()? function;
  final double height;
  final double? width;
  final double fontSize;
  final Color colorShadow;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      mouseCursor: SystemMouseCursors.click,
      onTap: function,
      child: Container(
        height: height,
        width: width,
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
            color: backgroundColorButton,
            borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
            border: Border.all(width: 1, color: borderColor),
            boxShadow: [
              BoxShadow(
                  color: colorShadow, blurRadius: 4, offset: const Offset(0, 1))
            ]),
        child: Center(
          child: Text(
            buttonName,
            style: GoogleFonts.inter(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: textColor),
          ),
        ),
      ),
    );
  }
}
