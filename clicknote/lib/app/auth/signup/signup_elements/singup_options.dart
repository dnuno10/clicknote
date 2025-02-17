import "package:clicknote/app/auth/logic/logic_apple_signIn.dart";
import "package:clicknote/app/auth/logic/logic_google_signIn.dart";
import "package:clicknote/app/auth/signup/translations_singup.dart";
import "package:clicknote/app/elements/button_w_image.dart";
import "package:flutter/material.dart";
import 'dart:io';
class SingUpOptions extends StatefulWidget {
  const SingUpOptions({super.key});

  @override
  State<SingUpOptions> createState() => _SingUpOptionsState();
}

class _SingUpOptionsState extends State<SingUpOptions> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(children: [
        SizedBox(height: size.height * 0.02),
        ButtonWImage(text: TranslationsSingUp.translate(context, 'signup_option_google'), color: Theme.of(context).secondaryHeaderColor,imagePath: 'images/google.png', width: size.width * 0.9, onPressed: (){
          LogicGoogleSignIn().signInWithGoogle(context);
        },),
        SizedBox(height: size.height * 0.015),

          Platform.isIOS ? ButtonWImage(
            text: TranslationsSingUp.translate(context, 'signup_option_apple'),
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