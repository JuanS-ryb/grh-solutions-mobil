import 'package:dio/dio.dart';
import 'package:grhsolutions/dio/dio.dart';
import 'package:grhsolutions/models/contrato/contrato.dart';

class ContractService {
  final http = Http();
  final String baseEndpoint = "/contract"; // ajusta según tu API

  Future<List<Contract>> getContracts() async {
    try {
      final response = await http.get('$baseEndpoint/getAll');
      final List data = response.data as List;
      return data
          .map((e) => Contract.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      final msg = e.response?.data['message']?.toString() ??
          'Error al obtener contratos';
      throw Exception(msg);
    }
  }

  /// Obtener un contrato por ID
  Future<Contract> getContractById(String id) async {
    try {
      final response = await http.get('$baseEndpoint/getById?id=$id');
      return Contract.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(
          e.response?.data['message'] ?? 'Error al obtener el contrato');
    }
  }
}
