import 'package:dio/dio.dart';
import '../../dio/dio.dart';
import '../../models/request/request-models.dart';

class RequestService {
  final Http _http = Http();
  final String baseEndpoint = "/request";

  Future<List<RequestItem>> getRequests() async {
    try {
      final Response response = await _http.get('$baseEndpoint/getAll');

      // Asegurarse que response.data sea lista
      final List<dynamic> data =
          response.data is List ? response.data : [];

      // Mapear cada elemento al modelo, forzando _id a String
      return data.map((e) {
        // Si e es Map<String, dynamic>
        if (e is Map<String, dynamic>) {
          // Forzar _id a string
          e['_id'] = e['_id']?.toString();
          return RequestItem.fromJson(e);
        }
        return RequestItem(
          id: '',
          title: '',
          status: '',
          typeRequest: '',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(), createdBy: '', file: [],
        ); // fallback seguro
      }).toList();
    } catch (e) {
      print("Error al cargar requests: $e");
      rethrow;
    }
  }
}
