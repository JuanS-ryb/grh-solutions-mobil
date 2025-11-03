import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import '../../dio/dio.dart';
import '../../models/request/request-models.dart';

class RequestService {
  final Http _http = Http();
  final String baseEndpoint = "/request";

  /// Obtener todas las solicitudes
  Future<List<RequestItem>> getRequests() async {
    try {
      final Response response = await _http.get('$baseEndpoint/getAll');
      final List<dynamic> data = response.data is List ? response.data : [];
      return data.map((e) {
        if (e is Map<String, dynamic>) {
          e['_id'] = e['_id']?.toString();
          return RequestItem.fromJson(e);
        }
        return RequestItem(
          id: '',
          title: '',
          status: '',
          typeRequest: '',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          createdBy: '',
          file: [],
        );
      }).toList();
    } catch (e) {
      print("Error al cargar requests: $e");
      rethrow;
    }
  }

  /// Crear solicitud
  Future<RequestItem> createRequest({
    required String title,
    required String typeRequest,
    String? description,
    required String createdBy,
    required String status,
    List<PlatformFile>? files, // ✅ CAMBIO AQUÍ
  }) async {
    try {
      // Convertir los archivos seleccionados a base64
      List<Map<String, dynamic>> filesBase64 = [];

      if (files != null && files.isNotEmpty) {
        filesBase64 = files.map((file) {
          final base64File = base64Encode(file.bytes!);
          return {
            "id": DateTime.now().millisecondsSinceEpoch.toString(),
            "name": file.name,
            "type": file.extension ?? '',
            "size": file.size,
            "base64": base64File,
          };
        }).toList();
      }

      // Crear el cuerpo de la solicitud
      final payload = {
        "createdBy": createdBy,
        "title": title,
        "status": status,
        "type_request": typeRequest,
        if (description != null && description.isNotEmpty) "infoDx": description,
        if (filesBase64.isNotEmpty) "file": filesBase64,
      };

      final Response response = await _http.post('$baseEndpoint/create', data: payload);

      if (response.data != null && response.data is Map<String, dynamic>) {
        return RequestItem.fromJson(response.data);
      } else {
        throw Exception("Error al crear solicitud: respuesta inválida");
      }
    } catch (e) {
      print("Error al crear solicitud: $e");
      rethrow;
    }
  }
}
