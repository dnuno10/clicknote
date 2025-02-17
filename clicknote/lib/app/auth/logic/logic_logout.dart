import 'package:clicknote/app/auth/logout/logout.dart';
import 'package:clicknote/app/auth/logout/translations_logout.dart';
import 'package:clicknote/app/loading_screen/loading_screen.dart';
import 'package:flutter/material.dart';

class LogicLogout extends StatefulWidget {
  final BuildContext context;
  const LogicLogout({super.key, required this.context});

  @override
  State<LogicLogout> createState() => _LogicLogoutState();
}

class _LogicLogoutState extends State<LogicLogout> {
  final Logout _logout = Logout();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _logout.signOut(widget.context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoadingScreen(
        text: TranslationsLogout.translate(context, 'logout_process'),
      ),
    );
  }
}
