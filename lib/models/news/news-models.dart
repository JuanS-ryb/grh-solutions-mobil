class News {
  final String id;
  final String title;
  final String description;
  final String type;
  final List<DataImages> images;
  final int numberLikes;
  final int numberDisLikes;
  final DateTime createdAt; // 👈 ahora es DateTime
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
      id: json["_id"],
      title: json["title"],
      description: json["description"] ?? "",
      type: json["type"],
      images: (json["images"] as List<dynamic>? ?? [])
          .map((e) => DataImages.fromJson(e as Map<String, dynamic>))
          .toList(),
      numberLikes: json["numberLikes"] ?? 0,
      numberDisLikes: json["numberDisLikes"] ?? 0,
      createdAt: DateTime.parse(json["createdAt"]), // 👈 conversión aquí
      madeBy: User.fromJson(json["madeBy"]),
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
      id: json["_id"],
      email: json["email"],
    );
  }
}

class PaginatedNews {
  final List<News> data;
  final int totalPages;

  PaginatedNews({required this.data, required this.totalPages});

  factory PaginatedNews.fromJson(Map<String, dynamic> json) {
    return PaginatedNews(
      data: (json["data"] as List).map((e) => News.fromJson(e)).toList(),
      totalPages: json["totalPages"],
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
      id: json["_id"],
      name: json["name"],
      type: json["type"],
      size: json["size"],
      base64: json["base64"],
    );
  }
}
