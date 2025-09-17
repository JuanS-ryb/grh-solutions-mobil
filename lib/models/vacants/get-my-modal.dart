class GetMyVacants {
  final List<Application> applications;

  GetMyVacants({required this.applications});

  factory GetMyVacants.fromJson(List<dynamic> json) {
    return GetMyVacants(
      applications: json.map((item) => Application.fromJson(item)).toList(),
    );
  }

  List<Map<String, dynamic>> toJson() {
    return applications.map((a) => a.toJson()).toList();
  }
}

class Application {
  final String id;
  final User user;
  final Vacant vacant;
  final String applicationDate;
  final String status;
  final int v;

  Application({
    required this.id,
    required this.user,
    required this.vacant,
    required this.applicationDate,
    required this.status,
    required this.v,
  });

  factory Application.fromJson(Map<String, dynamic> json) {
    return Application(
      id: json["_id"] ?? "",
      user: User.fromJson(json["user"] ?? {}),
      vacant: Vacant.fromJson(json["vacante"] ?? {}),
      applicationDate: json["application_date"] ?? "",
      status: json["status"] ?? "",
      v: json["__v"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "user": user.toJson(),
      "vacante": vacant.toJson(),
      "application_date": applicationDate,
      "status": status,
      "__v": v,
    };
  }
}

class User {
  final String id;
  final String email;
  final String rol;
  final bool isActive;
  final String createdAt;
  final String updatedAt;

  User({
    required this.id,
    required this.email,
    required this.rol,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["_id"] ?? "",
      email: json["email"] ?? "",
      rol: json["rol"] ?? "",
      isActive: json["isActive"] ?? false,
      createdAt: json["createdAt"] ?? "",
      updatedAt: json["updatedAt"] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "email": email,
      "rol": rol,
      "isActive": isActive,
      "createdAt": createdAt,
      "updatedAt": updatedAt,
    };
  }
}

class Vacant {
  final String id;
  final String tittle;
  final String description;
  final String typeContract;
  final String salary;
  final String horary;
  final String charge;
  final String area;
  final String address;
  final String telephone;
  final String email;
  final String typeModality;
  final String experience;
  final String formation;
  final String status;
  final String createdAt;
  final String updatedAt;
  final int v;

  Vacant({
    required this.id,
    required this.tittle,
    required this.description,
    required this.typeContract,
    required this.salary,
    required this.horary,
    required this.charge,
    required this.area,
    required this.address,
    required this.telephone,
    required this.email,
    required this.typeModality,
    required this.experience,
    required this.formation,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Vacant.fromJson(Map<String, dynamic> json) {
    return Vacant(
      id: json["_id"] ?? "",
      tittle: json["tittle"] ?? "",
      description: json["description"] ?? "",
      typeContract: json["type_contract"] ?? "",
      salary: json["salary"] ?? "",
      horary: json["horary"] ?? "",
      charge: json["charge"] ?? "",
      area: json["area"] ?? "",
      address: json["address"] ?? "",
      telephone: json["telephone"] ?? "",
      email: json["email"] ?? "",
      typeModality: json["type_modality"] ?? "",
      experience: json["experience"] ?? "",
      formation: json["formation"] ?? "",
      status: json["status"] ?? "",
      createdAt: json["createdAt"] ?? "",
      updatedAt: json["updatedAt"] ?? "",
      v: json["__v"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "tittle": tittle,
      "description": description,
      "type_contract": typeContract,
      "salary": salary,
      "horary": horary,
      "charge": charge,
      "area": area,
      "address": address,
      "telephone": telephone,
      "email": email,
      "type_modality": typeModality,
      "experience": experience,
      "formation": formation,
      "status": status,
      "createdAt": createdAt,
      "updatedAt": updatedAt,
      "__v": v,
    };
  }
}
