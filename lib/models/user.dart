class User {
  final String id;
  final String username;
  final String surname;
  final String email;
  final String department;
  final String rol;
  final String birthdate;

  User({
    required this.id,
    required this.username,
    required this.surname,
    required this.email,
    required this.department,
    required this.rol,
    required this.birthdate,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    // Separamos la fecha en tres
    var birthdate = (json["birthdate"] as String).split("-").reversed.join("/");


    return User(
      id: json["id"],
      username: json["username"],
      surname: json["surname"],
      email: json["email"],
      department: json["department"],
      rol: json["rol"],
      birthdate: birthdate,
    );
  }
}
