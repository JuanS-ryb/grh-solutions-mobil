import 'package:flutter/material.dart';

import '../../models/news/news-models.dart';
import '../../services/news/news-services.dart';
import 'news_card.dart';

class Comunicados extends StatefulWidget {
  const Comunicados({Key? key}) : super(key: key);

  @override
  State<Comunicados> createState() => _ComunicadosState();
}

class _ComunicadosState extends State<Comunicados> {
  final NewsService _service = NewsService();

  List<News> _news = [];
  int _page = 1;
  bool _isLoading = false;
  bool _hasMore = true;
  int _totalPages = 1;

  @override
  void initState() {
    super.initState();
    _loadNews();
  }

  Future<void> _loadNews() async {
    if (_isLoading || !_hasMore) return;

    setState(() => _isLoading = true);

    try {
      final result = await _service.getNews(page: _page, limit: 10);

      setState(() {
        _news.addAll(result.data);
        _totalPages = result.totalPages;
        _page++;
        if (_page > _totalPages) {
          _hasMore = false;
        }
      });
    } catch (e) {
      print("Error al cargar noticias: $e");
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Noticias")),
      body: ListView.builder(
        itemCount: _news.length + 1,
        itemBuilder: (context, index) {
          if (index < _news.length) {
            return NewsCard(news: _news[index]);
          } else {
            if (_isLoading) {
              return const Padding(
                padding: EdgeInsets.all(16),
                child: Center(child: CircularProgressIndicator()),
              );
            } else if (_hasMore) {
              return Padding(
                padding: const EdgeInsets.all(16),
                child: Center(
                  child: ElevatedButton(
                    onPressed: _loadNews,
                    child: const Text("Cargar más"),
                  ),
                ),
              );
            } else {
              return const SizedBox.shrink();
            }
          }
        },
      ),
    );
  }
}
