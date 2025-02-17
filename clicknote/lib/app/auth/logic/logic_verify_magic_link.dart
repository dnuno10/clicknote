import 'dart:async';

import 'package:clicknote/app/auth/logic/translations_logic.dart';
import 'package:clicknote/app/clicknote/class/main_user.dart';
import 'package:clicknote/app/elements/custom_snack_bar.dart';
import 'package:clicknote/app/loading_screen/loading_screen.dart';
import 'package:clicknote/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LogicVerifyMagicLink extends StatefulWidget {
  final String email;
  final String code;
  const LogicVerifyMagicLink({super.key, required this.email, required this.code});

  @override
  State<LogicVerifyMagicLink> createState() => _LogicVerifyMagicLinkState();
}

class _LogicVerifyMagicLinkState extends State<LogicVerifyMagicLink> {

  /// Envía el código a Supabase para verificar
  Future<void> _verifyCode() async {

  // Verifica si el código es válido
  if (widget.code.isEmpty || widget.code.length != 6) {
    if (mounted) {
      CustomSnackBar.show(
        context: context,
        message: TranslationsLogic.translate(context, 'logic_enter_code'),
        isSuccess: false,
      );
      Navigator.pop(context);
    }
    return;
  }

  try {

    // Verifica el OTP con Supabase
    final response = await supabase.auth.verifyOTP(
      type: OtpType.email,
      token: widget.code,
      email: widget.email,
    );

    if (response.session == null) {
      throw Exception('No session returned');
    }

    // ignore: avoid_print
    print("OTP verification successful");

    //si login es true entonces popular la clase usuario con los datos personales de acceso
    // ignore: use_build_context_synchronously
    final mainUser = Provider.of<MainUser>(context, listen: false);
    mainUser.updateEmail(response.user!.email.toString());
    mainUser.updateID(response.user!.id.toString());
    // Verifica si el usuario ya existe en la tabla "profile"
    final userExist = await supabase
        .from('profile')
        .select('*')
        .eq('email', widget.email)
        .maybeSingle();

    // Si no existe, redirige a la vista de configuración
    if (userExist == null) {
      // ignore: avoid_print
      print('User does not exist in profile table');
      if (mounted) {
        CustomSnackBar.show(
          context: context,
          message: TranslationsLogic.translate(context, 'logic_verified_successfully'),
          isSuccess: true,
        );
        Navigator.pushReplacementNamed(context, '/finish_setting_up');
      }
    } else {
      // Si existe, redirige al menú principal
      mainUser.updateID(userExist['name']);
      // ignore: avoid_print
      print('User exists in profile table');
      if (mounted) {
        CustomSnackBar.show(
          context: context,
          message: TranslationsLogic.translate(context, 'logic_verified_successfully'),
          isSuccess: true,
        );
        Navigator.pushReplacementNamed(context, '/clicknote');
      }
    }
  } catch (e) {
    // Manejo de errores
    // ignore: avoid_print
    print('Error: $e');
    if (mounted) {
      CustomSnackBar.show(
        context: context,
        message: TranslationsLogic.translate(context, 'logic_invalid_code'),
        isSuccess: false,
      );
      Navigator.pop(context);
    }
  }
}


  @override
  void initState() {
    _verifyCode();
    super.initState();
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoadingScreen(
        text: TranslationsLogic.translate(context, 'logic_verifying_code'),
      ),
    );
  }
}