class Contract {
  final String id;
  final String tittle;
  final String description;
  final String content;
  final String? typeContract;
  final String status;
  final bool signatures;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<Employee>? employees;

  Contract({
    required this.id,
    required this.tittle,
    required this.description,
    required this.content,
    this.typeContract,
    required this.status,
    required this.signatures,
    required this.createdAt,
    required this.updatedAt,
    this.employees,
  });

  factory Contract.fromJson(Map<String, dynamic> json) {
    return Contract(
      id: json["_id"],
      tittle: json["tittle"] ?? "", // ⚠️ ojo que tu JSON usa "tittle"
      description: json["description"] ?? "",
      content: json["content"] ?? "",
      typeContract: json["type_contract"],
      status: json["status"] ?? "",
      signatures: json["signatures"] ?? false,
      createdAt: DateTime.parse(json["createdAt"]),
      updatedAt: DateTime.parse(json["updatedAt"]),
      employees: json["empleados"] != null
          ? (json["empleados"] as List)
              .map((e) => Employee.fromJson(e))
              .toList()
          : null,
    );
  }
}

class Employee {
  final String id;
  final String name;

  Employee({required this.id, required this.name});

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      id: json["_id"],
      name: json["name"] ?? "",
    );
  }
}

class PaginatedContracts {
  final List<Contract> data;
  final int totalPages;

  PaginatedContracts({required this.data, required this.totalPages});

  factory PaginatedContracts.fromJson(Map<String, dynamic> json) {
    return PaginatedContracts(
      data: (json["data"] as List).map((e) => Contract.fromJson(e)).toList(),
      totalPages: json["totalPages"] ?? 1,
    );
  }
}
