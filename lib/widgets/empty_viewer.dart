import 'package:flutter/material.dart';
import 'package:hbd_app/theme.dart';

class EmptyViewer extends StatelessWidget {
  final String item;

  const EmptyViewer({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.sentiment_very_dissatisfied,
            color: AppColors.primary,
            size: 96,
          ),
          Text(
            "Vaya, es una pena...",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Text(
            "Aun no tenemos $item por aquí.\nComprueba en otro momento, gracias por tu atención",
            style: TextStyle(fontSize: 20),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
