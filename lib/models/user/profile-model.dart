
class UserModel {
  final String id;
  final String user;
  final String name;
  final String lastname;
  final DateTime dateOfBirth;
  final String email;
  final String? address;
  final String? numberPhone;
  final String rh;
  final String status;
  final String typeDocument;
  final String document;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  UserModel({
    required this.id,
    required this.user,
    required this.name,
    required this.lastname,
    required this.dateOfBirth,
    required this.email,
    this.address,
    this.numberPhone,
    required this.rh,
    required this.status,
    required this.typeDocument,
    required this.document,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'],
      user: json['user'],
      name: json['name'],
      lastname: json['lastname'],
      dateOfBirth: DateTime.parse(json['date_of_birth']),
      email: json['email'],
      address: json['address'],
      numberPhone: json['number_phone'],
      rh: json['rh'],
      status: json['status'],
      typeDocument: json['type_document'],
      document: json['document'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      v: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'user': user,
      'name': name,
      'lastname': lastname,
      'date_of_birth': dateOfBirth.toIso8601String(),
      'email': email,
      'address': address,
      'number_phone': numberPhone,
      'rh': rh,
      'status': status,
      'type_document': typeDocument,
      'document': document,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      '__v': v,
    };
  }
}

