class PostulateResponse {
  final String id;
  final String user;
  final String vacante;
  final String applicationDate;
  final String status;
  final int v;

  PostulateResponse({
    required this.id,
    required this.user,
    required this.vacante,
    required this.applicationDate,
    required this.status,
    required this.v,
  });

  factory PostulateResponse.fromJson(Map<String, dynamic> json) {
    return PostulateResponse(
      id: json["_id"] ?? "",
      user: json["user"] ?? "",
      vacante: json["vacante"] ?? "",
      applicationDate: json["application_date"] ?? "",
      status: json["status"] ?? "",
      v: json["__v"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "user": user,
      "vacante": vacante,
      "application_date": applicationDate,
      "status": status,
      "__v": v,
    };
  }
}
