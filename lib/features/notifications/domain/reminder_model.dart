import 'package:hive/hive.dart';
part 'reminder_model.g.dart';

@HiveType(typeId: 0)
class ReminderModel extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String body;

  @HiveField(3)
  final DateTime remindAt;

  @HiveField(4)
  final DateTime appointmentTime;

  ReminderModel({
    required this.id,
    required this.title,
    required this.body,
    required this.remindAt,
    required this.appointmentTime,
  });
}
