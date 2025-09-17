import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio;

  ApiService({String? baseUrl})
      : _dio = Dio(
          BaseOptions(
            baseUrl: baseUrl ?? 'https://tuapi.com/api',
            connectTimeout: const Duration(seconds: 10),
            receiveTimeout: const Duration(seconds: 10),
            headers: {'Content-Type': 'application/json'},
          ),
        );

  /// GET: obtiene todos los registros
  Future<Response> get(String endpoint) async {
    return await _dio.get(endpoint);
  }

  /// GET BY ID: obtiene un registro específico
  Future<Response> getById(String endpoint, String id) async {
    return await _dio.get('$endpoint/$id');
  }

  /// POST: crea un nuevo recurso
  Future<Response> post(String endpoint, Map<String, dynamic> data) async {
    return await _dio.post(endpoint, data: data);
  }

  /// PUT: actualiza un recurso existente
  Future<Response> put(
      String endpoint, String id, Map<String, dynamic> data) async {
    return await _dio.put('$endpoint/$id', data: data);
  }

  /// DELETE: elimina un recurso
  Future<Response> delete(String endpoint, String id) async {
    return await _dio.delete('$endpoint/$id');
  }
}
