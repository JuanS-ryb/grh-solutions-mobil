// involved-service.dart
import 'package:dio/dio.dart';
import '../../dio/dio.dart';
import '../../models/request/involved-model.dart';

class InvolvedService {
  final Http _http = Http();
  final String baseEndpoint = "/involved";

  Future<List<InvolvedItem>> getInvolvedByRequestId(String requestId) async {
    try {
      final Response response = await _http.get(
        '$baseEndpoint/getByRequestId',
        queryParameters: {'requestId': requestId},
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((e) => InvolvedItem.fromJson(e)).toList();
      } else {
        print("Error en la respuesta: ${response.statusCode}");
        return [];
      }
    } catch (e) {
      print("Error al cargar involucrados: $e");
      return [];
    }
  }
}
