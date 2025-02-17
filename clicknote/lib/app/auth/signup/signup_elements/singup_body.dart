import 'package:clicknote/app/auth/signup/translations_singup.dart';
import 'package:clicknote/app/elements/button.dart';
import 'package:clicknote/app/elements/custom_snack_bar.dart';
import 'package:clicknote/app/elements/text_field_email.dart';
import 'package:clicknote/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class SingUpBody extends StatefulWidget {
  const SingUpBody({super.key});

  @override
  State<SingUpBody> createState() => _SingUpBodyState();
}

class _SingUpBodyState extends State<SingUpBody> {
  // Controlador y FocusNode para el campo de texto del correo electrónico
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
    controller_email.dispose();
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
      child: Column(
        children: [
          // Barra superior
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back_ios),
                  iconSize: size.height * 0.035,
                ),
                SvgPicture.asset(
                  'images/clicknote.svg',
                  height: size.height * 0.05,
                ),
                SizedBox(width: size.height * 0.035 + 16),
              ],
            ),
          ),
          SizedBox(height: size.height * 0.07),

          // Título
          Text(
            TranslationsSingUp.translate(context, 'signup_create_account'),
            style: GoogleFonts.getFont(
              "Poppins",
              fontSize: size.height * 0.032,
              fontWeight: FontWeight.w400,
              color: Theme.of(context)
                  .elevatedButtonTheme
                  .style
                  ?.foregroundColor
                  ?.resolve({}),
            ),
          ),

          // Campo de texto para correo electrónico
          Padding(
            padding: EdgeInsets.symmetric(vertical: size.height * 0.030),
            child: TextFieldEmail(
              hintText: TranslationsSingUp.translate(context, 'signup_email'),
              controller: controller_email,
              focusNode: node_email,
            ),
          ),
          // Botón para continuar
          Button(
            text: TranslationsSingUp.translate(context, 'signup_continue'),
            color: const Color(0xFFaa3bff),
            width: size.width * 0.9,
            onPressed: () {
              final email = controller_email.text.trim();

              // Validar correo electrónico antes de continuar
              if (!_isEmailValid(email)) {
                CustomSnackBar.show(
                  context: context,
                  message: TranslationsSingUp.translate(context, 'login_enter_valid_email'),
                  isSuccess: false,
                );
                return;
              }

              //we verify if the email is not taken
              checkAndRegisterEmail();
            },
            fontColor: Colors.white,
          ),

          // Texto para iniciar sesión
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                TranslationsSingUp.translate(context, 'signup_account_available'),
                style: GoogleFonts.getFont(
                  "Poppins",
                  fontSize: size.height * 0.019,
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context)
                      .elevatedButtonTheme
                      .style
                      ?.foregroundColor
                      ?.resolve({}),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/login');
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: size.height * 0.02),
                  child: Text(
                    TranslationsSingUp.translate(context, 'signup_login'),
                    style: GoogleFonts.getFont(
                      "Poppins",
                      fontSize: size.height * 0.019,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFFaa3bff),
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Divider para alternar con otros métodos
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: size.width * 0.41,
                height: 2,
                color: Theme.of(context)
                    .elevatedButtonTheme
                    .style
                    ?.foregroundColor
                    ?.resolve({})
                    ?.withAlpha(30),
              ),
              Text(
                TranslationsSingUp.translate(context, 'signup_or'),
                style: GoogleFonts.getFont(
                  "Poppins",
                  fontSize: size.height * 0.02,
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context)
                      .elevatedButtonTheme
                      .style
                      ?.foregroundColor
                      ?.resolve({})
                      ?.withAlpha(120),
                ),
              ),
              Container(
                width: size.width * 0.41,
                height: 2,
                color: Theme.of(context)
                    .elevatedButtonTheme
                    .style
                    ?.foregroundColor
                    ?.resolve({})
                    ?.withAlpha(30),
              ),
            ],
          ),
        ],
      ),
    );
 
  }


Future<void> checkAndRegisterEmail() async {
  final email = controller_email.text.trim(); // Obtén el email del campo de texto

  try {
    // we verify if the email is registered
    final isRegistered = await supabase.rpc(
      'is_email_registered',
      params: {'input_email': email},
    );

    if (isRegistered == true) {
      // email is already taken, you can't sign up with an existing email
      if (mounted) {
        CustomSnackBar.show(
          context: context,
          message: TranslationsSingUp.translate(context, 'singup_email_registered'),
          isSuccess: false,
        );
      }
    } else {
      // the email is not registered, so you can continue with the register
      if (mounted) {
        Navigator.pushNamed(
          context,
          '/logic_magic_link',
          arguments: {'email': email},
        );
      }
    }
  } catch (e) {
    // unexpected exception
    if (mounted) {
      CustomSnackBar.show(
        context: context,
        message: TranslationsSingUp.translate(context, 'singup_error'),
        isSuccess: false,
      );
    }
    // ignore: avoid_print
    print('Unexpected error: $e'); // Para depuración
  }
}


}
