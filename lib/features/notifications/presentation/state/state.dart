import 'package:medilink/utils/exporter.dart';

final notificationProvider = AsyncNotifierProvider.autoDispose<
    NotificationController, List<ReminderModel>>(NotificationController.new);

final reminderDurationProvider =
    StateNotifierProvider<DurationController, Duration>((ref) {
  return DurationController()..loadFromHive();
});
