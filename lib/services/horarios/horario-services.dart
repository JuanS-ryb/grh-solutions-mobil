import 'package:dio/dio.dart';
import 'package:grhsolutions/dio/dio.dart';
import 'package:grhsolutions/models/horarios/schedule_model.dart';

class HorarioService {
  final http = Http();
  final String baseEndpoint = "/horario";
  Future<String> testapi() async {
    try {
      final response = await http.get(
        '/testapi',
      );
      return response.data['message'];
    }on DioException catch (e) {
      throw Exception(
          e.response?.data['message'] ?? 'Error');
    }
  }
  Future<Schedule> getHorarios() async {
    try {
      final response = await http.get(
        '$baseEndpoint/getAllNoPage',
      );
      return Schedule.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(
          e.response?.data['message'] ?? 'Error al iniciar sesión');
    }
  }
}
