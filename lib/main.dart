import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:wp_integration/core/network/dio_client.dart';

import 'package:wp_integration/routes/app_routes.dart';
import 'package:wp_integration/routes/route_generator.dart';

void main() async {
  // Cargar el dotenv
  await dotenv.load(fileName: ".env");

  final dioClient = DioClient();
  await dioClient.init();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.homeScreen,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
