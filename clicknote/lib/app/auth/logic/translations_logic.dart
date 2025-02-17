import 'package:flutter/material.dart';

class TranslationsLogic {
  static const Map<String, Map<String, String>> _localizedStrings = {
    'en': {
      'logic_sending_link': 'Sending Link',
      'logic_title': 'Verify your email',
      'logic_desc': 'We sent an email to {email}. Click the link attached to Sign In.',
      'logic_mail_button': 'Open email app',
      'logic_send_mail': 'Resend email',
      'logic_button_verification': 'Verify my email',
      'logic_change_email' : 'Change email address',
      'logic_link_sent_success' : 'The link was sent successfully. Let’s hope it doesn’t get lost in the void!',
      'logic_link_sent_usuccess' : 'Oops! The email could not be verified.',
      'logic_verified_successfully' : 'Yay! The email has been successfully verified. It’s officially legit!',
      'logic_email_app_error' : 'There was a problem opening the email application.',
      'logic_invalid_code' : 'Oops! The code is not valid. Give it another shot later!',
      'logic_error_sending_link': 'There was an issue sending the link. Please try again later.',
      'logic_verify_button' : 'Verify Code',
      'logic_enter_code' : 'Enter Code',
      'logic_verifying_code' : 'Verifying Code',
      'logic_google_error' : 'Oops! We couldn’t verify your Google account',
      'logic_apple_error' : 'Oops! We were unable to verify your Apple account.',
      'logic_login_waiting': 'Logging in'

    },
    'es': {
      'logic_sending_link': 'Enviando Link',
      'logic_title': 'Verifique su correo electrónico',
      'logic_desc': 'Enviamos un correo electrónico a {email}. Haz clic en el enlace adjunto para Iniciar Sesión.',
      'logic_mail_button': 'Abrir aplicación de correo',
      'logic_send_mail': 'Reenviar correo electrónico',
      'logic_button_verification': 'Verificar mi correo electrónico',
      'logic_change_email' : 'Cambiar correo electrónico',
      'logic_link_sent_success' : 'El enlace se envió con éxito. ¡Esperemos que no se pierda en el limbo!',
      'logic_link_sent_usuccess' : '¡Ups! No se pudo verificar el correo electrónico. ',
      'logic_verified_successfully' : '¡Genial! El correo electrónico ha sido verificado exitosamente. ¡Ya es oficial!',
      'logic_email_app_error' : 'Ocurrió un problema al intentar abrir la aplicación de correo.',
      'logic_invalid_code' : '¡Ups! El código no es válido. Inténtalo de nuevo más tarde.',
      'logic_error_sending_link': '¡Ups! Hubo un problema al enviar el enlace. Inténtalo de nuevo más tarde, ¡esta vez con suerte!"',
      'logic_verify_button' : 'Verificar Código',
      'logic_enter_code' : 'Ingresar Código',
      'logic_verifying_code' : 'Verificando Código',
      'logic_google_error' : '¡Ups! No pudimos verificar tu cuenta de Google.',
      'logic_apple_error' : '¡Ups! No pudimos verificar tu cuenta de Apple.',
      'logic_login_waiting': 'Iniciando sesión',
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
