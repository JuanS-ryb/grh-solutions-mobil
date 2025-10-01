import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';

class DownloadCertificadoButton extends StatelessWidget {
  final String id;
  final String apiUrl; // ejemplo: "http://tu-api.com/certificado"

  const DownloadCertificadoButton({
    Key? key,
    required this.id,
    required this.apiUrl,
  }) : super(key: key);

  Future<void> _downloadPdf(BuildContext context) async {
    try {
      // Elegir carpeta donde guardar
      String? selectedDirectory = await FilePicker.platform.getDirectoryPath();
      if (selectedDirectory == null) {
        // usuario canceló
        return;
      }

      final filePath = "$selectedDirectory/certificado_$id.pdf";

      final dio = Dio();
      final response = await dio.get(
        "$apiUrl?id=$id",
        options: Options(
          responseType: ResponseType.bytes,
        ),
      );

      final file = File(filePath);
      await file.writeAsBytes(response.data);

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("PDF guardado en:\n$filePath")),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error al descargar: $e")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return ElevatedButton.icon(
      icon: const Icon(Icons.download),
      label: Text("Descargar certificado", style: TextStyle(color: theme.textTheme.bodyLarge?.color),),
      onPressed: () => _downloadPdf(context),
    );
  }
}