import 'package:dio/dio.dart';
import '../../models/user/login-model.dart';

class LoginService {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'http://localhost:3000/login'));

  Future<LoginResponse> login(String email, String password) async {
    try {
      final response = await _dio.post(
        '/login',
        data: {'email': email, 'password': password},
      );

      return LoginResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(
          e.response?.data['message'] ?? 'Error al iniciar sesión');
    }
  }
}
