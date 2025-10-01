import 'package:flutter/material.dart';
import '../../models/news/news-models.dart';
import 'expandable_text.dart';

class NewsCardSimple extends StatelessWidget {
  final News news;

  const NewsCardSimple({Key? key, required this.news}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔹 Usuario + fecha
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  backgroundColor: Colors.grey,
                  child: Icon(Icons.person, color: Colors.white),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        news.madeBy.email,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "${news.createdAt.day}/${news.createdAt.month}/${news.createdAt.year} "
                            "- ${news.createdAt.hour.toString().padLeft(2, '0')}:${news.createdAt.minute.toString().padLeft(2, '0')}",
                        style: const TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // 🔹 Título
            Text(
              news.title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),

            // 🔹 Descripción (con paginación interna)
            ExpandableText(text: news.description),

            const SizedBox(height: 10),

            // 🔹 Footer
            Row(
              children: [
                const Icon(Icons.comment_outlined, size: 20),
                const SizedBox(width: 4),
                Text("0"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
