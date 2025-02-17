import 'package:clicknote/app/auth/logic/translations_logic.dart';
import 'package:clicknote/app/clicknote/class/main_user.dart';
import 'package:clicknote/app/elements/custom_snack_bar.dart';
import 'package:clicknote/app/loading_screen/loading_screen.dart';
import 'package:clicknote/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LogicLoginMain extends StatefulWidget {
  const LogicLoginMain({super.key});

  @override
  State<LogicLoginMain> createState() => _LogicLoginMainState();
}

class _LogicLoginMainState extends State<LogicLoginMain> {

  Future<void> _checkLoginStatus() async {
    final session = supabase.auth.currentSession;

    final mainUser = Provider.of<MainUser>(context, listen: false);
    mainUser.updateEmail(session!.user.email.toString());
    mainUser.updateID(session.user.id.toString());
    final userExist = await supabase
        .from('profile')
        .select('*')
        .eq('email', session.user.email.toString())
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
      mainUser.updateName(userExist['name']);
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
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkLoginStatus();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoadingScreen(
        text: TranslationsLogic.translate(context, 'logic_login_waiting'),
      ),
    );
  }
}