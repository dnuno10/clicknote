import 'package:clicknote/app/auth/logic/finish_setting_up/translations_finish_setting_up.dart';
import 'package:clicknote/app/clicknote/class/main_user.dart';
import 'package:clicknote/app/elements/custom_snack_bar.dart';
import 'package:clicknote/app/loading_screen/loading_screen.dart';
import 'package:clicknote/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class LogicFinishSettingUp extends StatefulWidget {
  // ignore: non_constant_identifier_names
  String id_profile;
  String email;
  String name;
  // ignore: non_constant_identifier_names
  LogicFinishSettingUp({super.key, required this.id_profile, required this.email, required this.name});

  @override
  State<LogicFinishSettingUp> createState() => _LogicFinishSettingUpState();
}

class _LogicFinishSettingUpState extends State<LogicFinishSettingUp> {

  // ignore: non_constant_identifier_names
  Future<void> _setting_up_account() async {
  try {
    // Formato correcto para insertar datos en la tabla 'profile'
    await supabase.from('profile').insert({
      'id_profile': widget.id_profile,
      'email': widget.email,
      'name': widget.name,
    });
    // ignore: unused_local_variable, use_build_context_synchronously
    final mainUser = Provider.of<MainUser>(context, listen: false);
    mainUser.updateName(widget.name);
    // Mostrar mensaje de éxito
    if (mounted) {
      CustomSnackBar.show(
        context: context,
        message: TranslationsFinishSettingUp.translate(context, 'success_setting_up'),
        isSuccess: true,
      );
      Navigator.pushReplacementNamed(context, '/clicknote');
    }
  } catch (e) {
    // Manejo de errores
    // ignore: avoid_print
    print(e);

    if (mounted) {
      CustomSnackBar.show(
        context: context,
        message: TranslationsFinishSettingUp.translate(context, 'error_setting_up'),
        isSuccess: false,
      );
      Navigator.pop(context);
    }
  }
}


  @override
  void initState() {
    _setting_up_account();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoadingScreen(
        text: TranslationsFinishSettingUp.translate(context, 'setting_up'),
      ),
    );
  }
}