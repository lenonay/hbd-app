import 'package:flutter/material.dart';
import 'package:wp_integration/core/network/dio_client.dart';
import 'package:wp_integration/routes/app_routes.dart';
import 'package:wp_integration/widgets/route_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _handleLogout(BuildContext context) async {
    final dioClient = DioClient();
    final hadAuth = await dioClient.hasTokenCookie();

    try {
      dioClient.logout();

      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            hadAuth
                ? "Sesión cerrada correctamente"
                : "No ha iniciado sesión previamente",
            style: snackBarTextStyle(),
            textAlign: TextAlign.center,
          ),
          backgroundColor: hadAuth ? Colors.lightBlueAccent : Colors.blueGrey,
        ),
      );
    } catch (err) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Error al cerrar sesión ❌",
            style: snackBarTextStyle(),
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  TextStyle snackBarTextStyle() {
    return TextStyle(fontSize: 22, color: Colors.white70);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE0E0E0),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            accountButtons(context),
            SizedBox(height: 30),
            postsButtons(context),
          ],
        ),
      ),
    );
  }

  Column postsButtons(BuildContext context) {
    return Column(
      children: [
        RouteButton(
          context: context,
          route: AppRoutes.gridScreen,
          title: "Todos los posts",
        ),
        RouteButton(
          context: context,
          route: AppRoutes.dividedScreen,
          title: "Noticias e Información",
        ),
      ],
    );
  }

  Row accountButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RouteButton(
          context: context,
          route: AppRoutes.loginFormScreen,
          title: "Iniciar Sesión",
        ),
        RouteButton(
          context: context,
          title: "Cerrar Sesión",
          onTap: () {
            _handleLogout(context);
          },
        ),
      ],
    );
  }
}
