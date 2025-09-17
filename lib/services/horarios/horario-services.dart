import 'package:dio/dio.dart';
import 'package:grhsolutions/dio/dio.dart';
import 'package:grhsolutions/models/horarios/schedule_model.dart';

class HorarioService {
  final http = Http();
  final String baseEndpoint = "/schedules";


  Future<List<Schedule>> getHorarios() async {
    try {
      final response = await http.get('$baseEndpoint/getAllNoPage');
      final List data = response.data as List;
      return data.map((e) => Schedule.fromJson(e as Map<String, dynamic>)).toList();
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Error al obtener horarios');
    }
  }
}
