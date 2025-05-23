import 'package:hbd_app/services/auth_service.dart';

class UserRepository {
  // Instanciamos el servicio de autenticación
  final AuthService authService = AuthService();

  Future<Map<String, dynamic>> login(String email, String passwd, String version) async {
    // Hacemos la petición para inicar sesión
    final response = await authService.login(email, passwd, version);

    return response.data;
  }
}
