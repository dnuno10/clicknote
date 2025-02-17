import 'package:clicknote/app/auth/login/translations_login.dart';
import 'package:clicknote/app/elements/button.dart';
import 'package:clicknote/app/elements/custom_snack_bar.dart';
import 'package:clicknote/app/elements/text_field_email.dart';
import 'package:clicknote/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginBody extends StatefulWidget {
  const LoginBody({super.key});

  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  // ignore: non_constant_identifier_names
  late TextEditingController controller_email;
  // ignore: non_constant_identifier_names
  late FocusNode node_email;

  @override
  void initState() {
    controller_email = TextEditingController();
    node_email = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    controller_email = TextEditingController();
    node_email.dispose();
    super.dispose();
  }

  /// Validar si el correo electrónico tiene un formato válido
  bool _isEmailValid(String email) {
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
    return emailRegex.hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Column(children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(onPressed: (){Navigator.pop(context);}, icon: const Icon(Icons.arrow_back_ios), iconSize: size.height * 0.035,),
              SvgPicture.asset(
                    'images/clicknote.svg',
                    height: size.height * 0.05,
              ),
              SizedBox(width: size.height * 0.035 + 16)
            ],
          ),
        ),
        SizedBox(height: size.height * 0.07), 
        Text(TranslationsLogin.translate(context, 'login_welcome'), style: GoogleFonts.getFont("Poppins", fontSize: size.height * 0.032, fontWeight: FontWeight.w400, color: Theme.of(context).elevatedButtonTheme.style?.foregroundColor?.resolve({}))),
        Padding(
          padding: EdgeInsets.symmetric(vertical: size.height * 0.030),
          child: TextFieldEmail(hintText: TranslationsLogin.translate(context, 'login_email'), controller: controller_email, focusNode: node_email),
        ),
        Button(text: TranslationsLogin.translate(context, 'login_continue'), color: const Color(0xFFaa3bff),width: size.width * 0.9, onPressed: (){
            final email = controller_email.text.trim();

              // Validar correo electrónico antes de continuar
              if (!_isEmailValid(email)) {
                CustomSnackBar.show(
                  context: context,
                  message: TranslationsLogin.translate(context, 'login_enter_valid_email'),
                  isSuccess: false,
                );
                return;
              }
              //we verify if the email is already registered
              checkAndRegisterEmail();

        }, fontColor: Colors.white,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(TranslationsLogin.translate(context, 'login_account_available'), style: GoogleFonts.getFont("Poppins", fontSize: size.height * 0.019, fontWeight: FontWeight.w400, color: Theme.of(context).elevatedButtonTheme.style?.foregroundColor?.resolve({}))),
            GestureDetector(
              onTap: (){
                Navigator.pushReplacementNamed(context, '/signup');
              },
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: size.height * 0.02),
                child: Text(TranslationsLogin.translate(context, 'login_signup'), style: GoogleFonts.getFont("Poppins", fontSize: size.height * 0.019, fontWeight: FontWeight.w400, color: const Color(0xFFaa3bff))),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: size.width * 0.41,
              height: 2,
              color: Theme.of(context).elevatedButtonTheme.style?.foregroundColor?.resolve({})?.withAlpha(30),
            ),
            Text(TranslationsLogin.translate(context, 'login_or'), style: GoogleFonts.getFont("Poppins", fontSize: size.height * 0.02, fontWeight: FontWeight.w400, color: Theme.of(context).elevatedButtonTheme.style?.foregroundColor?.resolve({})?.withAlpha(120))),
            Container(
              width: size.width * 0.41,
              height: 2,
              color: Theme.of(context).elevatedButtonTheme.style?.foregroundColor?.resolve({})?.withAlpha(30),
            ),
          ],
        ),
      ],),
    );
  }

  Future<void> checkAndRegisterEmail() async {
  final email = controller_email.text.trim(); // Obtén el email del campo de texto

  try {
    // we verify if the email is registered
    final isRegistered = await supabase.rpc('is_email_registered', params: {'input_email': email});

    if (isRegistered == true) {
      // email is already registered, so you can continue with log in
      if (mounted) {
        Navigator.pushNamed(
          context,
          '/logic_magic_link',
          arguments: {'email': email},
        );
      }
    } else {
      // the email is not registered, you need to create one first to log in
      if (mounted) {
        CustomSnackBar.show(
          context: context,
          message: TranslationsLogin.translate(context, 'login_please_create_account'),
          isSuccess: false,
        );
      }
    }
  } catch (e) {
    // unexpected exception
    if (mounted) {
      CustomSnackBar.show(
        context: context,
        message: TranslationsLogin.translate(context, 'login_error'),
        isSuccess: false,
      );
    }
    // ignore: avoid_print
    print('Error verificando el email: $e');
  }
}

}