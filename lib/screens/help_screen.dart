import 'package:flutter/material.dart';
import 'package:hbd_app/theme.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ayuda")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              "¿Cómo te podemos ayudar?",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: AppColors.neutral900,
              ),
            ),
            const SizedBox(height: 30),

            helpTile(
              icon: Icons.help_outline_outlined,
              text: 'FAQ',
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  decoration: containerDecoration(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("¿Cómo usar la aplicación?", style: labelStyle()),
                      SizedBox(height: 8),
                      Text(
                        "¿Dónde puedo encontrar más ayuda?",
                        style: labelStyle(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),

            helpTile(
              icon: Icons.message_outlined,
              text: 'Contáctanos',
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  decoration: containerDecoration(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Correos electrónicos de contacto:",
                        style: titleStyle(),
                      ),
                      SizedBox(height: 8),
                      Text("sistemas@bahia-duque.com", style: labelStyle()),
                      SizedBox(height: 8),
                      Text("info@bahia-duque.com", style: labelStyle()),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  BoxDecoration containerDecoration() {
    return BoxDecoration(
      color: AppColors.primaryTint20,
      borderRadius: BorderRadius.circular(8),
      boxShadow: [
        BoxShadow(
          offset: Offset(0, 0),
          spreadRadius: 3,
          blurRadius: 7,
          color: AppColors.shadowPrimary,
        ),
      ],
    );
  }

  TextStyle titleStyle() {
    return TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
  }

  TextStyle labelStyle() => TextStyle(fontSize: 18);

  Widget helpTile({
    required IconData icon,
    required String text,
    required List<Widget> children,
  }) {
    return ExpansionTile(
      leading: Icon(icon, size: 30, color: AppColors.neutral900),
      title: Text(
        text,
        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      ),
      childrenPadding: const EdgeInsets.only(bottom: 5),
      backgroundColor: AppColors.primaryTint20,
      collapsedBackgroundColor: AppColors.primaryTint20,
      tilePadding: const EdgeInsets.symmetric(horizontal: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      collapsedShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      children: children,
    );
  }
}
