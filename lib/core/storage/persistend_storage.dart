import 'package:hbd_app/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PersistentStorage {
  static saveUserData(User user) async {
    // Cargamos la instancia de las preferencias
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // Guardamos toda la info
    prefs.setString("id", user.id);
    prefs.setString("username", user.username);
    prefs.setString("surname", user.surname);
    prefs.setString("email", user.email);
    prefs.setString("department", user.department);
    prefs.setString("rol", user.rol);
    prefs.setString("birthdate", user.birthdate);
  }

  static Future<User> getUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // Devolvemos 
    return User(
      id: prefs.getString("id")!,
      username: prefs.getString("username")!,
      surname: prefs.getString("surname")!,
      email: prefs.getString("email")!,
      department: prefs.getString("department")!,
      rol: prefs.getString("rol")!,
      birthdate: prefs.getString("birthdate")!,
    );
  }
}
