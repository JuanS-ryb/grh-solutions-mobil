import 'package:flutter/material.dart';
import 'package:grhsolutions/models/request/request-models.dart';

class RequestDoc extends StatelessWidget {
  final RequestItem request;

  const RequestDoc({Key? key, required this.request, required documentos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final documentos = request.file ?? []; // 🔹 Lista real desde backend

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.colorScheme.background,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: theme.colorScheme.onBackground),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Documentos",
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onBackground,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          margin: const EdgeInsets.all(8),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: documentos.isEmpty
                ? Center(
                    child: Text(
                      "No hay documentos asociados",
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.hintColor,
                      ),
                    ),
                  )
                : ListView.separated(
                    itemCount: documentos.length,
                    separatorBuilder: (_, __) => const Divider(),
                    itemBuilder: (context, index) {
                      final doc = documentos[index];
                      return ListTile(
                        leading: Icon(Icons.insert_drive_file,
                            color: theme.colorScheme.primary),
                        title: Text(
                          doc.name,
                          style: theme.textTheme.bodyMedium,
                        ),
                        subtitle: Text(
                          "${doc.type} • ${(doc.size / 1024).toStringAsFixed(1)} KB",
                          style: theme.textTheme.bodySmall,
                        ),
                      );
                    },
                  ),
          ),
        ),
      ),
    );
  }
}
