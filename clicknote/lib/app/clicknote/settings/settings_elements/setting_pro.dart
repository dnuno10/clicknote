import 'package:clicknote/app/clicknote/settings/translations_settings.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingPro extends StatelessWidget {
  const SettingPro({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.9,
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFFaa3bff), Color.fromARGB(255, 202, 22, 205)], begin: Alignment.bottomCenter, end: Alignment.topCenter),
        borderRadius: BorderRadius.circular(size.height * 0.03)
      ),
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(size.height * 0.02),
          child: Column(
            children: [
            Text(
              TranslationsSettings.translate(context, 'get_click_note_pro'),
              textAlign: TextAlign.center,
                style: GoogleFonts.getFont(
                  "Poppins",
                  fontSize: size.height * 0.019,
                  fontWeight: FontWeight.w600,
                  color: Colors.white
                ),
              ),
              Text(
              TranslationsSettings.translate(context, 'click_note_pro_desc'),
              textAlign: TextAlign.center,
                style: GoogleFonts.getFont(
                  "Poppins",
                  fontSize: size.height * 0.018,
                  fontWeight: FontWeight.w500,
                  color: Colors.white
                ),
              ),
              SizedBox(height: size.height * 0.01,),
              update_button(context)
          ],)
        ),
      ),
    );
  }
  // ignore: non_constant_identifier_names
  Widget update_button(BuildContext context){
    Size size = MediaQuery.of(context).size;
    return SizedBox(
        child: ElevatedButton(
          onPressed: (){},
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(79, 135, 13, 137),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(size.height * 0.02),
            ),
          ),
          child: Text(
            TranslationsSettings.translate(context, 'upgrade_to_pro'),
            style: GoogleFonts.getFont(
              "Poppins",
              fontSize: size.height * 0.018,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      );
  }
}