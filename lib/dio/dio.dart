import 'package:dio/dio.dart';
import '../data/notifiers.dart';

class Http {
  late final Dio _dio;

  Http() {
    final String token = loginController.value?.token ?? '';

    _dio = Dio(
      BaseOptions(
        baseUrl: 'http://localhost:3000/api', // Usar localhost 3000 para pruebas.
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 3),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      ),
    );
  }

  // Método GET para obtener una lista de recursos
  Future<Response> get(String path, {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.get(path, queryParameters: queryParameters);
      return response;
    } on DioException catch (e) {
      _handleDioError(e, path);
      rethrow;
    } catch (e) {
      print('Error inesperado en GET $path: $e');
      rethrow;
    }
  }

  // Método GET para obtener un recurso específico por su ID
  Future<Response> getById(String path, dynamic id) async {
    try {
      final response = await _dio.get('$path/$id');
      return response;
    } on DioException catch (e) {
      _handleDioError(e, '$path/$id');
      rethrow;
    } catch (e) {
      print('Error inesperado en GET $path/$id: $e');
      rethrow;
    }
  }

  // Método POST para crear un nuevo recurso
  Future<Response> post(String path, {dynamic data}) async {
    try {
      final response = await _dio.post(path, data: data);
      return response;
    } on DioException catch (e) {
      _handleDioError(e, path);
      rethrow;
    } catch (e) {
      print('Error inesperado en POST $path: $e');
      rethrow;
    }
  }

  // Método PUT para actualizar un recurso existente
  Future<Response> put(String path, dynamic id, {dynamic data}) async {
    try {
      final response = await _dio.put('$path/$id', data: data);
      return response;
    } on DioException catch (e) {
      _handleDioError(e, '$path/$id');
      rethrow;
    } catch (e) {
      print('Error inesperado en PUT $path/$id: $e');
      rethrow;
    }
  }

  // Método DELETE para eliminar un recurso
  Future<Response> delete(String path, dynamic id) async {
    try {
      final response = await _dio.delete('$path/$id');
      return response;
    } on DioException catch (e) {
      _handleDioError(e, '$path/$id');
      rethrow;
    } catch (e) {
      print('Error inesperado en DELETE $path/$id: $e');
      rethrow;
    }
  }

  // Manejo de errores de Dio
  void _handleDioError(DioException e, String requestPath) {
    String errorMessage;
    if (e.response != null) {
      errorMessage =
          'Error en la solicitud a $requestPath: ${e.response?.statusCode} - ${e.response?.data?['message'] ?? e.response?.statusMessage}';
    } else {
      errorMessage = 'Error de conexión en $requestPath: ${e.message}';
    }
    print(errorMessage);
  }

  // Método para actualizar el token dinámicamente
  void setAuthorizationToken(String? token) {
    if (token != null) {
      _dio.options.headers['Authorization'] = 'Bearer $token';
    } else {
      _dio.options.headers.remove('Authorization');
    }
  }
}
