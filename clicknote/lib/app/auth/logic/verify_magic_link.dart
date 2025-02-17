import 'package:clicknote/app/auth/logic/translations_logic.dart';
import 'package:clicknote/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_pin_code_fields/flutter_pin_code_fields.dart';
import 'package:flutter/services.dart';

class VerifyMagicLink extends StatefulWidget {
  final String email;
  const VerifyMagicLink({super.key, required this.email});

  @override
  State<VerifyMagicLink> createState() => _VerifyMagicLinkState();
}

class _VerifyMagicLinkState extends State<VerifyMagicLink> {

  @override
  void initState() {
    final session = supabase.auth.currentSession;
    // ignore: avoid_print
    print('Sesión: ${session?.user}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.1,
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  /// Título e instrucciones
                  _title(),
                  SizedBox(height: size.height * 0.01),
                  _desc(),
        
                  /// Campo para el código (PinCodeFields)
                  _codeField(size),
        
                  /// Botones extra: abrir correo y reenviar
                  SizedBox(height: size.height * 0.02),
                  _sendMailButton(),
                  _returnHome(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Widgets de UI
  // ---------------------------------------------------------------------------

  Widget _title() {
    final size = MediaQuery.of(context).size;
    return Text(
      TranslationsLogic.translate(context, 'logic_title'),
      style: GoogleFonts.getFont(
        "IBM Plex Mono",
        fontSize: size.height * 0.028,
        fontWeight: FontWeight.w600,
        color: const Color(0xFFaa3bff),
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _desc() {
    final size = MediaQuery.of(context).size;
    final translatedText = TranslationsLogic.translate(
      context,
      'logic_desc',
      params: {'email': widget.email},
    );

    final parts = translatedText.split(widget.email);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: size.height * 0.02),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            TextSpan(
              text: parts.isNotEmpty ? parts[0] : '',
              style: GoogleFonts.getFont(
                "Poppins",
                fontSize: size.height * 0.019,
                fontWeight: FontWeight.w400,
                color: Theme.of(context)
                    .elevatedButtonTheme
                    .style
                    ?.foregroundColor
                    ?.resolve({})
                    ?.withAlpha(180),
              ),
            ),
            TextSpan(
              text: widget.email,
              style: GoogleFonts.getFont(
                "Poppins",
                fontSize: size.height * 0.019,
                fontWeight: FontWeight.w400,
                color: const Color(0xff4285F4),
              ),
            ),
            if (parts.length > 1)
              TextSpan(
                text: parts[1],
                style: GoogleFonts.getFont(
                  "Poppins",
                  fontSize: size.height * 0.019,
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context)
                      .elevatedButtonTheme
                      .style
                      ?.foregroundColor
                      ?.resolve({})
                      ?.withAlpha(180),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _codeField(Size size) {
    return PinCodeFields(
      focusNode: FocusNode(),
      controller: TextEditingController(),
      length: 6,
      obscureText: false,
      animationCurve: Curves.fastOutSlowIn,
      activeBorderColor: const Color(0xFFaa3bff),
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      autoHideKeyboard: false,
      autofocus: true,
      fieldBackgroundColor: Theme.of(context).primaryColor.withAlpha(100),
      // ignore: deprecated_member_use
      activeBackgroundColor: const Color(0xFFaa3bff).withOpacity(0.2),
      fieldBorderStyle: FieldBorderStyle.square,
      borderRadius: BorderRadius.circular(size.width * 0.02),
      textStyle: GoogleFonts.getFont(
        'IBM Plex Mono',
        color: Theme.of(context)
            .elevatedButtonTheme
            .style
            ?.foregroundColor
            ?.resolve({})
            ?.withAlpha(180),
        fontSize: size.height * 0.04,
        fontWeight: FontWeight.w400,
      ),
      onComplete: (String value) {
        Navigator.pushReplacementNamed(
                context,
                '/logic_verify_magic_link',
                arguments: {'email': widget.email, 'code' : value},
              );
      },
    );
  }

  Widget _sendMailButton() {
    final size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          'images/paper-plane.svg',
          height: size.height * 0.028,
          // ignore: deprecated_member_use
          color: const Color(0xFFaa3bff),
        ),
        TextButton(
          onPressed: () {
            Navigator.pushReplacementNamed(
              context,
              '/logic_magic_link',
              arguments: {'email': widget.email},
            );
          },
          child: Text(
            TranslationsLogic.translate(context, 'logic_send_mail'),
            style: GoogleFonts.getFont(
              "Poppins",
              fontSize: size.height * 0.018,
              fontWeight: FontWeight.w500,
              color: const Color(0xFFaa3bff),
            ),
          ),
        ),
      ],
    );
  }

  Widget _returnHome() {
    final size = MediaQuery.of(context).size;
    return TextButton(
      onPressed: () => Navigator.pop(context),
      child: Text(
        TranslationsLogic.translate(context, 'logic_change_email'),
        style: GoogleFonts.getFont(
          "Poppins",
          fontSize: size.height * 0.019,
          fontWeight: FontWeight.w500,
          color: const Color(0xFFaa3bff),
        ),
      ),
    );
  }
}
