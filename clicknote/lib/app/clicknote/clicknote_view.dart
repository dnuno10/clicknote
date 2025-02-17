import 'package:clicknote/app/clicknote/clicknote_elements/clicknote_body.dart';
import 'package:clicknote/app/clicknote/clicknote_elements/clicknote_header.dart';
import 'package:clicknote/providers/locale_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ClickNoteView extends StatefulWidget {
  const ClickNoteView({super.key});

  @override
  State<ClickNoteView> createState() => _ClickNoteViewState();
}

class _ClickNoteViewState extends State<ClickNoteView> with SingleTickerProviderStateMixin{
  @override
  void initState(){
    
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
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