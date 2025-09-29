import 'package:dio/dio.dart';
import '../../dio/dio.dart';
import '../../models/request/history-model.dart';

class HistoryService {
  final Http _http = Http();
  final String baseEndpoint = "/history";

  Future<List<HistoryItem>> getHistory(String requestId) async {
    if (requestId.isEmpty) {
      print("Error: requestId está vacío");
      return [];
    }

    try {
      final Response response = await _http.get(
        '$baseEndpoint/getByRequestId',
        queryParameters: {'requestId': requestId},
      );


      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((e) => HistoryItem.fromJson(e)).toList();
      } else {
        return [];
      }
    } on DioException catch (dioError) {
      print("DioException al cargar historial: ${dioError.message}");
      if (dioError.response != null) {
        print("Código de respuesta: ${dioError.response?.statusCode}");
        print("Datos de respuesta: ${dioError.response?.data}");
      }
      return [];
    } catch (e) {
      print("Error al cargar historial: $e");
      return [];
    }
  }
}
