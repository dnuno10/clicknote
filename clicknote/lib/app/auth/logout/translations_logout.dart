import 'package:flutter/material.dart';

class TranslationsLogout {
  static const Map<String, Map<String, String>> _localizedStrings = {
    'en': {
      'logout_success': 'You\'re officially logged out! Don\'t worry, we saved your spot. ',
      'logout_error' : 'Oops! Something went wrong while logging out. Looks like the door got stuck—try again later!',
      'logout_process' : 'Signing out'
    },
    'es': {
      'logout_success': '¡Cerraste sesión con éxito! No te preocupes, guardamos tu lugar.',
      'logout_error' : '¡Ups! Algo salió mal al cerrar sesión. Parece que la puerta se atascó… ¡intenta de nuevo más tarde!',
      'logout_process' : 'Cerrando sesión'
    },
  };

  static String translate(BuildContext context, String key) {
    final locale = Localizations.localeOf(context);
    return _localizedStrings[locale.languageCode]?[key] ?? key;
  }
}
