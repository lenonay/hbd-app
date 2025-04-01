import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:wp_integration/routes/app_routes.dart';
import 'package:wp_integration/routes/route_generator.dart';

void main() async {
  // Cargar el dotenv
  await dotenv.load(fileName: ".env");

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: AppRoutes.homeScreen,
      onGenerateRoute: RouteGenerator.generateRoute
    );
  }
}
