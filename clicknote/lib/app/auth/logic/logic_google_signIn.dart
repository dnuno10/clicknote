// ignore_for_file: file_names
import 'package:clicknote/app/auth/logic/translations_logic.dart';
import 'package:clicknote/app/clicknote/class/main_user.dart';
import 'package:clicknote/app/elements/custom_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LogicGoogleSignIn {
  static final LogicGoogleSignIn _instance = LogicGoogleSignIn._internal();

  // Cliente de Supabase
  final SupabaseClient _supabase = Supabase.instance.client;

  // Constructor privado para Singleton
  LogicGoogleSignIn._internal();

  factory LogicGoogleSignIn() => _instance;

  // Método principal para iniciar sesión
  Future<void> signInWithGoogle(BuildContext context) async {
  const webClientId =
      '733878207598-3denpnpnvcpluvcrqs7i0ke5kveg9fk1.apps.googleusercontent.com';
  const iosClientId =
      '733878207598-de09lsosiju0962cs78ausrto1hkg6bq.apps.googleusercontent.com';

  final GoogleSignIn googleSignIn = GoogleSignIn(
    clientId: iosClientId,
    serverClientId: webClientId,
  );

  // Mostrar pantalla de carga
  showDialog(
    context: context,
    barrierDismissible: false, // Impide que se cierre al tocar fuera
    builder: (BuildContext context) {
      return const Center(
        child: CircularProgressIndicator(), // Indicador de carga
      );
    },
  );

  try {
    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) {
      throw 'Sign-in aborted by user.';
    }

    final googleAuth = await googleUser.authentication;
    final accessToken = googleAuth.accessToken;
    final idToken = googleAuth.idToken;

    if (accessToken == null) {
      throw 'No access token found.';
    }
    if (idToken == null) {
      throw 'No ID token found.';
    }

    final response = await _supabase.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken,
      accessToken: accessToken,
    );

    if (response.session == null) {
      throw Exception('No session returned');
    }

    //si login es true entonces popular la clase usuario con los datos personales de acceso
    // ignore: use_build_context_synchronously
    final mainUser = Provider.of<MainUser>(context, listen: false);
    mainUser.updateEmail(response.user!.email.toString());
    mainUser.updateID(response.user!.id.toString());
    final userExist = await _supabase
        .from('profile')
        .select('*')
        .eq('email', response.user!.email.toString())
        .maybeSingle();

    // ignore: use_build_context_synchronously
    Navigator.of(context).pop(); // Cierra la pantalla de carga

    if (userExist == null) {
      // Usuario no existe, redirigir a configuración
      CustomSnackBar.show(
        // ignore: use_build_context_synchronously
        context: context,
        // ignore: use_build_context_synchronously
        message: TranslationsLogic.translate(context, 'logic_verified_successfully'),
        isSuccess: true,
      );
      // ignore: use_build_context_synchronously
      Navigator.pushReplacementNamed(context, '/finish_setting_up');
    } else {
      // Usuario existe, redirigir al menú principal
      mainUser.updateID(userExist['name']);
      CustomSnackBar.show(
        // ignore: use_build_context_synchronously
        context: context,
        // ignore: use_build_context_synchronously
        message: TranslationsLogic.translate(context, 'logic_verified_successfully'),
        isSuccess: true,
      );
      // ignore: use_build_context_synchronously
      Navigator.pushReplacementNamed(context, '/clicknote');
    }
  } catch (e) {
    // ignore: use_build_context_synchronously
    Navigator.of(context).pop(); // Cierra la pantalla de carga en caso de error
    // ignore: avoid_print
    print('error : $e');
    // Manejo de errores
    CustomSnackBar.show(
      // ignore: use_build_context_synchronously
      context: context,
      // ignore: use_build_context_synchronously
      message: TranslationsLogic.translate(context, 'logic_google_error'),
      isSuccess: false,
    );
  }
}
}
