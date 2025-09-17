class News {
  final String id;
  final String title;
  final String description;
  final String type;
  final int numberLikes;
  final int numberDisLikes;
  final DateTime createdAt; // 👈 ahora es DateTime
  final User madeBy;

  News({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.numberLikes,
    required this.numberDisLikes,
    required this.createdAt,
    required this.madeBy,
  });

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      id: json["_id"],
      title: json["title"],
      description: json["description"] ?? "",
      type: json["type"],
      numberLikes: json["numberLikes"] ?? 0,
      numberDisLikes: json["numberDisLikes"] ?? 0,
      createdAt: DateTime.parse(json["createdAt"]), // 👈 conversión aquí
      madeBy: User.fromJson(json["madeBy"]),
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
