import 'package:dio/dio.dart';
import 'package:grhsolutions/dio/dio.dart';
import 'package:grhsolutions/models/user/permissions.dart';
import '../../models/user/login-model.dart';

class LoginService {
  final http = Http();
  final String baseEndpoint = "/login";
  final String base2Endpoint = "/permission";

  Future<AuthResponse> login(String email, String password) async {
    try {
      final response = await http.post(
        '$baseEndpoint/login',
        data: {'email': email, 'password': password},
      );

      return AuthResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(
          e.response?.data['message'] ?? 'Error al iniciar sesión');
    }
  }

  Future<VerifiedPermission> verify(List<Map<String, String?>> ident, String token) async {
    try{
      //print(token);
      final response = await http.post('$base2Endpoint/getPermissions', data: {
        'idents': ident
      }, overWriteHeader: {'Authorization': 'Bearer $token',});
      return VerifiedPermission.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(
          e.response?.data['message'] ?? 'Error al iniciar sesión');
    }
  }
}
