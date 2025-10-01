import 'request-models.dart'; // Para DragNDrop

class Profile {
  final String id;
  final String userId;
  final String name;
  final String lastname;
  final DateTime dateOfBirth;
  final String email;
  final String? address;
  final int? numberPhone;
  final int? telephone;
  final String rh;
  final String status;
  final String typeDocumentId;
  final String document;
  final DragNDrop? signature;
  final DateTime createdAt;
  final DateTime updatedAt;

  Profile({
    required this.id,
    required this.userId,
    required this.name,
    required this.lastname,
    required this.dateOfBirth,
    required this.email,
    this.address,
    this.numberPhone,
    this.telephone,
    required this.rh,
    required this.status,
    required this.typeDocumentId,
    required this.document,
    this.signature,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: json['_id']?.toString() ?? '',
      userId: json['user']?['_id']?.toString() ?? json['user']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      lastname: json['lastname']?.toString() ?? '',
      dateOfBirth: DateTime.tryParse(json['date_of_birth']?.toString() ?? '') ?? DateTime.now(),
      email: json['email']?.toString() ?? '',
      address: json['address']?.toString(),
      numberPhone: json['number_phone'] != null
          ? int.tryParse(json['number_phone'].toString())
          : null,
      telephone: json['telephone'] != null
          ? int.tryParse(json['telephone'].toString())
          : null,
      rh: json['rh']?.toString() ?? '',
      status: json['status']?.toString() ?? '',
      typeDocumentId: json['type_document']?['_id']?.toString() ??
          json['type_document']?.toString() ??
          '',
      document: json['document']?.toString() ?? '',
      signature: json['signature'] != null && json['signature'] is Map
          ? DragNDrop.fromJson(Map<String, dynamic>.from(json['signature']))
          : null,
      createdAt: DateTime.tryParse(json['createdAt']?.toString() ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt']?.toString() ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'user': userId,
      'name': name,
      'lastname': lastname,
      'date_of_birth': dateOfBirth.toIso8601String(),
      'email': email,
      'address': address,
      'number_phone': numberPhone,
      'telephone': telephone,
      'rh': rh,
      'status': status,
      'type_document': typeDocumentId,
      'document': document,
      'signature': signature?.toJson(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}

extension on DragNDrop? {
  toJson() {}
}
