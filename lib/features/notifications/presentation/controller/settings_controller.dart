import 'package:medilink/utils/exporter.dart';

class DurationController extends StateNotifier<Duration> {
  DurationController() : super(const Duration(hours: 24));

  final _settingsRepo = SettingsRepository();

  void setDuration(Duration duration) {
    state = duration;
    _settingsRepo.saveReminderDuration(duration);
  }

  Future<void> loadFromHive() async {
    final duration = await _settingsRepo.getReminderDuration();
    state = duration;
  }
}
