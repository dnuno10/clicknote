import 'package:clicknote/app/auth/login/login_elements/login_body.dart';
import 'package:clicknote/app/auth/login/login_elements/login_footer.dart';
import 'package:clicknote/app/auth/login/login_elements/login_options.dart';
import 'package:clicknote/providers/locale_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LogInView extends StatefulWidget {
  const LogInView({super.key});

  @override
  State<LogInView> createState() => _LogInViewState();
}

class _LogInViewState extends State<LogInView> {
  @override
  Widget build(BuildContext context) {
    // Mantén el almacenamiento del idioma
    Provider.of<LocaleStorage>(context);
    return Scaffold(
      // Centramos el contenido y lo llevamos al final
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
          color: Colors.transparent,
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height, // Aseguramos que la Column ocupe toda la altura de la pantalla
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      LoginBody(),
                      LoginOptions(),
                    ],
                  ),
                  LoginFooter(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
