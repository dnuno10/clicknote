import 'package:flutter/material.dart';

class TranslationsFinishSettingUp {
  static const Map<String, Map<String, String>> _localizedStrings = {
    'en': {
      'finish_setting_up_message_title': "Hi there! I'm Click Note 👋",
      'finish_setting_up_message_desc': 
          "Welcome to the smartest way to take notes! Where your photos become the bridge to your greatest ideas 💡. Bring your ideas to life with just one\nclick 📸  note 📝",
      'finish_setting_up_message_question': "Let’s get to know each other better. What’s your name?",
      'finish_setting_up_message_input_label': "My name is...",
      'continue' : 'Continue',
      'return_home' : 'Return to home',
      'setting_up' : 'Getting Your Account Ready',
      'error_setting_up' : 'Oops! Something went wrong while setting up your account.',
      'success_setting_up' : 'Great! Your account is all set up.',
      'text_field_empty' : 'Hey, don’t be shy! Write something here.',
    },
    'es': {
      'finish_setting_up_message_title': "¡Hola! Soy Click Note 👋",
      'finish_setting_up_message_desc': 
          "¡Bienvenido a la forma más inteligente de tomar notas! Donde tus fotos se convierten en el puente hacia tus ideas más grandes💡. Haz que tus ideas cobren vida con solo un\nclick 📸 note 📝",

      'finish_setting_up_message_question': "Vamos a conocernos mejor. ¿Cuál es tu nombre?",
      'finish_setting_up_message_input_label': "Mi nombre es...",
      'continue' : 'Continuar',
      'return_home' : 'Regresar al inicio',
      'setting_up' : 'Configurando tu cuenta',
      'error_setting_up' : '¡Ups! Algo salió mal al configurar tu cuenta.',
      'success_setting_up' : '¡Todo listo! Tu cuenta está configurada.',
      'text_field_empty' : 'Vamos, no seas tímido. Escribe algo aquí.'
    },
  };

  static String translate(
    BuildContext context,
    String key, {
    Map<String, String>? params,
  }) {
    final locale = Localizations.localeOf(context);
    String? translation = _localizedStrings[locale.languageCode]?[key];

    if (translation != null && params != null) {
      params.forEach((placeholder, value) {
        translation = translation!.replaceAll('{$placeholder}', value);
      });
    }

    return translation ?? key;
  }
}
