import 'package:wp_integration/services/auth_service.dart';

class UserRepository {
  final AuthService authService = AuthService();

  Future<Map<String, dynamic>> login(String email, String passwd) async {
    final response = await authService.login(email, passwd);

    return response.data;
  }
}
