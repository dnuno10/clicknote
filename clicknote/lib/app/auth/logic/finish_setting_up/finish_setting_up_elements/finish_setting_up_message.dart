import 'package:clicknote/app/auth/logic/finish_setting_up/translations_finish_setting_up.dart';
import 'package:clicknote/app/elements/button.dart';
import 'package:clicknote/app/elements/custom_snack_bar.dart';
import 'package:clicknote/app/elements/text_field_default.dart';
import 'package:clicknote/main.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class FinishSettingUpMessage extends StatefulWidget {
  const FinishSettingUpMessage({super.key});

  @override
  State<FinishSettingUpMessage> createState() => _FinishSettingUpMessageState();
}

class _FinishSettingUpMessageState extends State<FinishSettingUpMessage>
    with SingleTickerProviderStateMixin {
  bool _showDescription = false;
  bool _showInputField = false;
  // ignore: non_constant_identifier_names
  late FocusNode node_name;
  // ignore: non_constant_identifier_names
  late TextEditingController controller_name;
  bool _isTextFieldEmpty = true;

  late final AnimationController _animationController;
  late final Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    node_name = FocusNode();
    controller_name = TextEditingController();
    controller_name.addListener(_onTextChanged);

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    node_name.dispose();
    controller_name.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    setState(() {
      _isTextFieldEmpty = controller_name.text.isEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.1,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Título animado
              DefaultTextStyle(
                style: GoogleFonts.getFont(
                  "IBM Plex Mono",
                  fontSize: size.height * 0.023,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFFaa3bff),
                ),
                child: AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText(
                      TranslationsFinishSettingUp.translate(
                          context, 'finish_setting_up_message_title'),
                      speed: const Duration(milliseconds: 50),
                    ),
                  ],
                  totalRepeatCount: 1,
                  onFinished: () {
                    setState(() => _showDescription = true);
                  },
                ),
              ),
      
              SizedBox(height: size.height * 0.02),
      
              /// Descripción animada
              if (_showDescription)
                DefaultTextStyle(
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
                  child: AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText(
                        TranslationsFinishSettingUp.translate(
                            context, 'finish_setting_up_message_desc'),
                        speed: const Duration(milliseconds: 30),
                      ),
                    ],
                    totalRepeatCount: 1,
                    onFinished: () {
                      setState(() => _showInputField = true);
                      _animationController.forward();
                    },
                  ),
                ),
      
              /// Campo de texto para ingresar el nombre
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                child: _showInputField
                    ? FadeTransition(
                        opacity: _fadeAnimation,
                        child: Padding(
                          padding: EdgeInsets.only(top: size.height * 0.02),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                TranslationsFinishSettingUp.translate(
                                    context, 'finish_setting_up_message_question'),
                                style: GoogleFonts.getFont(
                                  "Poppins",
                                  fontSize: size.height * 0.019,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFFaa3bff),
                                ),
                              ),
                              SizedBox(height: size.height * 0.02),
                              TextFieldDefault(
                                labelText: TranslationsFinishSettingUp.translate(
                                    context, 'finish_setting_up_message_input_label'),
                                controller: controller_name,
                                focusNode: node_name,
                              ),
                              SizedBox(height: size.height * 0.02),
      
                              /// Botón con color dinámico
                              Button(
                                text: TranslationsFinishSettingUp.translate(
                                    context, 'continue'),
                                width: size.width,
                                onPressed: (){
                                  if(_isTextFieldEmpty){
                                    //text_field_empty
                                    CustomSnackBar.show(
                                      context: context,
                                      message: TranslationsFinishSettingUp.translate(context, 'text_field_empty'),
                                      isSuccess: false,
                                    );
                                  } else{
                                  final idProfile = supabase.auth.currentUser?.id;
                                  final email = supabase.auth.currentUser?.email;
                                  
                                  Navigator.pushReplacementNamed(
                                    context,
                                    '/logic_finish_setting_up',
                                    arguments: {'id_profile' : idProfile, 'email': email, 'name' : controller_name.text},
                                  );
                                  }
                                  
                                },
                                //onPressed: _isTextFieldEmpty ? null : () {}, // Asegura compatibilidad con VoidCallback
                                color: _isTextFieldEmpty
                                    // ignore: deprecated_member_use
                                    ? const Color(0xFFaa3bff).withOpacity(0.6)
                                    : const Color(0xFFaa3bff),
                                fontColor: Colors.white,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  _returnHome(),
                                ],
                              )
                            ],
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _returnHome() {
    final size = MediaQuery.of(context).size;
    return TextButton(
      onPressed: () {
        Navigator.pushReplacementNamed(context, '/logic_logout');
      },
      child: Text(
        TranslationsFinishSettingUp.translate(context, 'return_home'),
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
