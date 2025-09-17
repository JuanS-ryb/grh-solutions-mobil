import 'package:dio/dio.dart';
import 'package:grhsolutions/dio/dio.dart';
import '../../models/user/login-model.dart';

class LoginService {
  final http = Http();
  final String baseEndpoint = "/news";
  Future<PaginatedNews> getNews({required int page, int limit = 10}) async {
    final response = await http.get(Uri.parse("$baseUrl?page=$page&limit=$limit"));

    if (response.statusCode == 200) {
      return PaginatedNews.fromJson(json.decode(response.body));
    } else {
      throw Exception("Error al cargar noticias");
    }
  }
}
