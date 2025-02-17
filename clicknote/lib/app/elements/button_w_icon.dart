// ignore: file_names
import 'package:flutter/material.dart';

class ButtonWIcon extends StatelessWidget {
  final String text;
  final IconData icon; // Ícono para el botón
  final double width;
  final Color? color; // Color opcional para el fondo
  final Color? borderColor; // Color opcional para el borde
  final VoidCallback onPressed;

  const ButtonWIcon({
    super.key,
    required this.text,
    required this.icon,
    required this.width,
    this.color, // Puede ser nulo
    this.borderColor, // Puede ser nulo
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
            backgroundColor: color ?? Theme.of(context).primaryColor, // Color temático si es nulo
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
              Icon(
                icon, // Ícono a la izquierda
                size: size.height * 0.025,
                color: Colors.white,
              ),
              const SizedBox(width: 8), // Espaciado entre ícono y texto
              Text(
                text,
                style: TextStyle(
                  fontSize: size.height * 0.02,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
