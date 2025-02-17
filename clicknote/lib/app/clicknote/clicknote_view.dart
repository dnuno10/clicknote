import 'package:clicknote/app/clicknote/clicknote_elements/clicknote_body.dart';
import 'package:clicknote/app/clicknote/clicknote_elements/clicknote_header.dart';
import 'package:clicknote/providers/locale_storage.dart';
import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sprung/sprung.dart';

class ClickNoteView extends StatefulWidget {
  const ClickNoteView({super.key});

  @override
  State<ClickNoteView> createState() => _ClickNoteViewState();
}

class _ClickNoteViewState extends State<ClickNoteView> with SingleTickerProviderStateMixin{
  late Animation<double> _animation;
  late AnimationController _animationController;

  @override
  void initState(){
        
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );

    final curvedAnimation = CurvedAnimation(curve: Sprung.overDamped, parent: _animationController);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);
    
    
    super.initState();


  }
  
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // Mantén el almacenamiento del idioma
    Provider.of<LocaleStorage>(context);
    return const Scaffold(
      body: SafeArea(
        child: Column(
            children: [
              ClickNoteHeader(),
              ClickNoteBody(),
            ],
          ),
      ),
    );
  }
}