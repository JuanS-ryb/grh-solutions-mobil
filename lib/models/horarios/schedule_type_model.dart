class ScheduleType {
  final String id;
  final String name;
  final String startTime;
  final String endTime;
  final String createdAt;
  final String updatedAt;
  final int v;

  ScheduleType({
    required this.id,
    required this.name,
    required this.startTime,
    required this.endTime,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory ScheduleType.fromJson(Map<String, dynamic> json) {
     print('ScheduleType JSON: $json');
    return ScheduleType(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      startTime: json['startTime'] ?? '',
      endTime: json['endTime'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
v: int.tryParse(json['__v']?.toString() ?? '0') ?? 0, 
    );
  }

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'startTime': startTime,
        'endTime': endTime,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
        '__v': v,
      };
}
