import 'package:flutter/material.dart';

class TicketClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    const cutRadius = 12.0;
    const indent = 50.0; // distancia desde el borde izquierdo

    // 1) Base: rectángulo completo
    final base = Path()..addRect(Rect.fromLTWH(0, 0, size.width, size.height));

    // 2) Dos muescas semicirculares a la izquierda, desplazadas hacia dentro
    final holes =
        Path()
          ..addOval(
            Rect.fromCircle(
              center: Offset(indent, cutRadius / 4), // arriba, x=indent
              radius: cutRadius,
            ),
          )
          ..addOval(
            Rect.fromCircle(
              center: Offset(indent, size.height - cutRadius / 4), // abajo
              radius: cutRadius,
            ),
          );

    // 3) Resto: base menos muescas
    return Path.combine(PathOperation.difference, base, holes);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
