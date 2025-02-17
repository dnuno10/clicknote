import "dart:io";

import "package:clicknote/app/auth/logic/logic_apple_signIn.dart";
import "package:clicknote/app/auth/logic/logic_google_signIn.dart";
import "package:clicknote/app/auth/login/translations_login.dart";
import "package:clicknote/app/elements/button_w_image.dart";
import "package:flutter/material.dart";

class LoginOptions extends StatefulWidget {
  const LoginOptions({super.key});

  @override
  State<LoginOptions> createState() => _LoginOptionsState();
}

class _LoginOptionsState extends State<LoginOptions> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(children: [
        SizedBox(height: size.height * 0.02),
        ButtonWImage(text: TranslationsLogin.translate(context, 'login_option_google'), color: Theme.of(context).secondaryHeaderColor,imagePath: 'images/google.png', width: size.width * 0.9, onPressed: (){
          LogicGoogleSignIn().signInWithGoogle(context);
        },),
        SizedBox(height: size.height * 0.015),
        Platform.isIOS ? ButtonWImage(
            text: TranslationsLogin.translate(context, 'login_option_apple'),
            color: Theme.of(context).elevatedButtonTheme.style?.foregroundColor?.resolve({}),
            fontColor: Theme.of(context).scaffoldBackgroundColor,
            imagePath: 'images/apple.png',
            imageColor: Theme.of(context).scaffoldBackgroundColor,
            width: size.width * 0.9,
            onPressed: () {
              LogicAppleSignIn().signInWithApple(context);
            },
          ) : const SizedBox.shrink() // No muestra nada en dispositivos que no sean iOS
      ],);
  }
}