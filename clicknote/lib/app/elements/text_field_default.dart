import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sprung/sprung.dart';

class TextFieldDefault extends StatefulWidget {
  final String labelText;
  final TextEditingController controller;
  final FocusNode focusNode;

  const TextFieldDefault({
    super.key,
    required this.labelText,
    required this.controller,
    required this.focusNode,
  });

  @override
  // ignore: library_private_types_in_public_api
  _TextFieldDefaultState createState() => _TextFieldDefaultState();
}
  
class _TextFieldDefaultState extends State<TextFieldDefault> {
  late bool hasFocus;

  @override
  void initState() {
    super.initState();
    hasFocus = widget.focusNode.hasFocus;
    widget.focusNode.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    setState(() {
      hasFocus = widget.focusNode.hasFocus;
    });
  }

  @override
  void dispose() {
    widget.focusNode.removeListener(_onFocusChange);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final Color? borderColor = hasFocus ? const Color(0xFFaa3bff) : Theme.of(context).elevatedButtonTheme.style?.foregroundColor?.resolve({})?.withAlpha(30);

    return AnimatedContainer(
        curve: Sprung.overDamped,
        duration: const Duration(milliseconds: 600),
        width: size.width * 0.9,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(size.height * 0.015),
          border: Border.all(color: borderColor!, width: 2.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: size.height * 0.006),
          child: TextFormField(
            controller: widget.controller,
            focusNode: widget.focusNode,
            style: GoogleFonts.getFont(
              "IBM Plex Mono",
              fontWeight: FontWeight.w500,
              fontSize: size.height * 0.02,
            ),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
              border: InputBorder.none,
              labelText: widget.labelText,
              labelStyle: GoogleFonts.getFont(
                "IBM Plex Mono",
                fontWeight: FontWeight.w500,
                fontSize: size.height * 0.02,
              ),
            ),
          ),
        ),
      );
  }
}
