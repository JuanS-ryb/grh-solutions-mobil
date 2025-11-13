import '../../dio/dio.dart';
import '../../models/news/news-models.dart';

class NewsService {
  final http = Http();
  final String baseEndpoint = "/news";
  Future<PaginatedNews> getNews({required int page, int limit = 10}) async {
    try{
      final Map<String, dynamic> queryParams = {
        "page": page, "limit": limit, "_ts": DateTime.now().millisecondsSinceEpoch
      };
      final response = await http.get('$baseEndpoint/', queryParameters: queryParams);

      return PaginatedNews.fromJson(response.data);
    } catch(e) {
      throw Exception("Error al cargar noticias: $e");
    }
  }
}
