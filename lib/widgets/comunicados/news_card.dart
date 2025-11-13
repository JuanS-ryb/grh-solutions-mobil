import 'package:flutter/material.dart';
import 'news_card_images.dart';
import '../../models/news/news-models.dart';
import 'news_card_simple.dart';

class NewsCard extends StatelessWidget {
  final News news;

  const NewsCard({Key? key, required this.news}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (news.type) {
      case "simple-publication":
        return NewsCardSimple(news: news);
      case "publication-with-images":
        // return NewsCardImages(news: news); // todavía no implementado
        return NewsCardImages(news: news);
      case "publication-with-survey":
      // return NewsCardSurvey(news: news); // todavía no implementado
        return const SizedBox.shrink();
      default:
        return const SizedBox.shrink();
    }
  }
}
