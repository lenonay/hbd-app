import 'package:flutter/material.dart';
import 'package:hbd_app/screens/auth/disconnected_screen.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class AuthWrapper extends StatelessWidget {
  final Future<bool> authFuture;
  final Widget Function(BuildContext) authBuilder;
  final Widget Function(BuildContext) unAuthBuilder;

  const AuthWrapper({
    super.key,
    required this.authFuture,
    required this.authBuilder,
    required this.unAuthBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: InternetConnection().hasInternetAccess,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        }

        // Si no hay conexión
        if (snapshot.data! == false) {
          return DisconnectedScreen();
        }

        return Wrapper(
          authFuture: authFuture,
          unAuthBuilder: unAuthBuilder,
          authBuilder: authBuilder,
        );
      },
    );
  }
}

class Wrapper extends StatelessWidget {
  const Wrapper({
    super.key,
    required this.authFuture,
    required this.unAuthBuilder,
    required this.authBuilder,
  });

  final Future<bool> authFuture;
  final Widget Function(BuildContext p1) unAuthBuilder;
  final Widget Function(BuildContext p1) authBuilder;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: authFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        }

        if (snapshot.hasError || !snapshot.hasData || snapshot.data == false) {
          return unAuthBuilder(context);
        }

        if (snapshot.data == true) {
          return authBuilder(context);
        }

        return unAuthBuilder(context);
      },
    );
  }
}
