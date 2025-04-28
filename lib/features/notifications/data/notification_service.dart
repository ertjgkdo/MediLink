import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:flutter_timezone/flutter_timezone.dart';

class NotificationService {
  final _notificationPlugin = FlutterLocalNotificationsPlugin();
  bool _isInitialized = false;
  bool get isInitialized => _isInitialized;

  Future<void> initNotification() async {
    if (_isInitialized) return;
    //initizalize timezone
    tz.initializeTimeZones();
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(currentTimeZone));
    //AndroidSetting
    const initSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const initSettingsIOS = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    const initSettings = InitializationSettings(
        android: initSettingsAndroid, iOS: initSettingsIOS);

    await _notificationPlugin.initialize(initSettings);
  }

  //notifcation details
  NotificationDetails notificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
          'reminder_channel', 'Appointment Reminders',
          channelDescription: 'Appointment Reminder Notification Channel',
          importance: Importance.max,
          priority: Priority.high),
      iOS: DarwinNotificationDetails(),
    );
  }

  //to show notifications
  Future<void> showNotifcation(
      {int id = 0, String? title, String? body}) async {
    return _notificationPlugin.show(
        id, title, body, const NotificationDetails());
  }

  //Scheduling notfications
  Future<void> scheduleAppointmentReminder({
    required int id,
    required String title,
    required String body,
    required DateTime appointmentTime,
    required Duration remindBefore,
  }) async {
    final scheduledDate =
        tz.TZDateTime.from(appointmentTime, tz.local).subtract(remindBefore);

    if (scheduledDate.isBefore(tz.TZDateTime.now(tz.local))) return;

    await _notificationPlugin.zonedSchedule(
      id,
      title,
      body,
      scheduledDate,
      notificationDetails(),
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.dateAndTime,
    );
  }

  Future<void> cancelNotification(int id) async {
    await _notificationPlugin.cancel(id);
  }

  Future<void> cancelAllNotifcations() async {
    await _notificationPlugin.cancelAll();
  }
}
