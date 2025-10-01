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
      dateOfBirth: DateTime.tryParse(json['date_of_birth'] ?? '') ?? DateTime.now(),
      email: json['email'] ?? '',
      address: json['address'] ?? '',
      numberPhone: int.tryParse(json['number_phone']?.toString() ?? '0') ?? 0,
      rh: json['rh'] ?? '',
      status: json['status'] ?? '',
      typeDocument: json['type_document'] ?? '',
      document: json['document'] ?? '',
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now(),
      telephone: int.tryParse(json['telephone']?.toString() ?? '0') ?? 0,
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
    // Si profileId viene como String, crea un Profile con datos mínimos
    Profile profile;
    if (json['profileId'] is Map<String, dynamic>) {
      profile = Profile.fromJson(json['profileId']);
    } else {
      profile = Profile(
        id: json['profileId'] ?? '',
        user: '',
        name: '',
        lastname: '',
        dateOfBirth: DateTime.now(),
        email: '',
        address: '',
        numberPhone: 0,
        rh: '',
        status: '',
        typeDocument: '',
        document: '',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        telephone: 0,
      );
    }

    return HistoryItem(
      id: json['_id'] ?? '',
      requestId: json['requestId'] ?? '',
      profile: profile,
      description: json['description'] ?? '',
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
    );
  }
}
