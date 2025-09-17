import 'package:dio/dio.dart';
import 'package:grhsolutions/dio/dio.dart';
import 'package:grhsolutions/models/vacants/get-model.dart';

/// Servicio para traer una vacante por ID
class GetVacantIdService {
  final http = Http();

  Future<Vacants> getVacantById(String id) async {
    final String baseEndpoint = "/vacancies/getById?id=$id";

    try {
      final response = await http.get(baseEndpoint);

      return Vacants.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(
          e.response?.data['message'] ?? 'Error al obtener la vacante');
    }
  }
}
