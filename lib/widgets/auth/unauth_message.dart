import 'package:flutter/material.dart';
import '/routes.dart';

class UnAuthMessage extends StatelessWidget {
  const UnAuthMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 0),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset("assets/images/bahia-logo.png"),
              ),
            ),
            SizedBox(height: 30),
            Text(
              "Debe iniciar sesión",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            Text(
              "Este contenido está reservado exclusivamente a empleados y empledas del Hotel.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.brown,
                foregroundColor: Colors.black,
                textStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  shadows: 
                [
                  Shadow(
                    color: Colors.white,
                    blurRadius: 8,
                    offset: Offset(0, 0)
                  )
                ]),
              ),
              onPressed: () {
                Navigator.pushReplacementNamed(context, Routes.login);
              },
              child: Text("Iniciar Sesión"),
            ),
          ],
        ),
      ),
    );
  }
}
