class RequestItem {
  final String id;
  final String estado;
  final String titulo;
  final DateTime createdAt;
  final DateTime updatedAt;

  RequestItem({
    required this.id,
    required this.estado,
    required this.titulo,
    required this.createdAt,
    required this.updatedAt,
  });

  factory RequestItem.fromJson(Map<String, dynamic> json) {
    return RequestItem(
      id: json['id'].toString(),
      estado: json['estado'] ?? '',
      titulo: json['titulo'] ?? '',
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now(),
    );
  }
}
