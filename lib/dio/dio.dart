import 'package:dio/dio.dart';
import '../data/notifiers.dart';

class Http {
  late final Dio _dio;

  Http() {
    final String token = loginController.value?.token ?? '';
    ///print(token);

    _dio = Dio(
      BaseOptions(
        baseUrl: 'http://${"192.168.1.13"}:3000/api',
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
      handleDioError(e, path);
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
      handleDioError(e, '$path/$id');
      rethrow;
    } catch (e) {
      print('Error inesperado en GET $path/$id: $e');
      rethrow;
    }
  }

  // Método POST para crear un nuevo recurso
  Future<Response> post(String path, {dynamic data, Map<String, dynamic>? overWriteHeader}) async {
    try {
      final response = await _dio.post(path, data: data, options: Options(headers: overWriteHeader));
      return response;
    } on DioException catch (e) {
      handleDioError(e, path);
      rethrow;
    } catch (e) {
      print('Error inesperado en POST $path: $e');
      rethrow;
    }
  }

  // Método PUT para actualizar un recurso existente
  Future<Response> put(String path, dynamic id, {dynamic data, Map<String, dynamic>? overWriteHeader}) async {
    try {
      final response = await _dio.put('$path/$id', data: data, options: Options(headers: overWriteHeader));
      return response;
    } on DioException catch (e) {
      handleDioError(e, '$path/$id');
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
      handleDioError(e, '$path/$id');
      rethrow;
    } catch (e) {
      print('Error inesperado en DELETE $path/$id: $e');
      rethrow;
    }
  }

  void handleDioError(DioException e, String requestPath) {
    String errorMessage;

    if (e.response != null) {
      final statusCode = e.response?.statusCode;

      // 🚨 Catcher de 401 → cerrar sesión automáticamente
      if (statusCode == 401) {
        isLoggedIn.value = false;
        loginController.value = null;
        print("Sesión cerrada automáticamente por 401 Unauthorized");
      }

      errorMessage =
      'Error en la solicitud a $requestPath: $statusCode - ${e.response?.data?['message'] ?? e.response?.statusMessage}';
    } else {
      errorMessage = 'Error de conexión en $requestPath: ${e.message}';
    }

    print(errorMessage);
  }
}
