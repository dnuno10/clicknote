import 'package:clicknote/app/clicknote/class/main_user.dart';
import 'package:clicknote/app/clicknote/settings/translations_settings.dart';
import 'package:clicknote/app/elements/custom_snack_bar.dart';
import 'package:clicknote/app/loading_screen/loading_screen.dart';
import 'package:clicknote/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileSettingsLogic extends StatefulWidget {
  final String name;
  const ProfileSettingsLogic({super.key, required this.name});

  @override
  State<ProfileSettingsLogic> createState() => _ProfileSettingsLogicState();
}

class _ProfileSettingsLogicState extends State<ProfileSettingsLogic> {
  @override
  void initState() {
    _updatingName();
    super.initState();
  }

  Future<void> _updatingName() async {
    try{
      final idProfile = supabase.auth.currentSession?.user.id;
      await supabase.from('profile').update({'name' : widget.name}).eq('id_profile', idProfile.toString());
      // ignore: use_build_context_synchronously
      final mainUser = Provider.of<MainUser>(context, listen: false);
      mainUser.updateName(widget.name);
      CustomSnackBar.show(
        // ignore: use_build_context_synchronously
        context: context,
        // ignore: use_build_context_synchronously
        message: TranslationsSettings.translate(context, 'updating_name_success'),
        isSuccess: true,
      );
    } catch (e){
      // ignore: avoid_print
      print(e);
      CustomSnackBar.show(
        // ignore: use_build_context_synchronously
        context: context,
        // ignore: use_build_context_synchronously
        message: TranslationsSettings.translate(context, 'updating_name_error'),
        isSuccess: false,
      );
    }

    // ignore: use_build_context_synchronously
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoadingScreen(
        text: TranslationsSettings.translate(context, 'updating_name'),
      ),
    );
  }
}