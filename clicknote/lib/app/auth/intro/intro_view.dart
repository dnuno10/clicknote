import 'package:clicknote/app/auth/intro/intro_elements/intro_animation.dart';
import 'package:clicknote/app/auth/intro/intro_elements/intro_header.dart';
import 'package:clicknote/app/auth/intro/intro_elements/intro_options.dart';
import 'package:clicknote/providers/locale_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IntroView extends StatefulWidget {
  const IntroView({super.key});

  @override
  State<IntroView> createState() => _IntroViewState();
}

class _IntroViewState extends State<IntroView> {
  @override
  Widget build(BuildContext context) {
    // Mantén el almacenamiento del idioma
    Provider.of<LocaleStorage>(context);
    return const Scaffold(
      // Centramos el contenido y lo llevamos al final
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IntroHeader(),
            // Limitar la altura del ThreeRowsMarquee
            IntroAnimation(),
            // Vista principal (intro options)
            IntroOptions(),
          ],
        ),
      ),
    );
  }
}