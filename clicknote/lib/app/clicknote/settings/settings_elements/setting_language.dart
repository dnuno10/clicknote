import 'package:clicknote/app/clicknote/settings/translations_settings.dart';
import 'package:clicknote/providers/locale_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class CardFlow extends StatelessWidget {
  final List<Map<String, String>> options;
  final String selectedValue;
  final ValueChanged<String?> onSelectedChange;

  const CardFlow({
    super.key,
    required this.options,
    required this.selectedValue,
    required this.onSelectedChange,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        value: selectedValue,
        menuItemStyleData: MenuItemStyleData(height: size.height * 0.06),
        dropdownStyleData: DropdownStyleData(
          padding: EdgeInsets.symmetric(vertical: size.height * 0.02),
          decoration: BoxDecoration(
            color: Theme.of(context).secondaryHeaderColor,
            borderRadius: BorderRadius.circular(size.height * 0.025),
          ),
          offset: const Offset(0, -20),
        ),
        isExpanded: true,
        iconStyleData: const IconStyleData(
          icon: Icon(Icons.keyboard_arrow_down_rounded),
        ),
        items: options.map((option) {
          return DropdownMenuItem<String>(
            value: option['title'],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Image.asset(option['icon']!, height: size.height * 0.025,),
                        SizedBox(width: size.width * 0.02,),
                        Text(
                          option['title']!,
                          style: GoogleFonts.getFont(
                            "Poppins",
                            fontSize: size.height * 0.018,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).elevatedButtonTheme.style?.foregroundColor?.resolve({})?.withAlpha(180),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      option['description']!,
                      style: GoogleFonts.getFont(
                        "Inter",
                        fontSize: size.height * 0.016,
                        fontWeight: FontWeight.w400,
                        // ignore: deprecated_member_use
                        color: Theme.of(context).elevatedButtonTheme.style?.foregroundColor?.resolve({})?.withAlpha(140),
                      ),
                    ),
                  ],
                ),
                if (option['title'] == selectedValue)
                  Icon(
                    Icons.check_circle,
                    color: const Color(0xFFaa3bff),
                    size: size.height * 0.026,
                  ),
              ],
            ),
          );
        }).toList(),
        selectedItemBuilder: (context) {
          return options.map((option) {
            return Row(
              children: [
                Image.asset(option['icon']!, height: size.height * 0.03,),
                SizedBox(width: size.width * 0.02,),
                Text(
                  option['title']!,
                  style: GoogleFonts.getFont(
                    "Poppins",
                    fontSize: size.height * 0.018,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).elevatedButtonTheme.style?.foregroundColor?.resolve({})?.withAlpha(180),
                  ),
                ),
              ],
            );
          }).toList();
        },
        onChanged: onSelectedChange,
      ),
    );
  }
}

class SettingLanguage extends StatelessWidget {
  const SettingLanguage({super.key});

  @override
  Widget build(BuildContext context) {
    // Obtener el idioma actual del LocaleStorage
    final localeStorage = Provider.of<LocaleStorage>(context);
    final currentLanguage = localeStorage.locale.languageCode;

    // Opciones disponibles en inglés y español
    final options = [
      {'title': TranslationsSettings.translate(context, 'drop_down_title_english'), 'description': TranslationsSettings.translate(context, 'drop_down_desc_english'), 'icon' : 'images/united-states.png'},
      {'title': TranslationsSettings.translate(context, 'drop_down_title_spanish'), 'description': TranslationsSettings.translate(context, 'drop_down_desc_spanish'), 'icon' : 'images/spain.png'},
    ];

    // Idioma seleccionado actual
    final selectedValue = currentLanguage == 'en' ? TranslationsSettings.translate(context, 'drop_down_title_english') : TranslationsSettings.translate(context, 'drop_down_title_spanish');
    Size size = MediaQuery.of(context).size;
    return Center(
        child: Container(
          width: size.width * 0.9,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(size.height * 0.025),
            border: Border.all(color: (Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black).withAlpha(50),),
          ),
          child: CardFlow(
            options: options, // Pasa las opciones corregidas
            selectedValue: selectedValue,
            onSelectedChange: (newValue) {
              if (newValue != null) {
                // Cambiar el idioma basado en la selección
                if (newValue == TranslationsSettings.translate(context, 'drop_down_title_english')) {
                  localeStorage.setLocale(const Locale('en'));
                } else if (newValue == TranslationsSettings.translate(context, 'drop_down_title_spanish')) {
                  localeStorage.setLocale(const Locale('es'));
                }
              }
            },
          ),
        ),
      );
  }
}
