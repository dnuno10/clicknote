import 'package:clicknote/app/clicknote/settings/settings_modal_view.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

class ClickNoteHeader extends StatelessWidget {
  const ClickNoteHeader({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(child: Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('My Notes', style: GoogleFonts.getFont('IBM Plex Mono', fontSize: size.height * 0.03, color: Theme.of(context).elevatedButtonTheme.style?.foregroundColor?.resolve({})),),
          Row(
            children: [
              Shimmer.fromColors(
                baseColor: const Color(0xFFfc7fff),
                // ignore: deprecated_member_use
                highlightColor: const Color(0xFFaa3bff).withOpacity(0.7),
                period: const Duration(seconds: 2),
                child: Image.asset('images/diamond.png', height: size.height * 0.035, color: Theme.of(context).canvasColor,)),
              IconButton(onPressed: (){SettingsModalView.show(context);}, icon: Icon(Icons.settings, color: Theme.of(context).elevatedButtonTheme.style?.foregroundColor?.resolve({}),), iconSize: size.height * 0.035,),
            ],
          ),
        ],
      ),
    ),);
  }
}