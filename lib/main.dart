import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '/core/network/dio_client.dart';

import 'theme.dart';
import 'routes.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // Cargamos el dotenv
  await dotenv.load(fileName: ".env");

  // Cargamos el cliente dio y lo iniciamos
  final dioClient = DioClient();
  await dioClient.init();

  // Bloquear orientacion
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  // Inicializar cliente Dio con CookieJar y verificar sesión aquí si es necesario
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HBD App',
      theme: appTheme,
      initialRoute: Routes.home,
      routes: Routes.getRoutes(),
    );
  }
}