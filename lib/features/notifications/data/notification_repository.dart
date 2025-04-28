import 'package:hive/hive.dart';
import 'package:medilink/utils/exporter.dart';

class NotificationRepository {
  final String boxName = 'reminders_box';

  Future<void> addReminder(ReminderModel reminder) async {
    final box = await Hive.openBox<ReminderModel>(boxName);
    await box.put(reminder.id, reminder);
  }

  Future<void> deleteReminder(int id) async {
    final box = await Hive.openBox<ReminderModel>(boxName);
    await box.delete(id);
  }

  Future<List<ReminderModel>> getAllReminders() async {
    final box = await Hive.openBox<ReminderModel>(boxName);
    return box.values.toList();
  }

  Future<void> clearAllReminders() async {
    final box = await Hive.openBox<ReminderModel>(boxName);
    await box.clear();
  }
}
