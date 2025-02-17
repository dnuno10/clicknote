import 'package:clicknote/app/clicknote/settings/translations_settings.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class SettingLogout extends StatelessWidget {
  VoidCallback onPressed;
  SettingLogout({super.key, required this.onPressed});

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
                Icon(Icons.logout, size: size.height * 0.032, color: const Color.fromARGB(255, 195, 55, 44),),
                SizedBox(width: size.width * 0.03,),
                Text(TranslationsSettings.translate(context, 'log_out'), style: GoogleFonts.getFont(
                        "Poppins",
                        color: const Color.fromARGB(255, 195, 55, 44),
                        fontSize: size.height * 0.019,
                        fontWeight: FontWeight.w500,
                      ),)
              ],),
              Icon(Icons.arrow_forward_ios, size: size.height * 0.025, color: const Color.fromARGB(255, 195, 55, 44),)
            ],
          ),
        ),
      ),
    );
  }
}