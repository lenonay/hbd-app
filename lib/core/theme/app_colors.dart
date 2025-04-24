import 'package:flutter/material.dart';

/// Define todos los colores de la paleta CSS como constantes Dart
class AppColors {
  // Backgrounds y neutrales
  static const bg = Color(0xFFFFFDED); // #fffded
  static const neutral100 = Color(0xFFF8F4E3); // #f8f4e3
  static const neutral200 = Color(0xFFE5DFC5); // #e5dfc5
  static const neutral300 = Color(0xFFC4BDA8); // #c4bda8
   // Neutrales oscuros para texto
  static const neutral700 = Color(0xFF616161); // gris oscuro
  static const neutral800 = Color(0xFF424242); // gris más oscuro
  static const neutral900 = Color(0xFF212121); // casi negro

  // Primarios
  static const primary = Color(0xFFD4A373); // #d4a373
  static const primaryAcc = Color(0xFFFAEDCD); // #faedcd
  static const primaryTint20 = Color(0xFFF5E5D0); // #f5e5d0
  static const primaryTint40 = Color(0xFFF0DDB5); // #f0ddb5
  static const primaryShade20 = Color(0xFFA87D56); // #a87d56

  // Secundarios
  static const secondary = Color(0xFFAAB38E); // #aab38e
  static const secondaryAcc = Color(0xFFE9EDC9); // #e9edc9
  static const secondaryStrong = Color(0xFF88965F); // #88965f

  // Terciarios
  static const tertiary = Color(0xFFC9C19D); // #c9c19d
  static const tertiaryAcc = Color(0xFFF2EFDF); // #f2efdf

  // Destacado y alertas
  static const highlight = Color(0xFFFFF3D6); // #fff3d6
  static const alert = Color(0xFFB01E1E); // #b01e1e
  static const textOnPrimaryAcc = Color(0xFF5E4A32); // #5e4a32

  // Sombras (alpha al principio)
  static const shadowBlack = Color(0x30000000); // #00000030
  static const shadowPrimary = Color(0x30A87D56); // #a87d5630
}

/// Crea un ThemeData que aproveche tu paleta
final ThemeData appTheme = ThemeData(
  useMaterial3: true,

  // Basicos
  scaffoldBackgroundColor: AppColors.bg,
  primaryColor: AppColors.primary,
  highlightColor: AppColors.highlight,

  // El nuevo sistema de color
  colorScheme: ColorScheme.light(
    primary: AppColors.primaryTint40,
    onPrimary: AppColors.textOnPrimaryAcc,
    primaryContainer: AppColors.primaryTint20,
    secondary: AppColors.secondary,
    onSecondary: AppColors.bg,
    secondaryContainer: AppColors.secondaryAcc,
    surface: AppColors.neutral100,
    onSurface: AppColors.neutral300,
    error: AppColors.alert,
    onError: Colors.white,
    shadow: AppColors.shadowBlack,
  ),

  // Tipografías
  textTheme: TextTheme(
    bodyLarge: TextStyle(color: AppColors.neutral900),
    bodyMedium: TextStyle(color: AppColors.neutral900),
    bodySmall: TextStyle(color: AppColors.neutral900),
    titleLarge: TextStyle(color: AppColors.primary),
    titleMedium: TextStyle(color: AppColors.primaryShade20),
  ),

  // ElevatedButton por ejemplo, usa primario y sombras personalizadas
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.textOnPrimaryAcc,
      shadowColor: AppColors.shadowPrimary,
      elevation: 4,
    ),
  ),

  // Card con sombra suave
  cardTheme: CardTheme(
    color: AppColors.primaryTint40,
    shadowColor: AppColors.shadowBlack,
    elevation: 2,
    margin: const EdgeInsets.all(8),
  ),

  // InputDecoration (ej. TextField)
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppColors.neutral100,
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.primary),
      borderRadius: BorderRadius.circular(8),
    ),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
  ),

  // Decoración para container

  // SnackBar usa alert para acciones de error
  snackBarTheme: SnackBarThemeData(
    backgroundColor: AppColors.alert,
    contentTextStyle: TextStyle(color: Colors.white),
  ),
);
