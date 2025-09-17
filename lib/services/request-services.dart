import 'package:dio/dio.dart';
import '../data/domain/dio.dart';
import '../models/request-models.dart';


class RequestService {
  final ApiService _api = ApiService(baseUrl: "http://localhost:3000/api"); 
  // O si quieres usar la otra clase:
  // final Http _api = Http();

  Future<List<RequestItem>> getRequests() async {
    try {
      final Response response = await _api.get("/requests");
      final List<dynamic> data = response.data;

      return data.map((e) => RequestItem.fromJson(e)).toList();
    } catch (e) {
      print("Error al cargar requests: $e");
      rethrow;
    }
  }
}
