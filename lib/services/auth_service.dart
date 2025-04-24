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

  Future<Response> login(String email, String passwd) async {
    final data = {"email": email, "passwd": passwd};

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
}
