import 'package:flutter/material.dart';
import 'package:wp_integration/routes/app_routes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE0E0E0),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            routeButton(context, AppRoutes.gridScreen, "Todos los posts"),
            routeButton(
              context,
              AppRoutes.dividedScreen,
              "Noticias e Información",
            ),
          ],
        ),
      ),
    );
  }

  Padding routeButton(BuildContext context, String route, String title) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, route);
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.teal,
            boxShadow: [
              BoxShadow(color: Colors.white30, spreadRadius: 2, blurRadius: 7),
            ],
          ),
          padding: EdgeInsets.all(10),
          child: Text(
            title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
