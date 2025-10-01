import 'dart:convert';

import '../../dio/dio.dart';
import '../../models/news/news-models.dart';

class NewsService {
  final http = Http();
  final String baseEndpoint = "/news";
  Future<PaginatedNews> getNews({required int page, int limit = 10}) async {
    final Map<String, dynamic> queryParams = {
      "page": page, "limit": limit
    };
    final response = await http.get('$baseEndpoint/', queryParameters: queryParams);

    if (response.statusCode == 200) {
      return PaginatedNews.fromJson(response.data);
    } else {
      throw Exception("Error al cargar noticias");
    }
  }
}
