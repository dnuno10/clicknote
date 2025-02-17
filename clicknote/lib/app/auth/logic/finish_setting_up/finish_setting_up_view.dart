import 'package:clicknote/app/auth/logic/finish_setting_up/finish_setting_up_elements/finish_setting_up_message.dart';
import 'package:flutter/material.dart';

class FinishSettingUpView extends StatefulWidget {
  const FinishSettingUpView({super.key});

  @override
  State<FinishSettingUpView> createState() => _FinishSettingUpViewState();
}

class _FinishSettingUpViewState extends State<FinishSettingUpView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  FinishSettingUpMessage()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}