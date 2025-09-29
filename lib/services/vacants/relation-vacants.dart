import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:grhsolutions/dio/dio.dart';
import '../../models/vacants/response-moddel.dart';

class RelarionsVacanstService {
  final http = Http();

  Future<PostulateResponse> createPostulate(String vacanteId, String status) async {
    const String baseEndpoint = "/postulante/create/";
    try {
      final response = await http.post(
        baseEndpoint,
        data: {"vacante": vacanteId, "status": status},
      );

      return PostulateResponse.fromJson(response.data);
    } on DioException catch (e) {
      debugPrint(e.response?.data['message']);
      throw Exception(
        e.response?.data['message'] ?? 'Error al postularse a la vacante',
      );
    }
  }
}
