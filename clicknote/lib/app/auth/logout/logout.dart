import 'package:clicknote/app/auth/logout/translations_logout.dart';
import 'package:clicknote/app/clicknote/class/main_user.dart';
import 'package:clicknote/app/elements/custom_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Logout {
  final SupabaseClient _supabaseClient = Supabase.instance.client;

  // Método para cerrar sesión
  Future<void> signOut(BuildContext context) async {
    try {

      // Limpia los datos de MainUser
      final mainUser = Provider.of<MainUser>(context, listen: false);
      mainUser.resetUserData();

      await _supabaseClient.auth.signOut();
      // Navega a la pantalla de inicio de sesión después de cerrar sesión
      CustomSnackBar.show(
        // ignore: use_build_context_synchronously
        context: context,
        // ignore: use_build_context_synchronously
        message: TranslationsLogout.translate(context, 'logout_success'),
        isSuccess: true,
      );
      // ignore: use_build_context_synchronously
      Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);

    } catch (error) {
      debugPrint("Error signing out: $error");
      // Opcional: Muestra un mensaje de error
      CustomSnackBar.show(
        // ignore: use_build_context_synchronously
        context: context,
        // ignore: use_build_context_synchronously
        message: TranslationsLogout.translate(context, 'logout_error'),
        isSuccess: false,
      );
    }
  }
}
