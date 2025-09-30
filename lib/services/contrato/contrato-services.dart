import 'package:dio/dio.dart';
import 'package:grhsolutions/dio/dio.dart';
import 'package:grhsolutions/models/contrato/contrato.dart';

class ContractService {
  final http = Http();
  final String baseEndpoint = "/contract"; // ajusta según tu API

  /// Obtener todos los contratos sin paginación
  Future<List<Contract>> getContracts() async {
    try {
      final response = await http.get('$baseEndpoint/getAll');
      final List data = response.data as List;
      return data
          .map((e) => Contract.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw Exception(
          e.response?.data['message'] ?? 'Error al obtener contratos');
    }
  }

  /// Obtener un contrato por ID
  Future<Contract> getContractById(String id) async {
    try {
      final response = await http.get('$baseEndpoint/$id');
      return Contract.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(
          e.response?.data['message'] ?? 'Error al obtener el contrato');
    }
  }

  /// Crear un contrato
//   Future<Contract> createContract(Map<String, dynamic> body) async {
//     try {
//       final response = await http.post('$baseEndpoint', data: body);
//       return Contract.fromJson(response.data);
//     } on DioException catch (e) {
//       throw Exception(
//           e.response?.data['message'] ?? 'Error al crear el contrato');
//     }
//   }

//   /// Actualizar un contrato
//   Future<Contract> updateContract(String id, Map<String, dynamic> body) async {
//     try {
//       final response = await http.put('$baseEndpoint/$id', data: body);
//       return Contract.fromJson(response.data);
//     } on DioException catch (e) {
//       throw Exception(
//           e.response?.data['message'] ?? 'Error al actualizar el contrato');
//     }
//   }

//   /// Eliminar un contrato
//   Future<void> deleteContract(String id) async {
//     try {
//       await http.delete('$baseEndpoint/$id');
//     } on DioException catch (e) {
//       throw Exception(
//           e.response?.data['message'] ?? 'Error al eliminar el contrato');
//     }
//   }
}
