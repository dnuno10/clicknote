import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoadingScreen extends StatelessWidget {
  final String text;
  const LoadingScreen({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        LoadingAnimationWidget.beat(
          color: Theme.of(context).textTheme.bodyLarge?.color?.withAlpha(120) ?? Colors.grey,
          size: size.height * 0.03,
        ),
        SizedBox(height: size.height * 0.015,),
        Text(text, textAlign: TextAlign.center, style: GoogleFonts.getFont('IBM Plex Mono', fontSize: size.height * 0.023, color: Theme.of(context).textTheme.bodyLarge?.color?.withAlpha(120)),)
      ],
    ),);
  }
}