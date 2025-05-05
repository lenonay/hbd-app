import 'package:flutter/material.dart';
import 'package:hbd_app/core/mixins/auth_mixin.dart';
import 'package:hbd_app/core/network/api_routes.dart';
import 'package:hbd_app/theme.dart';
import 'package:hbd_app/widgets/auth/auth_wrapper.dart';
import 'package:hbd_app/screens/auth/unauth_screen.dart';
import 'news_screen.dart';
import 'info_screen.dart';
import 'coupons_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with AuthMixin {
  late Future<bool> _authFuture;
  bool _checkedNotification = false;

  @override
  void initState() {
    _authFuture = checkAuth();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkForNotification();
    });
    super.initState();
  }

  Future<void> _checkForNotification() async {
    if (_checkedNotification) return;
    _checkedNotification = true;

    // Hacemos la consulta a la API
    final response = await dioClient.request("GET", ApiRoutes.notification);

    // Si la peticion no salio bien, salimos
    if (response.statusCode != 200 || !response.data["success"]) return;
    // Por ahora simulamos un retardo y decimos que sí hay notificación
    bool hayNotificacion = response.data["isNotification"]; // placeholder

    // Si no hay notificacion o el widget no esta montado salimos
    if (!hayNotificacion || !mounted) return;
    // Mostramos el diálogo sin permitir dismiss tocando fuera

    // Extraemos el titulo y el cuerpo
    String title = response.data["data"]["title"] ?? "Titulo placeholder";
    String content = response.data["data"]["content"] ?? "Texto placeholder";

    showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (context) => AlertDialog(
            backgroundColor: AppColors.primaryTint20,
            title: Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'Cuprum',
              ),
              textAlign: TextAlign.center,
            ),
            content: Text(
              content,
              style: TextStyle(fontSize: 18, fontFamily: 'Cuprum'),
              textAlign: TextAlign.center,
            ),
            actionsAlignment: MainAxisAlignment.center,
            actions: [
              TextButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(
                    AppColors.primaryShade20,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop(); // cierra el diálogo
                },
                child: Text(
                  'Aceptar',
                  style: TextStyle(
                    fontSize: 18,
                    color: AppColors.textOnPrimary,
                    fontFamily: 'Cuprum',
                  ),
                ),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AuthWrapper(
      authFuture: _authFuture,
      authBuilder: (context) => HomeView(),
      unAuthBuilder: (context) => UnAuthScreen(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 20,
          elevation: 0,
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.newspaper)),
              Tab(icon: Icon(Icons.info)),
              Tab(icon: Icon(Icons.card_giftcard)),
              Tab(icon: Icon(Icons.person)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            NewsScreen(),
            InfoScreen(),
            CouponsScreen(),
            ProfileScreen(),
          ],
        ),
      ),
    );
  }
}
