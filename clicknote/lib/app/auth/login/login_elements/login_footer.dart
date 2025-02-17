import 'package:clicknote/app/auth/login/translations_login.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginFooter extends StatelessWidget {
  const LoginFooter({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(bottom: size.height * 0.05),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Text(TranslationsLogin.translate(context, 'login_terms'), style: GoogleFonts.getFont("Poppins", fontSize: size.height * 0.016, fontWeight: FontWeight.w400, color: const Color(0xFFaa3bff))),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
          child: Container(height: size.height * 0.02, width: 2, color: Theme.of(context).elevatedButtonTheme.style?.foregroundColor?.resolve({})?.withAlpha(70)),
        ),
        Text(TranslationsLogin.translate(context, 'login_privacy'), style: GoogleFonts.getFont("Poppins", fontSize: size.height * 0.016, fontWeight: FontWeight.w400, color: const Color(0xFFaa3bff))),
      ],),
    );
  }
}