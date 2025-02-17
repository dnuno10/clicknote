import 'package:flutter/material.dart';

class TranslationsSingUp {
  static const Map<String, Map<String, String>> _localizedStrings = {
    'en': {
      'signup_create_account': 'Create Account',
      'signup_email': 'Email',
      'singup_message' : 'Create your Click Note password to continue',
      'signup_password': 'Password',
      'signup_continue': 'Continue',
      'signup_account_available': 'Already have an account? ',
      'signup_login' : 'Log In',
      'signup_or' : ' or ',
      'signup_option_google': 'Continue with Google',
      'signup_option_apple': 'Continue with Apple',
      'signup_terms': 'Terms of Use',
      'signup_privacy': 'Privacy Policy',
      'signup_enter_valid_email' : 'Oops! Please enter a valid email address. No imaginary ones, please!',
      'singup_email_registered' : 'Looks like someone beat you to this email. How about another?',
      'singup_error' : 'Oops! An unexpected error happened. Even computers have their off days!',
    },
    'es': {
      'signup_create_account': 'Crear Cuenta',
      'signup_email': 'Correo electrónico',
      'singup_message' : 'Crea tu contraseña de Click Note para continuar',
      'signup_password': 'Contraseña',
      'signup_continue': 'Continuar',
      'signup_account_available': '¿Ya tienes una cuenta? ',
      'signup_login' : 'Iniciar Sesión',
      'signup_or' : ' o ',
      'signup_option_google': 'Continuar con Google',
      'signup_option_apple': 'Continuar con Apple',
      'signup_terms': 'Términos de uso',
      'signup_privacy': 'Política de privacidad',
      'signup_enter_valid_email' : '¡Ups! Por favor, ingresa una dirección de correo electrónico válida. Nada de direcciones inventadas, ¿eh?',
      'singup_email_registered' : 'Parece que alguien se te adelantó con este correo. ¿Qué tal otro?',
      'singup_error' : '¡Ups! Algo no salió como esperábamos. ¡Hasta la tecnología tiene sus días malos!'
    },
  };

  static String translate(BuildContext context, String key) {
    final locale = Localizations.localeOf(context);
    return _localizedStrings[locale.languageCode]?[key] ?? key;
  }
}
