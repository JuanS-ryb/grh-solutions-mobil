class VacantsResponseModel {
  final List<Vacants> vacants;

  VacantsResponseModel({required this.vacants});

  factory VacantsResponseModel.fromJson(List<dynamic> json) {
    return VacantsResponseModel(
      vacants: json.map((item) => Vacants.fromJson(item)).toList(),
    );
  }

  List<Map<String, dynamic>> toJson() {
    return vacants.map((v) => v.toJson()).toList();
  }
}

class Vacants {
  final String id;
  final String tittle;
  final String description;
  final String typeContract;
  final String salary;
  final String horary;
  final Charge charge;
  final Area area;
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

  Vacants({
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

  factory Vacants.fromJson(Map<String, dynamic> json) {
    return Vacants(
      id: json["_id"] ?? "",
      tittle: json["tittle"] ?? "",
      description: json["description"] ?? "",
      typeContract: json["type_contract"] ?? "",
      salary: json["salary"] ?? "",
      horary: json["horary"] ?? "",
      charge: Charge.fromJson(json["charge"] ?? {}),
      area: Area.fromJson(json["area"] ?? {}),
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
      "charge": charge.toJson(),
      "area": area.toJson(),
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

class Charge {
  final String id;
  final String name;
  final String createdAt;
  final String updatedAt;
  final int v;

  Charge({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Charge.fromJson(Map<String, dynamic> json) {
    return Charge(
      id: json["_id"] ?? "",
      name: json["name"] ?? "",
      createdAt: json["createdAt"] ?? "",
      updatedAt: json["updatedAt"] ?? "",
      v: json["__v"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "name": name,
      "createdAt": createdAt,
      "updatedAt": updatedAt,
      "__v": v,
    };
  }
}

class Area {
  final String id;
  final String name;
  final String createdAt;
  final String updatedAt;
  final int v;

  Area({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Area.fromJson(Map<String, dynamic> json) {
    return Area(
      id: json["_id"] ?? "",
      name: json["name"] ?? "",
      createdAt: json["createdAt"] ?? "",
      updatedAt: json["updatedAt"] ?? "",
      v: json["__v"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "name": name,
      "createdAt": createdAt,
      "updatedAt": updatedAt,
      "__v": v,
    };
  }
}
