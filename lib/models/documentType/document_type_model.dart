class DocumentType {
  final String id;
  final String name;

  DocumentType({
    required this.id,
    required this.name,
  });

  factory DocumentType.fromJson(Map<String, dynamic> json) {
    return DocumentType(
      id: json['_id'] as String,
      name: json['name'] as String,
    );
  }
}