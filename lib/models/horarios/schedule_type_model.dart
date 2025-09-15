class ScheduleType {
  final String id;
  final String name;
  final String startTime;
  final String endTime;
  final DateTime createdAt;
  final DateTime updatedAt;

  ScheduleType({
    required this.id,
    required this.name,
    required this.startTime,
    required this.endTime,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ScheduleType.fromJson(Map<String, dynamic> json) {
    return ScheduleType(
      id: json['_id'],
      name: json['name'],
      startTime: json['startTime'],
      endTime: json['endTime'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'startTime': startTime,
        'endTime': endTime,
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
      };
}
