import 'package:dio/dio.dart';
import 'package:grhsolutions/dio/dio.dart';
import '../../models/user/profile-model.dart';
import '../../data/notifiers.dart';
import '../../models/user/cv-model.dart';

class ProfileService {
  final http = Http();
  final String profileBase = "/profiles";
  final String cvBase = "/cv";

  Future<ProfileModel> getMyProfile() async {
    if (loginController.value == null) {
      throw Exception('No hay usuario logueado');
    }

    try {
      final response = await http.get(
        '$profileBase/getById',
        queryParameters: {
          'id': loginController.value!.user.profile,
        },
      );

      return ProfileModel.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(
        e.response?.data['message'] ?? 'Error al obtener perfil',
      );
    }
  }

  Future<CV> getMyCV() async {
    if (loginController.value == null) {
      throw Exception('No hay usuario logueado');
    }

    try {
      final response = await http.get(
        '$cvBase/getMyCv',
        queryParameters: {
          'id': loginController.value!.user.profile,
        },
      );

      return CV.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(
        e.response?.data['message'] ?? 'Error al obtener perfil',
      );
    }
  }
}
