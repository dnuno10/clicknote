import 'package:clicknote/app/clicknote/class/main_user.dart';
import 'package:clicknote/app/clicknote/settings/translations_settings.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class SettingEmail extends StatelessWidget {
  const SettingEmail({super.key});

  @override
  Widget build(BuildContext context) {
    final mainUser = Provider.of<MainUser>(context);
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.9,
      decoration: BoxDecoration(
        border: Border.all(color: (Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black).withAlpha(50),),
        borderRadius: BorderRadius.circular(size.height * 0.02)
      ),
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(size.height * 0.01),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            Text(
              mainUser.email.length > 25 ? '${mainUser.email.substring(0, 25)}...' : mainUser.email,
                style: GoogleFonts.getFont(
                  "IBM Plex Mono",
                  fontSize: size.height * 0.018,
                  fontWeight: FontWeight.w600,
                ),
              ),
              plan(false, context)

          ],)
        ),
      ),
    );
  }

  Widget plan(bool plan, BuildContext context) {
  Size size = MediaQuery.of(context).size;
  return Shimmer.fromColors(
    highlightColor: !plan
      ? Theme.of(context).elevatedButtonTheme.style?.foregroundColor?.resolve({}) ?? const Color(0xfffd80ff)
      : const Color(0xfffd80ff),
  baseColor: !plan
      ? Theme.of(context).elevatedButtonTheme.style?.foregroundColor?.resolve({})?.withAlpha(120) ?? const Color(0xFFaa3bff)
      : const Color(0xFFaa3bff),
      period: const Duration(seconds: 4),
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0), // Añade un padding para dar espacio alrededor del texto
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size.height * 0.01), // Opcional: bordes redondeados
      ),
      child: Center(
        child: Text(
          !plan ? TranslationsSettings.translate(context, 'free') : TranslationsSettings.translate(context, 'pro'),
          style: GoogleFonts.getFont("Poppins", fontSize: size.height * 0.017, color: Colors.white, fontWeight: FontWeight.bold), // Tamaño de fuente fijo o dinámico
        ),
      ),
    ),
  );
 }
}