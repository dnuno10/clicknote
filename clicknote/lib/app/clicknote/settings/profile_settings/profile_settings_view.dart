import 'package:clicknote/app/clicknote/settings/profile_settings/profile_settings_body.dart';
import 'package:clicknote/app/clicknote/settings/translations_settings.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sprung/sprung.dart';


class ProfileSettingsView extends StatefulWidget {
  // ignore: non_constant_identifier_names
  final TextEditingController controller_name;
  // ignore: non_constant_identifier_names
  const ProfileSettingsView({super.key, required this.controller_name});

  @override
  State<ProfileSettingsView> createState() => _ProfileSettingsViewState();

  static void show(BuildContext context, TextEditingController controller) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent, // Permite que los bordes sean visibles
      builder: (context) => ProfileSettingsView(controller_name: controller,),
    );
  }
}

class _ProfileSettingsViewState extends State<ProfileSettingsView> {


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
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                toolbarHeight: size.height * 0.08,
                leading: Padding(
                  padding: EdgeInsets.only(left: size.width * 0.04), // Margen horizontal
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios,
                      size: size.height * 0.035,
                      color: Theme.of(context).textTheme.bodyLarge?.color?.withAlpha(180),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                title: Text(
                  TranslationsSettings.translate(context, 'profile_settings'),
                  style: GoogleFonts.getFont(
                    "Poppins",
                    color: Theme.of(context).textTheme.bodyLarge?.color?.withAlpha(180),
                    fontSize: size.height * 0.023,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                automaticallyImplyLeading: false,
              ),
              body: const SingleChildScrollView(
                child: ProfileSettingsBody()
              ),
            ),
          ),
        ),
      ),
    );
  }
}
