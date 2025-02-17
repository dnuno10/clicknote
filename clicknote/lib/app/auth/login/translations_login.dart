import 'package:flutter/material.dart';

class TranslationsLogin {
  static const Map<String, Map<String, String>> _localizedStrings = {
    'en': {
      'login_welcome': 'Welcome',
      'login_email': 'Email',
      'login_password': 'Password',
      'login_continue': 'Continue',
      'login_account_available': 'Don\'t have an account? ',
      'login_signup' : 'Sign Up',
      'login_or' : ' or ',
      'login_option_google': 'Continue with Google',
      'login_option_apple': 'Continue with Apple',
      'login_terms': 'Terms of Use',
      'login_privacy': 'Privacy Policy',
      'login_enter_valid_email' : 'Oops! Please enter a valid email address. No imaginary ones, please!',
      'login_please_create_account' : 'Oops! Looks like you don’t have an account yet. Sign up and let the fun begin!', 
      'login_error' : 'Oops! An unexpected error happened. Even computers have their off days!'
    },
    'es': {
      'login_welcome': 'Bienvenido',
      'login_email': 'Correo electrónico',
      'login_password': 'Contraseña',
      'login_continue': 'Continuar',
      'login_account_available': 'No tienes una cuenta? ',
      'login_signup' : 'Crear Cuenta',
      'login_or' : ' o ',
      'login_option_google': 'Continuar con Google',
      'login_option_apple': 'Continuar con Apple',
      'login_terms': 'Términos de uso',
      'login_privacy': 'Política de privacidad',
      'login_enter_valid_email' : '¡Ups! Por favor, ingresa una dirección de correo electrónico válida. Nada de direcciones inventadas, ¿eh?',
      'login_please_create_account' : '¡Ups! Parece que aún no tienes una cuenta. ¡Regístrate y empieza la aventura!',
      'login_error' : '¡Ups! Algo no salió como esperábamos. ¡Hasta la tecnología tiene sus días malos!'
    },
  };

  static String translate(BuildContext context, String key) {
    final locale = Localizations.localeOf(context);
    return _localizedStrings[locale.languageCode]?[key] ?? key;
  }
}
