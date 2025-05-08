// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:hbd_app/core/storage/persistend_storage.dart';
import 'package:hbd_app/data/env.dart';
import 'package:hbd_app/data/user_repository.dart';
import 'package:hbd_app/models/user.dart';
import '../../routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  final UserRepository userRepository = UserRepository();

  void _login(BuildContext context) async {
    // Hacemos la petición para iniciar sesión
    final response = await userRepository.login(
      _userController.text,
      _passController.text,
      Env.version
    );

    if (!mounted) return;

    if (response["success"] == false) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            response['error'],
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
      );

      return;
    }

    // Extraemos la información del usuario
    final userData = User.fromJson(response["data"]);
    // La guardamos de forma persistente
    await PersistentStorage.saveUserData(userData);

    Navigator.pushReplacementNamed(context, Routes.home);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _userController,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (v) => v!.isEmpty ? 'Introduce un email' : null,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _passController,
                decoration: InputDecoration(labelText: 'Contraseña'),
                obscureText: true,
                validator:
                    (v) => v!.isEmpty ? 'Introduce una contraseña' : null,
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _login(context);
                  }
                },
                child: Text('Iniciar Sesión', style: TextStyle(fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
