import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Button extends StatelessWidget {
  final String text;
  final double width;
  final Color? color; // Background color
  final Color? fontColor;
  final Color? borderColor; // Border color
  final VoidCallback onPressed;

  const Button({
    super.key,
    required this.text,
    required this.width,
    this.fontColor,
    this.color, // Optional background color
    this.borderColor, // Optional border color
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Center(
      child: SizedBox(
        width: width,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: color ?? Theme.of(context).elevatedButtonTheme.style?.backgroundColor?.resolve({}),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(size.height * 0.015),
              side: borderColor != null
                  ? BorderSide(color: borderColor!, width: 1.0)
                  : BorderSide.none,
            ),
          ),
          child: Text(
            text,
            style: GoogleFonts.getFont(
              "Poppins",
              fontSize: size.height * 0.02,
              fontWeight: FontWeight.w500,
              color: fontColor,
            ),
          ),
        ),
      ),
    );
  }
}
