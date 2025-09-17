class AuthResponse {
  final User user;
  final String token;

  AuthResponse({
    required this.user,
    required this.token,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      user: User.fromJson(json['user']),
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "user": user.toJson(),
      "token": token,
    };
  }
}

class User {
  final String id;
  final String email;
  final String rol;
  final String profile;

  User({
    required this.id,
    required this.email,
    required this.rol,
    required this.profile,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      rol: json['rol'],
      profile: json['profile'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "email": email,
      "rol": rol,
      "profile": profile,
    };
  }
}
