import 'package:dio/dio.dart';
import '../dio/dio.dart';
import '../models/request-models.dart';

class RequestService {
  final Http _http = Http();
  final String baseEndpoint = "/request";

  Future<List<RequestItem>> getRequests() async {
    try {
      final Response response = await _http.get('$baseEndpoint/getAll');

      final List<dynamic> data = response.data;
      return data.map((e) => RequestItem.fromJson(e)).toList();
    } catch (e) {
      print("Error al cargar requests: $e");
      rethrow;
    }
  }
}
