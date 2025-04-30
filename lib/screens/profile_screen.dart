// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import 'package:hbd_app/core/storage/persistend_storage.dart';
import 'package:hbd_app/core/theme/app_colors.dart';
import 'package:hbd_app/models/user.dart';
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

        return profileViewer(context, userData);
      },
    );
  }

  Scaffold profileViewer(BuildContext context, User userData) {
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
            onTap: () {},
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
                  color: Colors.white,
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
                    Text("Email: ${userData.email}"),
                    SizedBox(height: 8),
                    Text("Departamento: ${userData.department}"),
                    SizedBox(height: 8),
                    Text("F. nacimiento: ${userData.birthdate}"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}