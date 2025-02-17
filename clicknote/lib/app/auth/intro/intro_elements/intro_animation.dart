import 'dart:math';
import 'package:animated_background/animated_background.dart';
import 'package:clicknote/app/auth/intro/translations_intro.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IntroAnimation extends StatefulWidget {
  const IntroAnimation({super.key});

  @override
  State<IntroAnimation> createState() => _IntroAnimationState();
}

/// Mezclamos [TickerProviderStateMixin] para poder usar [AnimatedBackground].
class _IntroAnimationState extends State<IntroAnimation>
    with TickerProviderStateMixin {
  // Controladores de scroll para cada fila
  final ScrollController _scrollController1 = ScrollController();
  final ScrollController _scrollController2 = ScrollController();
  final ScrollController _scrollController3 = ScrollController();

  // Listas barajadas para cada fila
  late List<String> rowPhrases1;
  late List<String> rowPhrases2;
  late List<String> rowPhrases3;

  // Comportamiento para las partículas (puedes personalizarlo)
  late final RandomParticleBehaviour _particleBehaviour;

  @override
  void initState() {
    super.initState();

    // Definimos el comportamiento de partículas
    _particleBehaviour = RandomParticleBehaviour(
      options: const ParticleOptions(
        baseColor: Color(0xfffd80ff),
        spawnMinSpeed: 10.0,
        spawnMaxSpeed: 30.0,
        spawnMinRadius: 1.0,
        spawnMaxRadius: 4.0,
        particleCount: 60,
      ),
    );

    // Iniciamos el "marquee" de cada fila tras el primer build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startMarquee(_scrollController1);
      _startMarquee(_scrollController2);
      _startMarquee(_scrollController3);
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Traducimos y barajamos las frases al iniciar o cuando cambia el idioma
    final translatedPhrases = [
      'organize_your_ideas',
      'take_notes_quickly',
      'capture_key_moments',
      'everything_in_one_place',
      'ai_working_for_you',
      'texts_generated_instantly',
      'digitize_your_knowledge',
      'automatic_summaries',
      'for_important_meetings',
      'for_your_classes_and_projects',
      'learn_faster',
      'simplify_your_life',
      'master_your_notes',
      'unlimited_productivity',
      'transform_your_notes',
      'your_notes_smarter',
      'share_your_notes_in_seconds',
      'reorganize_your_ideas_easily',
      'shorten_study_time',
      'connect_notes_with_ai',
      'never_forget_what_you_learned',
      'save_and_classify_notes',
      'work_from_anywhere',
      'full_control_of_information',
      'simplify_meetings_and_conferences',
      'generate_summaries_instantly',
      'receive_smart_suggestions',
      'maximize_your_time',
      'automate_your_reports',
      'reach_your_goals_faster',
    ].map((key) => TranslationsIntro.translate(context, key)).toList();

    rowPhrases1 = List<String>.from(translatedPhrases)..shuffle(Random());
    rowPhrases2 = List<String>.from(translatedPhrases)..shuffle(Random());
    rowPhrases3 = List<String>.from(translatedPhrases)..shuffle(Random());
  }

  // Función para iniciar el scroll infinito de derecha a izquierda
  Future<void> _startMarquee(ScrollController controller) async {
    while (mounted) {
      try {
        await controller.animateTo(
          controller.position.maxScrollExtent,
          duration: const Duration(seconds: 160), // Velocidad del scrolling
          curve: Curves.linear,
        );
        // Regresar instantáneamente al extremo derecho
        controller.jumpTo(0);
      } catch (_) {
        break; // Si el widget se desmonta, salimos
      }
    }
  }

  @override
  void dispose() {
    _scrollController1.dispose();
    _scrollController2.dispose();
    _scrollController3.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.5,
      child: Stack(
        children: [
          // Fondo animado con partículas
          AnimatedBackground(
            behaviour: _particleBehaviour,
            vsync: this,
            child: Container(),
          ),

          // Contenido principal: las 3 filas de frases
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Fila 1
                SizedBox(
                  height: 50,
                  child: _buildMarqueeRow(_scrollController1, rowPhrases1),
                ),
                const SizedBox(height: 16),
                // Fila 2
                SizedBox(
                  height: 50,
                  child: _buildMarqueeRow(_scrollController2, rowPhrases2),
                ),
                const SizedBox(height: 16),
                // Fila 3
                SizedBox(
                  height: 50,
                  child: _buildMarqueeRow(_scrollController3, rowPhrases3),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Construye cada “marquee row” con un SingleChildScrollView horizontal
  Widget _buildMarqueeRow(
  ScrollController controller,
  List<String> phrases,
) {
  final extendedPhrases = [...phrases, ...phrases, ...phrases];
  final Size size = MediaQuery.of(context).size;

  return IgnorePointer( // <-- 1) Ignoramos los gestos sobre este widget
    ignoring: true,    //     para que no reciba taps, swipes, etc.
    child: SingleChildScrollView(
      controller: controller,
      scrollDirection: Axis.horizontal,
      reverse: true,
      // 2) Quitamos la física de scroll para que no se deslice con gestos
      physics: const NeverScrollableScrollPhysics(),
      child: Row(
        children: extendedPhrases.map((text) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 8),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withAlpha(120),
              borderRadius: BorderRadius.circular(size.height * 0.01),
            ),
            child: Text(
              text,
              style: GoogleFonts.getFont(
                "IBM Plex Mono",
                fontSize: size.height * 0.018,
                fontWeight: FontWeight.w600,
              ),
            ),
          );
        }).toList(),
      ),
    ),
  );
}

}
