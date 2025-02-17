import 'package:clicknote/app/clicknote/settings/billing/billing_view.dart';
import 'package:clicknote/app/clicknote/settings/profile_settings/profile_settings_view.dart';
import 'package:clicknote/app/clicknote/settings/settings_elements/setting_email.dart';
import 'package:clicknote/app/clicknote/settings/settings_elements/setting_language.dart';
import 'package:clicknote/app/clicknote/settings/settings_elements/setting_logout.dart';
import 'package:clicknote/app/clicknote/settings/settings_elements/setting_option.dart';
import 'package:clicknote/app/clicknote/settings/settings_elements/setting_pro.dart';
import 'package:clicknote/app/clicknote/settings/settings_elements/setting_switch.dart';
import 'package:clicknote/app/clicknote/settings/translations_settings.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sprung/sprung.dart';

class SettingsModalView extends StatelessWidget {
  const SettingsModalView({super.key});

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent, // Permite que los bordes sean visibles
      builder: (context) => const SettingsModalView(),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return AnimatedPadding(
      duration: const Duration(milliseconds: 300), // Animación de entrada
      curve: Sprung.overDamped, // Curva de animación
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.08,
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(20), // Bordes redondeados superiores
        ),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.9, // 90% de la pantalla
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              toolbarHeight: size.height * 0.08,
              leading: Padding(
                padding: EdgeInsets.only(left: size.width * 0.04), // Margen horizontal
                child: IconButton(
                  icon: Icon(Icons.arrow_back_ios, size: size.height * 0.035,color: Theme.of(context).textTheme.bodyLarge?.color?.withAlpha(180),),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
              title: Text(
                TranslationsSettings.translate(context, 'settings'),
                style: GoogleFonts.getFont(
                    "Poppins",
                    color: Theme.of(context).textTheme.bodyLarge?.color?.withAlpha(180),
                    fontSize: size.height * 0.023,
                    fontWeight: FontWeight.w500,
                  ),
              ),
              automaticallyImplyLeading: false,
              actions: [
                Padding(
                  padding: EdgeInsets.only(right: size.width * 0.04),
                  child: IconButton(
                    icon: Icon(Icons.info, size: size.height * 0.035, color: Theme.of(context).textTheme.bodyLarge?.color?.withAlpha(180),),
                    onPressed: () {
                      // Acción del ícono derecho
                    },
                  ),
                ),
              ],
            ),
            body: Center(
              child: Column(
                children: [
                  const SettingEmail(),
                  SizedBox(height: size.height * 0.015,),
                  const SettingPro(),
                  SizedBox(height: size.height * 0.015,),
                  const SettingLanguage(),
                  SizedBox(height: size.height * 0.025,),
                  SettingOption(text: TranslationsSettings.translate(context, 'profile'), image_location: 'images/circle-user.svg', onPressed: ()=> ProfileSettingsView.show(context, TextEditingController())),
                  SizedBox(height: size.height * 0.025,),
                  SettingOption(text: TranslationsSettings.translate(context, 'billing'), image_location: 'images/money-bill-transfer.svg', onPressed: ()=> BillingView.show(context),),
                  SizedBox(height: size.height * 0.025,),
                  const SettingSwitch(),
                  SizedBox(height: size.height * 0.045,),
                  SettingLogout(onPressed: () => Navigator.pushReplacementNamed(context, '/logic_logout'),)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
