import 'package:dio/dio.dart';
import 'package:grhsolutions/dio/dio.dart';
import 'package:grhsolutions/models/vacants/get-my-modal.dart';

class GetMyVacantsService {
  final http = Http();

  Future<GetMyVacants> getMyVacants(String id) async {
    final String baseEndpoint = "/postulante/getAllByVacanteByUser/$id";
    try {
      final response = await http.get(baseEndpoint);
      return GetMyVacants.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Error al obtener vacantes');
    }
  }
}