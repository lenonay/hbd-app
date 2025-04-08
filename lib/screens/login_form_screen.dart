import 'package:flutter/material.dart';
import 'package:wp_integration/core/mixins/auth_mixin.dart';
import 'package:wp_integration/data/user_repository.dart';
import 'package:wp_integration/routes/app_routes.dart';
import 'package:wp_integration/widgets/auth_wrapper.dart';

class LoginFormScreen extends StatefulWidget {
  const LoginFormScreen({super.key});

  @override
  State<LoginFormScreen> createState() => _LoginFormScreenState();
}

class _LoginFormScreenState extends State<LoginFormScreen> with AuthMixin {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwdController = TextEditingController();

  late Future<bool> _authFuture;
  String? errorMessage;

  final UserRepository userRepository = UserRepository();

  @override
  void initState() {
    super.initState();
    _authFuture = checkAuth(); // Revisamos que tenamos el futuro
  }

  void _login() async {
    try {
      // Hacemos la peticion para iniciar sesion con los datos actuales
      final response = await userRepository.login(
        _emailController.text,
        _passwdController.text,
      );

      if (response["success"] == false) {
        setState(() {
          errorMessage = response["error"];
        });

        return;
      }

      // Comprobamos que el widget siga existiendo antes de retornar a la home
      if (!mounted) return;
      Navigator.pushNamed(context, AppRoutes.homeScreen);
    } catch (error) {
      setState(() {
        errorMessage = "Error inesperado: $error";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE0E0E0),
      appBar: AppBar(backgroundColor: Colors.teal),
      body: AuthWrapper(
        authFuture: _authFuture,
        authBuilder: (context) => Text("Hola"),
        unAuthBuilder: (context) => loginForm(context),
      ),
    );
  }

  Padding loginForm(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Form(
        key: _formKey,
        child: Container(
          height: MediaQuery.of(context).size.height / 4,
          decoration: BoxDecoration(
            color: const Color(0xFFBDD0DA),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: "Email",
                    errorText: errorMessage,
                  ),
                  validator: (input) {
                    if (input == null || input.isEmpty) {
                      return "El email es obligatorio";
                    }

                    return null;
                  },
                ),
                TextFormField(
                  controller: _passwdController,
                  decoration: InputDecoration(
                    hintText: "Contraseña",
                    errorText: errorMessage,
                  ),
                  validator: (input) {
                    if (input == null || input.isEmpty) {
                      return "La contraseña es obligatoria";
                    }

                    return null;
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _login();
                    }
                  },
                  child: Text("Enviar"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
