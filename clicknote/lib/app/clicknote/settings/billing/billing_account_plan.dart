import 'package:clicknote/app/clicknote/settings/translations_settings.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BillingAccountPlan extends StatelessWidget {
  const BillingAccountPlan({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.9,
      decoration: BoxDecoration(
        border: Border.all(color: (Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black).withAlpha(50),),
        borderRadius: BorderRadius.circular(size.height * 0.02)
      ),
      child: Padding(
          padding: EdgeInsets.all(size.height * 0.01),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Text(
              TranslationsSettings.translate(context, 'account_plan'),
                style: GoogleFonts.getFont(
                  "IBM Plex Mono",
                  color: Theme.of(context).textTheme.bodyLarge?.color?.withAlpha(120),
                  fontSize: size.height * 0.016,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
              TranslationsSettings.translate(context, 'free'),
                style: GoogleFonts.getFont(
                  "IBM Plex Mono",
                  color: Theme.of(context).textTheme.bodyLarge?.color?.withAlpha(200),
                  fontSize: size.height * 0.019,
                  fontWeight: FontWeight.w600,
                ),
              ),
          ],)
        ),
    );
  }
}