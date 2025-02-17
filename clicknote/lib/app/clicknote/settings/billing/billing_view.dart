import 'package:clicknote/app/clicknote/settings/billing/billing_account_plan.dart';
import 'package:clicknote/app/clicknote/settings/translations_settings.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sprung/sprung.dart';


class BillingView extends StatefulWidget {
  const BillingView({super.key});

  @override
  State<BillingView> createState() => _BillingViewState();

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent, // Permite que los bordes sean visibles
      builder: (context) => const BillingView(),
    );
  }
}

class _BillingViewState extends State<BillingView> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return AnimatedPadding(
      duration: const Duration(milliseconds: 300), // Animación de entrada
      curve: Sprung.overDamped, // Curva de animación
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.08,
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(20), // Bordes redondeados superiores
        ),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.9, // 90% de la pantalla
          child: GestureDetector(
            onTap: (){
              FocusScope.of(context).unfocus();
            },
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                toolbarHeight: size.height * 0.08,
                leading: Padding(
                  padding: EdgeInsets.only(left: size.width * 0.04), // Margen horizontal
                  child: IconButton(
                    icon: Icon(Icons.arrow_back_ios, size: size.height * 0.035,color: Theme.of(context).textTheme.bodyLarge?.color?.withAlpha(180),),
                    onPressed: () {Navigator.of(context).pop();},
                  ),
                ),
                title: Text(
                  TranslationsSettings.translate(context, 'billing'),
                  style: GoogleFonts.getFont(
                      "Poppins",
                      color: Theme.of(context).textTheme.bodyLarge?.color?.withAlpha(180),
                      fontSize: size.height * 0.023,
                      fontWeight: FontWeight.w500,
                    ),
                ),
                automaticallyImplyLeading: false,
              ),
              body: const Center(
                child: Column(
                  children: [
                    BillingAccountPlan()
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}