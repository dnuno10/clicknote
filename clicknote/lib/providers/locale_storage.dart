import 'package:flutter/material.dart';

class LocaleStorage extends ChangeNotifier {
  Locale _locale = const Locale('en'); // Idioma predeterminado

  Locale get locale => _locale;

  void setLocale(Locale newLocale) {
    _locale = newLocale;
    notifyListeners();
  }

  void initializeLocale(Locale? deviceLocale, List<Locale> supportedLocales) {
    if (deviceLocale != null) {
      for (var locale in supportedLocales) {
        if (locale.languageCode == deviceLocale.languageCode) {
          _locale = locale;
          return;
        }
      }
    }
    _locale = const Locale('en'); // Si no coincide, usa el predeterminado
  }
}
