class User {
  final String name;
  final String email;

  User({required this.name, required this.email});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'] ?? '',
      email: json['email'] ?? '',
    );
  }
}

class News {
  final String id;
  final String title;
  final String description;
  final DateTime date;
  final User madeBy;

  News({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.madeBy,
  });

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      id: json['_id'],
      title: json['title'],
      description: json['description'] ?? '',
      date: DateTime.parse(json['date']),
      madeBy: User.fromJson(json['madeBy']),
    );
  }
}

class PaginatedNews {
  final List<News> items;
  final int currentPage;
  final int totalPages;

  PaginatedNews({
    required this.items,
    required this.currentPage,
    required this.totalPages,
  });

  factory PaginatedNews.fromJson(Map<String, dynamic> json) {
    return PaginatedNews(
      items: (json['items'] as List)
          .map((item) => News.fromJson(item))
          .toList(),
      currentPage: json['currentPage'],
      totalPages: json['totalPages'],
    );
  }
}
