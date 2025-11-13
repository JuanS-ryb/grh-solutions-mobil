class News {
  final String id;
  final String title;
  final String description;
  final String type;
  final List<DataImages> images;
  final int numberLikes;
  final int numberDisLikes;
  final DateTime createdAt;
  final User madeBy;
  final int comms;

  News({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.images,
    required this.numberLikes,
    required this.numberDisLikes,
    required this.createdAt,
    required this.madeBy,
    required this.comms,
  });

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      id: json["_id"] ?? json["id"] ?? "",
      title: json["title"] ?? "",
      description: json["description"] ?? "",
      type: (json["type"] ?? "").toString(),
      images: (json["images"] as List? ?? [])
          .map((e) => DataImages.fromJson(e))
          .toList(),
      numberLikes: json["numberLikes"] ?? 0,
      numberDisLikes: json["numberDisLikes"] ?? 0,
      createdAt: DateTime.tryParse(json["createdAt"] ?? "") ?? DateTime.now(),
      madeBy: User.fromJson(json["madeBy"] ?? {}),
      comms: json["comms"] ?? 0,
    );
  }
}

class User {
  final String id;
  final String email;

  User({required this.id, required this.email});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["_id"] ?? json["id"] ?? "",
      email: json["email"] ?? "",
    );
  }
}

class DataImages {
  final String id;
  final String name;
  final String type;
  final int size;
  final String base64;

  DataImages({
    required this.id,
    required this.name,
    required this.type,
    required this.size,
    required this.base64,
  });

  factory DataImages.fromJson(Map<String, dynamic> json) {
    return DataImages(
      id: json["_id"] ?? json["id"] ?? "",
      name: json["name"] ?? "",
      type: json["type"] ?? "",
      size: json["size"] ?? 0,
      base64: json["base64"] ?? "",
    );
  }
}

class PaginatedNews {
  final List<News> data;
  final int totalPages;

  PaginatedNews({
    required this.data,
    required this.totalPages,
  });

  factory PaginatedNews.fromJson(dynamic json) {
    // Si el backend devuelve directamente una lista
    if (json is List) {
      return PaginatedNews(
        data: json.map((e) => News.fromJson(e)).toList(),
        totalPages: 1,
      );
    }

    // Si devuelve un objeto con "data" o "news"
    final list = json['data'] ?? json['news'] ?? [];

    return PaginatedNews(
      data: (list as List)
          .map((e) => News.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalPages: json['totalPages'] ?? 1,
    );
  }
}
