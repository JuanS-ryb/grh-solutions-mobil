class RequestItem {
  final String id;
  final String title;
  final String status;
  final String typeRequest;
  final String? infoDx;
  final DateTime createdAt;
  final DateTime updatedAt;

  RequestItem({
    required this.id,
    required this.title,
    required this.status,
    required this.typeRequest,
    this.infoDx,
    required this.createdAt,
    required this.updatedAt,
  });

  factory RequestItem.fromJson(Map<String, dynamic> json) {
    return RequestItem(
      id: json['_id'] ?? '',
      title: json['title'] ?? '',
      status: json['status'] ?? '',
      typeRequest: json['type_request'] ?? '',
      infoDx: json['infoDx'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}
