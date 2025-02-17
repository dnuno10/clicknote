import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:clicknote/app/clicknote/settings/translations_settings.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingSwitch extends StatefulWidget {
  const SettingSwitch({super.key});

  @override
  State<SettingSwitch> createState() => _SettingSwitchState();
}

class _SettingSwitchState extends State<SettingSwitch> {
  late bool isDarkMode;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Inicializa el estado en didChangeDependencies en lugar de initState
    isDarkMode = AdaptiveTheme.of(context).mode == AdaptiveThemeMode.dark;
  }

  void _toggleTheme(bool value) {
    setState(() {
      isDarkMode = value;
      if (isDarkMode) {
        AdaptiveTheme.of(context).setDark();
      } else {
        AdaptiveTheme.of(context).setLight();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.06),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  isDarkMode ? Icons.dark_mode : Icons.light_mode,
                  size: size.height * 0.03,
                  color: Theme.of(context).textTheme.bodyLarge?.color?.withAlpha(180),
                ),
                SizedBox(width: size.width * 0.03),
                Text(
                  isDarkMode ? TranslationsSettings.translate(context, 'dark') : TranslationsSettings.translate(context, 'light'),
                  style: GoogleFonts.getFont(
                    "Poppins",
                    color: Theme.of(context).textTheme.bodyLarge?.color?.withAlpha(180),
                    fontSize: size.height * 0.02,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            Switch(
              value: isDarkMode,
              onChanged: _toggleTheme,
              activeColor: const Color(0xFFaa3bff),
              inactiveThumbColor: Colors.grey,
              // ignore: deprecated_member_use
              inactiveTrackColor: Colors.grey.withOpacity(0.5),
            ),
          ],
        )
    );
  }
}
