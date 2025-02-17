import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingOption extends StatelessWidget {
  final String text;
  // ignore: non_constant_identifier_names
  final String image_location;
  final VoidCallback onPressed;
  // ignore: non_constant_identifier_names
  const SettingOption({super.key, required this.text, required this.image_location, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.06),
        child: Container(
          color: Colors.transparent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(children: [
                // ignore: deprecated_member_use
                SvgPicture.asset(image_location, height: size.height * 0.032, color: Theme.of(context).textTheme.bodyLarge?.color?.withAlpha(180),),
                SizedBox(width: size.width * 0.03,),
                Text(text, style: GoogleFonts.getFont(
                        "Poppins",
                        color: Theme.of(context).textTheme.bodyLarge?.color?.withAlpha(180),
                        fontSize: size.height * 0.019,
                        fontWeight: FontWeight.w500,
                      ),)
              ],),
              Icon(Icons.arrow_forward_ios, size: size.height * 0.025, color: Theme.of(context).textTheme.bodyLarge?.color?.withAlpha(180),)
            ],
          ),
        ),
      ),
    );
  }
}