import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import '../../models/news/news-models.dart';
import 'expandable_text.dart';

class NewsCardImages extends StatelessWidget {
  final News news;

  const NewsCardImages({Key? key, required this.news}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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

            // 🔹 Descripción
            ExpandableText(text: news.description),

            const SizedBox(height: 10),

            // 🔹 Cuadrícula de imágenes
            if (news.images.isNotEmpty)
              _ImageGrid(images: news.images),

            const SizedBox(height: 10),

            // 🔹 Footer con comentarios
            Row(
              children: [
                const Icon(Icons.comment_outlined, size: 20),
                const SizedBox(width: 4),
                Text("${news.comms}"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// 🔹 Cuadrícula de imágenes (similar a ImageGrid de React)
class _ImageGrid extends StatelessWidget {
  final List<DataImages> images;

  const _ImageGrid({required this.images});

  Uint8List? _decodeBase64Image(String base64String) {
    try {
      // Remover encabezado MIME si existe
      final regex = RegExp(r'data:image/[^;]+;base64,');
      base64String = base64String.replaceAll(regex, '');

      // Limpiar espacios/saltos de línea
      base64String = base64String.replaceAll(RegExp(r'\s+'), '');

      return base64Decode(base64String);
    } catch (e) {
      print('Error decoding base64: $e');
      return null;
    }
  }
  @override
  Widget build(BuildContext context) {
    int count = images.length.clamp(1, 4); // máximo 4 visibles
    double spacing = 4;

    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: count,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: count == 1 ? 1 : 2,
          mainAxisSpacing: spacing,
          crossAxisSpacing: spacing,
        ),
        itemBuilder: (context, index) {
          final imageBytes = _decodeBase64Image(images[index].base64);

          if (imageBytes == null) {
            // Si hay error al decodificar, mostrar un contenedor con icono de error
            return Container(
              color: Colors.grey[300],
              child: const Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.broken_image,
                      color: Colors.grey,
                      size: 40,
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Error',
                      style: TextStyle(fontSize: 10, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            );
          }

          return Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
            ),
            child: Image.memory(
              imageBytes,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                print('Error loading image: $error');
                return Container(
                  color: Colors.grey[300],
                  child: const Center(
                    child: Icon(
                      Icons.image_not_supported,
                      color: Colors.grey,
                      size: 40,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
