import 'package:flutter/material.dart';
import '../../../models/user/profile-model.dart';
import 'download-b.dart';

class MiCertificadosScreen extends StatelessWidget {
  final ProfileModel? profile;

  const MiCertificadosScreen({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Center(
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        margin: const EdgeInsets.all(16),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Descarga tu certificado laboral",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: theme.textTheme.bodyLarge?.color,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                "Haz clic en el botón para descargar tu certificado laboral en formato PDF.",
                style: TextStyle(
                    fontSize: 14,
                    color: theme.textTheme.bodyLarge?.color),
                textAlign: TextAlign.center,

              ),
              const SizedBox(height: 20),
              DownloadCertificadoButton(
                id: profile!.id,
                apiUrl: "http://localhost:3000/api/profiles/lab-cert",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
