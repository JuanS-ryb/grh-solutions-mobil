import 'group_model.dart';
import 'schedule_type_model.dart';

class Schedule {
  final String id;
  final DateTime startDate;
  final DateTime endDate;
  final Group group;
  final ScheduleType scheduleType;
  final DateTime createdAt;
  final DateTime updatedAt;

  Schedule({
    required this.id,
    required this.startDate,
    required this.endDate,
    required this.group,
    required this.scheduleType,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
      id: json['_id'],
      startDate: DateTime.parse(json['start_date']),
      endDate: DateTime.parse(json['end_date']),
      group: Group.fromJson(json['group']),
      scheduleType: ScheduleType.fromJson(json['scheduleType']),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() => {
        '_id': id,
        'start_date': startDate.toIso8601String(),
        'end_date': endDate.toIso8601String(),
        'group': group.toJson(),
        'scheduleType': scheduleType.toJson(),
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
      };
}
