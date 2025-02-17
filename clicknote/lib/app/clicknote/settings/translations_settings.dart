import 'package:flutter/material.dart';

class TranslationsSettings {
  static const Map<String, Map<String, String>> _localizedStrings = {
    'en': {
      'settings' : 'Settings',
      'free': 'Free',
      'pro' : 'Pro',
      'get_click_note_pro' : 'Get Click Note Pro!',
      'click_note_pro_desc' : 'Unlimited generations & notes',
      'upgrade_to_pro' : 'Upgrade to Pro',
      'drop_down_title_english' : 'English',
      'drop_down_title_spanish' : 'Spanish',
      'drop_down_desc_english' : 'Set the app language to English',
      'drop_down_desc_spanish' : 'Set the app language to Spanish',
      'profile' : 'Profile',
      'change_password' : 'Change Password',
      'billing' : 'Billing',
      'log_out' : 'Log out',
      'dark': 'Dark Mode',
      'light': 'Light Mode',
      //Profile
      'profile_settings' : 'Profile Settings',
      'full_name' : 'Full Name',
      'update_profile' : 'Update Profile',
      'account_actions' : 'Account actions',
      'delete_account' : 'Delete Account',
      'updating_name' : 'Updating Name',
      'updating_name_success' : 'Name updated successfully!',
      'updating_name_error' : 'Failed to update the name! ',
      //Billing
      'account_plan' : 'Account Plan'

    },
    'es': {
      'settings' : 'Configuración',
      'free': 'Gratis',
      'pro': 'Pro',
      'get_click_note_pro': '¡Obtén Click Note Pro!',
      'click_note_pro_desc': 'Generaciones y notas ilimitadas',
      'upgrade_to_pro': 'Actualizar a Pro',
      'drop_down_title_english': 'Inglés',
      'drop_down_title_spanish': 'Español',
      'drop_down_desc_english': 'Configurar el idioma de la app a inglés',
      'drop_down_desc_spanish': 'Configurar el idioma de la app a español',
      'profile': 'Perfil',
      'change_password': 'Cambiar Contraseña',
      'billing': 'Facturación',
      'log_out': 'Cerrar sesión',
      'dark': 'Modo Oscuro',
      'light': 'Modo Claro',
      //Profile
      'profile_settings' : 'Configuración de perfil',
      'full_name' : 'Nombre Completo',
      'update_profile' : 'Actualizar Perfil',
      'account_actions' : 'Acciones de cuenta',
      'delete_account' : 'Borrar Cuenta',
      'updating_name' : 'Actualizando Nombre',
      'updating_name_success' : '¡Nombre actualizado con éxito!',
      'updating_name_error' : '¡No se pudo actualizar el nombre!',
      //Billing
      'account_plan' : 'Plan de Cuenta'
    },
  };

  static String translate(BuildContext context, String key) {
    final locale = Localizations.localeOf(context);
    return _localizedStrings[locale.languageCode]?[key] ?? key;
  }
}
