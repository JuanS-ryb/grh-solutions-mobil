import 'package:dio/dio.dart';
import '../domain/dio.dart'; // donde está tu ApiService

class HorarioService {
  final ApiService _api;

  HorarioService({required ApiService api}) : _api = api;

  /// Obtiene la lista de horarios desde tu backend
  Future<Response> getHorarios() async {
    try {
      final response = await _api.get('/testapi');
      return response;
    } on DioException catch (e) {
      // Puedes lanzar el error o devolver un mensaje más claro
      throw Exception('Error al obtener los horarios: ${e.message}');
    }
  }
}

