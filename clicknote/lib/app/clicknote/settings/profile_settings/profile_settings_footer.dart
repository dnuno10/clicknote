import 'package:clicknote/app/clicknote/settings/translations_settings.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileSettingsFooter extends StatelessWidget {
  final VoidCallback onPressed;
  const ProfileSettingsFooter({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Text(TranslationsSettings.translate(context, 'account_actions'), style: GoogleFonts.getFont(
                      "IBM Plex Mono",
                      color: Theme.of(context).textTheme.bodyLarge?.color?.withAlpha(90),
                      fontSize: size.height * 0.018,
                      fontWeight: FontWeight.w500,
                    ),),
          GestureDetector(
            onTap: () => onPressed,
            child: Container(
              color: Colors.transparent,
              child: Row(
                children: [
                  Icon(Icons.delete, size: size.height * 0.028, color: Theme.of(context).textTheme.bodyLarge?.color?.withAlpha(180),),
                  SizedBox(width: size.width * 0.005,),
                  Text(TranslationsSettings.translate(context, 'delete_account'), style: GoogleFonts.getFont(
                          "Poppins",
                          color: Theme.of(context).textTheme.bodyLarge?.color?.withAlpha(180),
                          fontSize: size.height * 0.02,
                          fontWeight: FontWeight.w500,
                        ),),
                ],
              ),
            ),
          )
        ],),
      ),
    );
  }
}