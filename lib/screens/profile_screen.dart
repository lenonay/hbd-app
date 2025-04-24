// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:hbd_app/services/auth_service.dart';
import '../routes.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Perfil de Usuario'),
            ElevatedButton(
              onPressed: () async {
                final logout = await authService.logout();

                if (logout && mounted) {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    Routes.home,
                    (Route<dynamic> route) => false,
                  );
                  return;
                }

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Error al cerrar sesión")),
                );
              },
              child: Text('Cerrar sesión'),
            ),
          ],
        ),
      ),
    );
  }
}
