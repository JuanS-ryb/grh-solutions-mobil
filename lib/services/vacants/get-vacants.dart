import 'package:dio/dio.dart';
import 'package:grhsolutions/dio/dio.dart';
import 'package:grhsolutions/models/vacants/get-model.dart';

class GetVacantsService {
  final http = Http();
  final String baseEndpoint = "/vacancies/getAll";

  Future<VacantsResponseModel> getVacants({
    String? title,
    bool? isRemoto,
  }) async {
    try {
      final Map<String, dynamic> queryParams = {};

      if (title != null && title.isNotEmpty) {
        queryParams['tittle'] = title;
      }

      if (isRemoto == true) {
        queryParams['isRemoto'] = "remote";
      }

      final response = await http.get(
        baseEndpoint,
        queryParameters: queryParams,
      );

      return VacantsResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(
        e.response?.data['message'] ?? 'Error al obtener vacantes',
      );
    }
  }
}
