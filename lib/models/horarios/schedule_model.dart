import 'package:grhsolutions/models/horarios/group_model.dart';
import 'package:grhsolutions/models/horarios/schedule_type_model.dart';

class Schedule {
  final String id;
  final String startDate;
  final String endDate;
  final ScheduleGroup? group;
  final ScheduleType? scheduleType;
  final String createdAt;
  final String updatedAt;
  final int v;

  Schedule({
    required this.id,
    required this.startDate,
    required this.endDate,
    this.group,
    this.scheduleType,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) {
      print('Schedule JSON recibido -> $json');
    return Schedule(
      id: json['_id'] ?? '',
      startDate: json['start_date'] ?? '',
      endDate: json['end_date'] ?? '',
      group: json['group'] != null
          ? ScheduleGroup.fromJson(json['group'])
          : null,
      scheduleType: json['scheduleType'] != null
          ? ScheduleType.fromJson(json['scheduleType'])
          : null,
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      v: int.tryParse(json['__v']?.toString() ?? '0') ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        '_id': id,
        'start_date': startDate,
        'end_date': endDate,
        'group': group?.toJson(),
        'scheduleType': scheduleType?.toJson(),
        'createdAt': createdAt,
        'updatedAt': updatedAt,
        '__v': v,
      };
}

