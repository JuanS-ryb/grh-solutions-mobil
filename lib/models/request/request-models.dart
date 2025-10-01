class DragNDrop {
  final String id;
  final String name;
  final String type;
  final int size;
  final String base64;

  DragNDrop({
    required this.id,
    required this.name,
    required this.type,
    required this.size,
    required this.base64,
  });

  factory DragNDrop.fromJson(Map<String, dynamic> json) {
    return DragNDrop(
      id: json['id']?.toString() ?? '',
      name: json['name'] ?? '',
      type: json['type'] ?? '',
      size: json['size'] is int
          ? json['size']
          : int.tryParse(json['size']?.toString() ?? '0') ?? 0,
      base64: json['base64'] ?? '',
    );
  }
}

class RequestItem {
  final String id; // ID de la solicitud
  final String createdBy; // ID del usuario que creó la solicitud
  final String title;
  final String status;
  final String typeRequest;
  final String? infoDx;
  final List<DragNDrop> file;
  final DateTime createdAt;
  final DateTime updatedAt;

  RequestItem({
    required this.id,
    required this.createdBy,
    required this.title,
    required this.status,
    required this.typeRequest,
    this.infoDx,
    required this.file,
    required this.createdAt,
    required this.updatedAt,
  });

  factory RequestItem.fromJson(Map<String, dynamic> json) {
    final id = json['_id']?.toString() ?? '';

    List<DragNDrop> fileList = [];
    if (json['file'] != null && json['file'] is List) {
      fileList = (json['file'] as List)
          .map((e) => DragNDrop.fromJson(Map<String, dynamic>.from(e)))
          .toList();
    }

    String createdById = '';
    if (json['createdBy'] != null) {
      if (json['createdBy'] is Map) {
        createdById = json['createdBy']['_id']?.toString() ?? '';
      } else {
        createdById = json['createdBy']?.toString() ?? '';
      }
    }

    return RequestItem(
      id: id,
      createdBy: createdById,
      title: json['title'] ?? '',
      status: json['status']?.toString().toLowerCase() ?? 'pendiente',
      typeRequest: json['type_request'] ?? '',
      infoDx: json['infoDx'],
      file: fileList,
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now(),
    );
  }
}


