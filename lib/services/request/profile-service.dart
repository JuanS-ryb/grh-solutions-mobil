import 'package:dio/dio.dart';
import '../../dio/dio.dart';
import '../../models/request/profile-model.dart' as profile_model;

class ProfileService {
  final Http _http = Http();
  final String baseEndpoint = "/user"; // Cambiado a user

  /// Trae el perfil del usuario actual
  Future<profile_model.Profile?> getCurrentProfile() async {
    try {
      final Response response = await _http.get('$baseEndpoint/getMyInfo'); // endpoint correcto

      if (response.statusCode == 200 && response.data != null) {
        // Verificamos que sea un JSON de perfil y no un mensaje de error
        if (response.data is Map<String, dynamic>) {
          return profile_model.Profile.fromJson(
              Map<String, dynamic>.from(response.data));
        } else {
          print("Error: la respuesta no es un objeto JSON esperado");
          return null;
        }
      } else {
        print("Error al cargar perfil: ${response.statusCode}");
        return null;
      }
    } on DioException catch (dioError) {
      print("DioException al cargar perfil: ${dioError.message}");
      if (dioError.response != null) {
        print("Código de respuesta: ${dioError.response?.statusCode}");
        print("Datos de respuesta: ${dioError.response?.data}");
      }
      return null;
    } catch (e) {
      print("Error al cargar perfil: $e");
      return null;
    }
  }

  /// Trae un perfil por su ID
  Future<profile_model.Profile?> getProfileById(String profileId) async {
    if (profileId.isEmpty) return null;

    try {
      final Response response = await _http.get('$baseEndpoint/$profileId');

      if (response.statusCode == 200 && response.data != null) {
        if (response.data is Map<String, dynamic>) {
          return profile_model.Profile.fromJson(
              Map<String, dynamic>.from(response.data));
        } else {
          print("Error: la respuesta no es un objeto JSON esperado");
          return null;
        }
      } else {
        print("Error al cargar perfil por ID: ${response.statusCode}");
        return null;
      }
    } on DioException catch (dioError) {
      print("DioException al cargar perfil por ID: ${dioError.message}");
      if (dioError.response != null) {
        print("Código de respuesta: ${dioError.response?.statusCode}");
        print("Datos de respuesta: ${dioError.response?.data}");
      }
      return null;
    } catch (e) {
      print("Error al cargar perfil por ID: $e");
      return null;
    }
  }

  Future getMyProfile() async {}
}
