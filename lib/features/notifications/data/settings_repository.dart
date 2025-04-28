import 'package:hive/hive.dart';

class SettingsRepository {
  static const _boxName = 'settings_box';
  static const _reminderKey = 'reminder_duration_minutes';

  Future<void> saveReminderDuration(Duration duration) async {
    final box = await Hive.openBox(_boxName);
    await box.put(_reminderKey, duration.inMinutes);
  }

  Future<Duration> getReminderDuration() async {
    final box = await Hive.openBox(_boxName);
    final minutes = box.get(_reminderKey, defaultValue: 1440); // 24 hrs
    return Duration(minutes: minutes);
  }
}
