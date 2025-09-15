class LoginResponse {
  final String token;
  final Map<String, dynamic> user;
  final Map<String, dynamic>? warnings;

  LoginResponse({
    required this.token,
    required this.user,
    this.warnings,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      token: json['token'] ?? '',
      user: Map<String, dynamic>.from(json['user'] ?? {}),
      warnings: json['warnings'] != null
          ? Map<String, dynamic>.from(json['warnings'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'user': user,
      if (warnings != null) 'warnings': warnings,
    };
  }
}
