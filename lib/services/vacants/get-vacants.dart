import 'package:dio/dio.dart';
import 'package:grhsolutions/dio/dio.dart';
import 'package:grhsolutions/models/vacants/get-model.dart';

class GetVacantsService {
  final http = Http();
  final String baseEndpoint = "/vacancies/getAll";

  Future<VacantsResponseModel> getVacants() async {
    try {
      final response = await http.get(baseEndpoint);
      return VacantsResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(
          e.response?.data['message'] ?? 'Error al obtener vacantes');
    }
  }
}
