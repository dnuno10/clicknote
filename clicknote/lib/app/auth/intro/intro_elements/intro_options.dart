import 'package:clicknote/app/auth/intro/translations_intro.dart';
import 'package:clicknote/app/auth/logic/logic_google_signIn.dart';
import 'package:clicknote/app/elements/button.dart';
import 'package:clicknote/app/elements/button_w_image.dart';
import 'package:flutter/material.dart';

class IntroOptions extends StatelessWidget {
  const IntroOptions({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.3,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withAlpha(120),
        borderRadius: BorderRadius.only(topLeft: Radius.circular(size.height * 0.04), topRight: Radius.circular(size.height * 0.04))
      ),

      width: size.width,
      child: Column(children: [
        SizedBox(height: size.height * 0.02),
        ButtonWImage(text: TranslationsIntro.translate(context, 'intro_option_google'), imagePath: 'images/google.png', width: size.width * 0.9, onPressed: () {
          LogicGoogleSignIn().signInWithGoogle(context);
        }),
        SizedBox(height: size.height * 0.015),
        Button(
          text: TranslationsIntro.translate(context, 'subscribe_with_mail'),
          color: Theme.of(context).scaffoldBackgroundColor,
          width: size.width * 0.9,
          onPressed: () {
            Navigator.pushNamed(context, '/signup');
          },
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: size.height * 0.015),
          child: Container(width: size.width * 0.8, height: 1, decoration: BoxDecoration(color: Theme.of(context).scaffoldBackgroundColor),),
        ),
        Button(
          text: TranslationsIntro.translate(context, 'login'),
          color: Theme.of(context).elevatedButtonTheme.style?.foregroundColor?.resolve({}),
          width: size.width * 0.9,
          onPressed: () {
            Navigator.pushNamed(context, '/login');
          },
          fontColor: Theme.of(context).scaffoldBackgroundColor,
        ),
      ],),
    );

    
  }
}