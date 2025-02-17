// ignore: file_names
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ButtonWImage extends StatelessWidget {
  final String text;
  final String imagePath; // Ruta de la imagen
  final double width;
  final Color? color; // Color opcional para el fondo
  final Color? borderColor; // Color opcional para el borde
  final Color? imageColor; // Color opcional para la imagen
  final Color? fontColor;
  final VoidCallback onPressed;

  const ButtonWImage({
    super.key,
    required this.text,
    required this.imagePath,
    required this.width,
    this.color, // Puede ser nulo
    this.borderColor, // Puede ser nulo
    this.imageColor, // Puede ser nulo
    this.fontColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
      child: SizedBox(
        width: width, // Ancho personalizado
        child: ElevatedButton(
          onPressed: onPressed, // Acción personalizada
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            backgroundColor: color ?? Theme.of(context).scaffoldBackgroundColor, // Color temático si es nulo
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(size.height * 0.015),
              side: borderColor != null
                  ? BorderSide(color: borderColor!, width: 2.0) // Borde si se proporciona
                  : BorderSide.none, // Sin borde si es nulo
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                imagePath, // Imagen a la izquierda
                height: size.height * 0.03,
                width: size.height * 0.03,
                color: imageColor, // Aplica el color si no es nulo
              ),
              const SizedBox(width: 12), // Espaciado entre la imagen y el texto
              Text(
                text,
                style: GoogleFonts.getFont(
                  "Poppins", 
                  fontSize: size.height * 0.02,
                  color: fontColor,
                  fontWeight: FontWeight.w500,)
              ),
            ],
          ),
        ),
      ),
    );
  }
}
