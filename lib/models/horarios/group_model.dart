class ScheduleGroup {
  final String id;
  final String name;
  final List<String> users;
  final String area;
  final String createdAt;
  final String updatedAt;
  final int v;

  ScheduleGroup({
    required this.id,
    required this.name,
    required this.users,
    required this.area,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory ScheduleGroup.fromJson(Map<String, dynamic> json) {
     print('ScheduleGroup JSON: $json');
    return ScheduleGroup(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      users: (json['users'] as List?)?.map((e) => e.toString()).toList() ?? [],
      area: json['area'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
v: int.tryParse(json['__v']?.toString() ?? '0') ?? 0, 
    );
  }

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'users': users,
        'area': area,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
        '__v': v,
      };
}
