import 'package:dio/dio.dart';
import 'package:grhsolutions/dio/dio.dart';
import '../../models/user/login-model.dart';

class LoginService {
  final http = Http();
  final String baseEndpoint = "/login";
  Future<LoginResponse> login(String email, String password) async {
    try {
      final response = await http.post(
        '$baseEndpoint/login',
        data: {'email': email, 'password': password},
      );

      return LoginResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(
          e.response?.data['message'] ?? 'Error al iniciar sesión');
    }
  }
}
