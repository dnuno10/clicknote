import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

class IntroHeader extends StatefulWidget {
  const IntroHeader({super.key});

  @override
  State<IntroHeader> createState() => _IntroHeaderState();
}

class _IntroHeaderState extends State<IntroHeader> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    // Detectar el modo actual de AdaptiveTheme
    final isDarkMode = AdaptiveTheme.of(context).mode == AdaptiveThemeMode.dark;

    return SizedBox(
      height: size.height * 0.2,
      child: Center(
        child: Shimmer.fromColors(
          baseColor: const Color(0xfff176ff),
          highlightColor: const Color(0xffae3eff),
          period: const Duration(seconds: 4),
          child: Padding(
            padding: EdgeInsets.only(left: size.width * 0.07, right: size.width * 0.05),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Click Note",
                  style: GoogleFonts.getFont(
                    "IBM Plex Mono",
                    fontSize: size.height * 0.035,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                IconButton(
                  icon: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode, size: size.height * 0.03,),
                  onPressed: () {
                    // Cambia el tema dinámicamente
                    if (isDarkMode) {
                      AdaptiveTheme.of(context).setLight();
                    } else {
                      AdaptiveTheme.of(context).setDark();
                    }
                    setState(() {}); // Reconstruye el widget para actualizar el ícono
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
