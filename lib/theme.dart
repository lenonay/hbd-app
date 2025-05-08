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
  
  // Duke
  static const duke = Color(0xFF9662AA); // #813d9c
  static const dukeAcc = Color(0xFFA487AF); // #813d9c


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
  static const textOnPrimary = Color(
    0xFF2D2216,
  ); // Contraste mejorado para primary
  static const shadowDuke = Color(0x30B45FD6);
}

final ThemeData appTheme = ThemeData(
  useMaterial3: true,

  colorScheme: ColorScheme.light(
    // Corregir esquema de color principal
    primary: AppColors.primary,
    onPrimary: AppColors.textOnPrimary, // Nuevo color con mejor contraste
    primaryContainer: AppColors.primaryTint20,
    secondary: AppColors.secondary,
    onSecondary: AppColors.neutral900, // Mejor contraste
    secondaryContainer: AppColors.secondaryAcc,
    surface: AppColors.neutral100,
    onSurface: AppColors.neutral900,
    error: AppColors.alert,
    onError: Colors.white,
    shadow: AppColors.shadowBlack,
  ),

  // Añadir tema específico para AppBar
  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.primary,
    titleTextStyle: TextStyle(
      color: AppColors.textOnPrimary,
      fontSize: 20,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.15,
      fontFamily: 'Cuprum'
    ),
    iconTheme: IconThemeData(color: AppColors.textOnPrimary),
    elevation: 2,
    shadowColor: AppColors.shadowPrimary,
  ),

  // Mejorar textTheme con jerarquía más clara
  textTheme: TextTheme(
    displayLarge: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: AppColors.neutral900,
      fontFamily: 'Cuprum',
    ),
    displayMedium: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: AppColors.neutral900,
      fontFamily: 'Cuprum',
    ),
    bodyLarge: TextStyle(
      fontSize: 18,
      color: AppColors.neutral800, // Mejor contraste que 900 en fondos claros
      fontFamily: 'Cuprum',
    ),
    bodyMedium: TextStyle(
      fontSize: 16,
      color: AppColors.neutral800,
      fontFamily: 'Cuprum',
    ),
    titleLarge: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: AppColors.neutral900,
      fontFamily: 'Cuprum',
    ),
    labelLarge: TextStyle(
      fontWeight: FontWeight.w600,
      letterSpacing: 0.5,
      fontFamily: 'Cuprum',
    ),
  ),

  // Actualizar botones para mejor contraste
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.textOnPrimary, // Usar nuevo color de contraste
      textStyle: ThemeData.light().textTheme.labelLarge?.copyWith(
        color: AppColors.textOnPrimary,
        fontWeight: FontWeight.bold,
        fontFamily: 'Cuprum',
        fontSize: 16
      ),
      elevation: 4,
      shadowColor: AppColors.shadowPrimary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))
    ),
  ),

  // Mejorar tarjetas
  cardTheme: CardTheme(
    color: AppColors.primaryTint40,
    shadowColor: AppColors.shadowBlack,
    elevation: 2,
    margin: const EdgeInsets.all(8),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  ),

  // Mejorar campos de formulario
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppColors.neutral100,
    labelStyle: TextStyle(color: AppColors.neutral700),
    floatingLabelStyle: TextStyle(color: AppColors.primary),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.primary, width: 1.5),
      borderRadius: BorderRadius.circular(8),
    ),
    border: OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.neutral300),
      borderRadius: BorderRadius.circular(8),
    ),
  ),

  tabBarTheme: TabBarTheme(
    labelColor: AppColors.neutral900, // Color cuando está seleccionado
    unselectedLabelColor:
        AppColors.primaryShade20, // Color cuando no está seleccionado
    indicator: BoxDecoration(
      border: Border(bottom: BorderSide(color: AppColors.neutral900, width: 2)),
    ),
    indicatorSize: TabBarIndicatorSize.label,
    labelStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
    unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
  ),

  snackBarTheme: SnackBarThemeData(
    contentTextStyle: TextStyle(
      fontSize: 18,
      color: AppColors.neutral900,
      fontWeight: FontWeight.bold,
      fontFamily: 'Cuprum'
    ),
    backgroundColor: AppColors.primaryShade20,
  ),
);
