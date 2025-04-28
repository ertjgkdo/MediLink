import 'package:medilink/utils/exporter.dart';

class NotificationController
    extends AutoDisposeAsyncNotifier<List<ReminderModel>> {
  late final NotificationService _notificationService;
  late final NotificationRepository _repository;

  @override
  Future<List<ReminderModel>> build() async {
    _notificationService = NotificationService();
    _repository = NotificationRepository();
    _notificationService.initNotification();
    return _repository.getAllReminders();
  }

  Future<void> scheduleReminder({
    required int id,
    required String title,
    required String body,
    required DateTime appointmentTime,
    required Duration remindBefore,
  }) async {
    final remindAt = appointmentTime.subtract(remindBefore);

    final reminder = ReminderModel(
      id: id,
      title: title,
      body: body,
      remindAt: remindAt,
      appointmentTime: appointmentTime,
    );

    await _repository.addReminder(reminder);
    await _notificationService.scheduleAppointmentReminder(
      id: id,
      title: title,
      body: body,
      appointmentTime: appointmentTime,
      remindBefore: remindBefore,
    );

    state = AsyncValue.data(await _repository.getAllReminders());
  }

  Future<void> deleteReminder(int id) async {
    await _repository.deleteReminder(id);
    await _notificationService.cancelNotification(id);
    state = AsyncValue.data(await _repository.getAllReminders());
  }

  Future<void> cancelAllReminders() async {
    await _repository.clearAllReminders();
    await _notificationService.cancelAllNotifcations();
    state = AsyncValue.data(await _repository.getAllReminders());
  }
}
