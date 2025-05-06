// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:hbd_app/core/mixins/auth_mixin.dart';

import 'package:hbd_app/core/storage/persistend_storage.dart';
import 'package:hbd_app/data/env.dart';
import 'package:hbd_app/models/user.dart';
import 'package:hbd_app/screens/auth/unauth_screen.dart';
import 'package:hbd_app/services/auth_service.dart';
import 'package:hbd_app/theme.dart';
import 'package:hbd_app/widgets/auth/auth_wrapper.dart';
import '../routes.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with AuthMixin {
  final AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return AuthWrapper(
      authFuture: checkAuth(),
      authBuilder:
          (context) => Screen(authService: authService, mounted: mounted),
      unAuthBuilder: (context) => UnAuthScreen(),
    );
  }
}

class Screen extends StatelessWidget {
  const Screen({super.key, required this.authService, required this.mounted});

  final AuthService authService;
  final bool mounted;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: PersistentStorage.getUserData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError || !snapshot.hasData) {
          return Text("Hubo un error");
        }

        final userData = snapshot.data!;

        return ProfileViewer(
          authService: authService,
          mounted: mounted,
          context: context,
          userData: userData,
        );
      },
    );
  }
}

class ProfileViewer extends StatelessWidget {
  const ProfileViewer({
    super.key,
    required this.authService,
    required this.mounted,
    required this.context,
    required this.userData,
  });

  final AuthService authService;
  final bool mounted;
  final BuildContext context;
  final User userData;

  @override
  Widget build(BuildContext context) {
    void onLogout() async {
      final logout = await authService.logout();

      if (logout && mounted) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          Routes.home,
          (Route<dynamic> route) =>
              false, // Borra todas las rutas anteriores ya que no se cumple la condicion
        );
        return;
      }

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error al cerrar sesión")));
    }

    void onChangePassword() {
      Navigator.pushNamed(context, Routes.changePasswd);
    }

    void onHelp() {
      Navigator.pushNamed(context, Routes.help);
    }

    return Scaffold(
      floatingActionButton: SpeedDial(
        icon: Icons.person,
        activeIcon: Icons.close,
        backgroundColor: AppColors.primary,
        overlayColor: Colors.black,
        overlayOpacity: 0.4,
        spacing: 12,
        spaceBetweenChildren: 8,
        children: [
          SpeedDialChild(
            backgroundColor: AppColors.primaryTint40,
            labelBackgroundColor: AppColors.primaryTint20,
            labelShadow: [
              BoxShadow(
                offset: Offset(0, 0),
                spreadRadius: 2,
                blurRadius: 10,
                color: AppColors.shadowPrimary,
              ),
            ],
            labelStyle: TextStyle(fontSize: 16),
            child: Icon(Icons.logout),
            label: 'Cerrar sesión',
            onTap: onLogout,
          ),
          SpeedDialChild(
            backgroundColor: AppColors.primaryTint40,
            labelBackgroundColor: AppColors.primaryTint20,
            labelShadow: [
              BoxShadow(
                offset: Offset(0, 0),
                spreadRadius: 2,
                blurRadius: 10,
                color: AppColors.shadowPrimary,
              ),
            ],
            labelStyle: TextStyle(fontSize: 16),
            child: Icon(Icons.vpn_key),
            label: 'Cambiar contraseña',
            onTap: onChangePassword,
          ),
          SpeedDialChild(
            backgroundColor: AppColors.primaryTint40,
            labelBackgroundColor: AppColors.primaryTint20,
            labelShadow: [
              BoxShadow(
                offset: Offset(0, 0),
                spreadRadius: 2,
                blurRadius: 10,
                color: AppColors.shadowPrimary,
              ),
            ],
            labelStyle: TextStyle(fontSize: 16),
            child: Icon(Icons.help),
            label: 'Ayuda',
            onTap: onHelp,
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Material(
                elevation: 8,
                shape: CircleBorder(),
                shadowColor: AppColors.primaryShade20,
                child: CircleAvatar(
                  radius: 75, // 150/2
                  backgroundImage: AssetImage("assets/images/pfp.jpg"),
                ),
              ),
              SizedBox(height: 10),
              Text(
                "¡Hola, ${userData.username} ${userData.surname}!",
                style: TextStyle(fontSize: 28),
              ),
              SizedBox(height: 20),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.primaryTint20,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Información Personal",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    RichText(
                      text: TextSpan(
                        text: 'Email: ',
                        style: TextStyle(
                          color: AppColors.neutral900,
                          fontSize: 16,
                        ),
                        children: [
                          TextSpan(
                            text: userData.email,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 8),
                    RichText(
                      text: TextSpan(
                        text: 'Departamento: ',
                        style: TextStyle(
                          color: AppColors.neutral900,
                          fontSize: 16,
                        ),
                        children: [
                          TextSpan(
                            text: userData.department.toUpperCase(),
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 8),
                    RichText(
                      text: TextSpan(
                        text: 'F. Nacimiento: ',
                        style: TextStyle(
                          color: AppColors.neutral900,
                          fontSize: 16,
                        ),
                        children: [
                          TextSpan(
                            text: userData.birthdate,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(flex: 1),
              Text(
                'Versión: ${Env.version}',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
