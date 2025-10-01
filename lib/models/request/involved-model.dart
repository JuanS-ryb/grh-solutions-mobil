// involved-model.dart
class InvolvedItem {
  final String id;
  final String profileName;
  final String? assignedByName;
  final String role;

  InvolvedItem({
    required this.id,
    required this.profileName,
    this.assignedByName,
    required this.role,
  });

  factory InvolvedItem.fromJson(Map<String, dynamic> json) {
    return InvolvedItem(
      id: json['_id'] ?? '',
      profileName: json['profileId'] != null
          ? "${json['profileId']['name']} ${json['profileId']['lastname']}"
          : 'Desconocido',
      assignedByName: json['assignedBy'] != null
          ? "${json['assignedBy']['name']} ${json['assignedBy']['lastname']}"
          : null,
      role: json['role'] ?? 'Sin rol',
    );
  }
}
