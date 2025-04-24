import 'package:flutter/material.dart';

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
