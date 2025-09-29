class Profile {
  final String id;
  final String user;
  final String name;
  final String lastname;
  final DateTime dateOfBirth;
  final String email;
  final String address;
  final int numberPhone;
  final String rh;
  final String status;
  final String typeDocument;
  final String document;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int telephone;

  Profile({
    required this.id,
    required this.user,
    required this.name,
    required this.lastname,
    required this.dateOfBirth,
    required this.email,
    required this.address,
    required this.numberPhone,
    required this.rh,
    required this.status,
    required this.typeDocument,
    required this.document,
    required this.createdAt,
    required this.updatedAt,
    required this.telephone,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: json['_id'] ?? '',
      user: json['user'] ?? '',
      name: json['name'] ?? '',
      lastname: json['lastname'] ?? '',
      dateOfBirth: DateTime.parse(json['date_of_birth'] ?? DateTime.now().toIso8601String()),
      email: json['email'] ?? '',
      address: json['address'] ?? '',
      numberPhone: json['number_phone'] ?? 0,
      rh: json['rh'] ?? '',
      status: json['status'] ?? '',
      typeDocument: json['type_document'] ?? '',
      document: json['document'] ?? '',
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(json['updatedAt'] ?? DateTime.now().toIso8601String()),
      telephone: json['telephone'] ?? 0,
    );
  }
}

class HistoryItem {
  final String id;
  final String requestId;
  final Profile profile;
  final String description;
  final DateTime createdAt;

  HistoryItem({
    required this.id,
    required this.requestId,
    required this.profile,
    required this.description,
    required this.createdAt,
  });

  factory HistoryItem.fromJson(Map<String, dynamic> json) {
    return HistoryItem(
      id: json['_id'] ?? '',
      requestId: json['requestId'] ?? '',
      profile: Profile.fromJson(json['profileId'] ?? {}),
      description: json['description'] ?? '',
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
    );
  }
}
