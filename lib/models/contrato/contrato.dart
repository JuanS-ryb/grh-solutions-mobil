class Contract {
  final String id;
  final Profile perfilCreador;
  final Profile perfilEmpleado;
  final String eps;
  final int estrato;
  final DateTime startDate;
  final DateTime? endDate;
  final TypeContract tipoContrato;
  final String arl;
  final String? firmaEmpleado;
  final String? firmaEmpleador;
  final String estado;
  final String title;
  final Vacancy vacante;
  final DateTime createdAt;
  final DateTime updatedAt;

  Contract({
    required this.id,
    required this.perfilCreador,
    required this.perfilEmpleado,
    required this.eps,
    required this.estrato,
    required this.startDate,
    this.endDate,
    required this.tipoContrato,
    required this.arl,
    this.firmaEmpleado,
    this.firmaEmpleador,
    required this.estado,
    required this.title,
    required this.vacante,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Contract.fromJson(Map<String, dynamic> json) {
    return Contract(
      id: json["_id"],
      perfilCreador: Profile.fromJson(json["perfil_creador"]),
      perfilEmpleado: Profile.fromJson(json["perfil_empleado"]),
      eps: json["eps"] ?? "",
      estrato: json["estrato"] ?? 0,
      startDate: DateTime.parse(json["start_date"]),
      endDate:
          json["end_date"] != null ? DateTime.parse(json["end_date"]) : null,
      tipoContrato: TypeContract.fromJson(json["tipo_contrato"]),
      arl: json["arl"] ?? "",
      firmaEmpleado: json["firma_empleado"]?.toString(),
      firmaEmpleador: json["firma_empleador"]?.toString(),
      estado: json["estado"] ?? "",
      title: json["title"] ?? "",
      vacante: Vacancy.fromJson(json["vacante"]),
      createdAt: DateTime.parse(json["createdAt"]),
      updatedAt: DateTime.parse(json["updatedAt"]),
    );
  }
}

class Profile {
  final String id;
  final String name;
  final String lastname;
  final DateTime dateOfBirth;
  final String email;
  final String? address;
  final int? numberPhone;
  final String document;

  Profile({
    required this.id,
    required this.name,
    required this.lastname,
    required this.dateOfBirth,
    required this.email,
    this.address,
    this.numberPhone,
    required this.document,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    int? numberPhone;
    try {
      numberPhone = json["number_phone"] != null
          ? int.tryParse(json["number_phone"].toString())
          : null;
    } catch (_) {
      numberPhone = null;
    }

    return Profile(
      id: json["_id"] ?? "",
      name: json["name"] ?? "",
      lastname: json["lastname"] ?? "",
      dateOfBirth:
          DateTime.tryParse(json["date_of_birth"] ?? "") ?? DateTime(2000),
      email: json["email"] ?? "",
      address: json["address"],
      numberPhone: numberPhone,
      document: json["document"] ?? "",
    );
  }

  String get fullName => "$name $lastname";
}

class TypeContract {
  final String id;
  final String name;
  final String description;
  final String content;

  TypeContract({
    required this.id,
    required this.name,
    required this.description,
    required this.content,
  });

  factory TypeContract.fromJson(Map<String, dynamic> json) {
    return TypeContract(
      id: json["_id"],
      name: json["name"] ?? "",
      description: json["description"] ?? "",
      content: json["content"] ?? "",
    );
  }
}

class Vacancy {
  final String id;
  final String tittle;
  final String description;
  final String salary;
  final String horary;
  final String address;
  final String telephone;
  final String email;

  Vacancy({
    required this.id,
    required this.tittle,
    required this.description,
    required this.salary,
    required this.horary,
    required this.address,
    required this.telephone,
    required this.email,
  });

  factory Vacancy.fromJson(Map<String, dynamic> json) {
    return Vacancy(
      id: json["_id"],
      tittle: json["tittle"] ?? "",
      description: json["description"] ?? "",
      salary: json["salary"] ?? "",
      horary: json["horary"] ?? "",
      address: json["address"] ?? "",
      telephone: json["telephone"] ?? "",
      email: json["email"] ?? "",
    );
  }
}
