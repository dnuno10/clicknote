import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomSnackBar {
  /// Muestra un SnackBar personalizado en función de los parámetros
  static void show({
    required BuildContext context,
    required String message,
    required bool isSuccess, // Determina el color e ícono
  }) {
    final backgroundColor = isSuccess ? Colors.green : Colors.red;
    final icon = isSuccess ? Icons.check_circle : Icons.error;
    Size size = MediaQuery.of(context).size;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(icon, color: Colors.white, size: size.height * 0.03,),
            SizedBox(width: size.width * 0.01,),
            Expanded(
              child: Text(
                message,
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: size.height * 0.021,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: backgroundColor,
      ),
    );
  }
}
