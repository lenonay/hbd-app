// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:hbd_app/routes.dart';
import 'package:hbd_app/services/auth_service.dart';
import 'package:hbd_app/theme.dart';

class ChangePasswdScreen extends StatefulWidget {
  const ChangePasswdScreen({super.key});

  @override
  State<ChangePasswdScreen> createState() => _ChangePasswdScreenState();
}

class _ChangePasswdScreenState extends State<ChangePasswdScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _currentPasswdController =
      TextEditingController();
  final TextEditingController _newPasswdController = TextEditingController();
  final TextEditingController _passwdConfirmController =
      TextEditingController();

  // Instanciamos el authservice
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    validateField(String? value) {
      final passwd = value!;
      final RegExp numbers = RegExp('[0-9]');
      final RegExp uppercase = RegExp('[A-Z]');
      final RegExp lowercase = RegExp('[a-z]');

      // Validamos que no esté vacío
      if (passwd.isEmpty) return "Este campo es obligatorio";

      // Validamos que tenga una longitud de 8 minimo
      if (passwd.length < 8) {
        return "Debe tener al menos 8 caracteres";
      }

      // Validamos que contenga números
      if (!numbers.hasMatch(passwd)) {
        return "Debe contener al menos un número";
      }

      // Validamos mayusculas
      if (!uppercase.hasMatch(passwd)) {
        return "Debe contener al menos una mayúscula";
      }

      // Validamos minusculas
      if (!lowercase.hasMatch(passwd)) {
        return "Debe contener al menos una minúscula";
      }

      return null;
    }

    void changePasswd(String currentPasswd, String newPasswd) async {
      // 1. Hacemos la llamada a la API
      final Map<String, dynamic> response = await _authService.changePasswd(
        currentPasswd,
        newPasswd,
      );

      // 2. Si hay un error lo mostramos
      if (response["success"] == false) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: AppColors.alert,
            content: Text(
              response["error"],
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColors.neutral100),
            ),
          ),
        );
        return;
      }

      // 3. Si no lo hay, avisamos de que vamos a cerrar sesión y hubo éxito
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Contraseña cambiada, cerrando sesión...",
            textAlign: TextAlign.center,
          ),duration: Duration(seconds: 3), // ajusta la duración visible del SnackBar
    ),
  );

  // …y espero sin bloquear el hilo
  await Future.delayed(Duration(seconds: 3));

      // 4. Cerramos sesion
      final auth = await _authService.logout();

      if (auth && mounted) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          Routes.home,
          (Route<dynamic> route) =>
              false, // Borra todas las rutas anteriores ya que no se cumple la condicion
        );
        return;
      }

      // 4.1 Si hubo un error salimos
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColors.alert,
          content: Text(
            "Error al cerrar sesión",
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.neutral100),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text("Cambio de contraseña")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    TextFormField(
                      controller: _currentPasswdController,
                      decoration: InputDecoration(
                        labelText: 'Contraseña Actual',
                      ),
                      obscureText: true,
                      validator:
                          (v) =>
                              (v!.isEmpty) ? "Este campo es obligatorio" : null,
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: _newPasswdController,
                      decoration: InputDecoration(
                        labelText: 'Nueva contraseña',
                      ),
                      validator: (value) => validateField(value),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: _passwdConfirmController,
                      decoration: InputDecoration(
                        labelText: 'Confirme la contraseña',
                      ),
                      validator: (v) {
                        if (v!.isEmpty) return "Este campo es obligatorio";

                        // Validamos que coincidan las nuevas contraseñas
                        if (v != _newPasswdController.text) {
                          return "Las contraseñas no coinciden";
                        }

                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          changePasswd(
                            _currentPasswdController.text,
                            _newPasswdController.text,
                          );
                        }
                      },
                      child: Text(
                        "Confirmar",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
