class LoginRequestDto {
  final String email;
  final String password;

  LoginRequestDto({required this.email, required this.password});

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}

class SignupRequestDto {
  final String email;
  final String password;
  final String name;

  SignupRequestDto({required this.email, required this.password, required this.name});

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'name': name,
    };
  }
}

class AuthResponseDto {
  final String token;
  final String message;

  AuthResponseDto({required this.token, required this.message});

  factory AuthResponseDto.fromJson(Map<String, dynamic> json) {
    return AuthResponseDto(
      token: json['token'],
      message: json['message'],
    );
  }
}
