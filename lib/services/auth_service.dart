import 'package:dio/dio.dart';
import '/core/network/api_routes.dart';
import '/core/network/dio_client.dart';

class AuthService {
  // Constructor privado para implementar opcionalmente el patrón singleton en AuthService.
  AuthService._internal();

  // Instancia única de AuthService (opcional si se desea singleton en este nivel)
  static final AuthService _instance = AuthService._internal();

  // Al llamar a AuthService(), siempre se devuelve la misma instancia.
  factory AuthService() {
    return _instance;
  }

  final DioClient _dioClient = DioClient();

  Future<Response> login(String email, String passwd, String version) async {
    final data = {"email": email, "passwd": passwd, "version": version};

    final response = await _dioClient.request(
      "POST",
      ApiRoutes.login,
      data: data,
    );

    return response;
  }

  Future<bool> logout() async {
    try {
      // Cerramos sesión
      await _dioClient.logout();

      return true;
    } catch (error) {
      return false;
    }
  }

  Future<Map<String, dynamic>> changePasswd(
    String currentPasswd,
    String newPasswd,
  ) async {
    try {
      // 1. Preparamos el cuerpo de la peticion
      final data = {"currentPasswd": currentPasswd, "newPasswd": newPasswd};

      final response = await _dioClient.request(
        "PATCH",
        ApiRoutes.updatePasswd,
        data: data,
      );

      if (response.statusCode != 200) {
        return {"success": false, "error": "Error de conexión"};
      }

      return response.data;
    } catch (e) {
      return {"success": false, "error": e};
    }
  }
}
