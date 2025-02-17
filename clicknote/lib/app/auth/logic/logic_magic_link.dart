import 'dart:async';

import 'package:clicknote/app/auth/logic/translations_logic.dart';
import 'package:clicknote/app/elements/custom_snack_bar.dart';
import 'package:clicknote/app/loading_screen/loading_screen.dart';
import 'package:clicknote/main.dart';
import 'package:flutter/material.dart';

class LogicMagicLink extends StatefulWidget {
  final String email;
  const LogicMagicLink({super.key, required this.email});

  @override
  State<LogicMagicLink> createState() => _LogicMagicLinkState();
}

class _LogicMagicLinkState extends State<LogicMagicLink> {

  Future<void> _sendMagicLink() async {
  try {
    // Enviar el Magic Link al correo electrónico
    await supabase.auth.signInWithOtp(
      email: widget.email.trim(),
    );

    // Verificar si el widget está montado antes de usar el contexto
    if (mounted) {
      CustomSnackBar.show(
        context: context,
        message: TranslationsLogic.translate(context, 'logic_link_sent_success'),
        isSuccess: true,
      );

      Navigator.pushReplacementNamed(
        context,
        '/verify_magic_link',
        arguments: {'email': widget.email},
      );
    }

    return;
  } catch (error) {
    // Verificar si el widget está montado antes de usar el contexto
    if (mounted) {
      CustomSnackBar.show(
        context: context,
        message: TranslationsLogic.translate(context, 'logic_error_sending_link'),
        isSuccess: false,
      );
      Navigator.pop(context);
    }
  }
}

  @override
  void initState() {
    _sendMagicLink();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoadingScreen(
        text: TranslationsLogic.translate(context, 'logic_sending_link'),
      ),
    );
  }
}

