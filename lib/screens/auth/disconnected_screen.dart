import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hbd_app/theme.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class DisconnectedScreen extends StatefulWidget {
  const DisconnectedScreen({super.key});

  @override
  State<DisconnectedScreen> createState() => _DisconnectedScreenState();
}

class _DisconnectedScreenState extends State<DisconnectedScreen> {
  // Opción A: late final + initState
  late final StreamSubscription<InternetStatus> _subscription;

  @override
  void initState() {
    super.initState(); // ¡imprescindible y lo primero!
    _subscription = InternetConnection()
        .onStatusChange
        .listen((InternetStatus status) {
      if (status == InternetStatus.connected && mounted) {
        Navigator.of(context).pushReplacementNamed('/home');
      }
    });
  }

  @override
  void dispose() {
    _subscription.cancel(); // lo cerramos para no filtrar memoria
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.signal_wifi_statusbar_connected_no_internet_4_outlined,
                size: 58,
                color: AppColors.primary,
                shadows: [
                  Shadow(
                    offset: Offset(0, 0),
                    color: Colors.black45,
                    blurRadius: 8,
                  ),
                ],
              ),
              Text(
                "Vaya, parece que no tienes internet.",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                "Revisa tu conexión a internet, y vuélvelo a intentar."
                "Lo sentimos mucho pero esta aplicación necesita acceder a internet para funcionar",
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
