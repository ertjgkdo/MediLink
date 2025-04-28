import 'package:medilink/utils/exporter.dart';

final myAppointmentProvider =
    AsyncNotifierProvider.autoDispose<MyAppointmentsController, List<Slot>>(
        MyAppointmentsController.new);
final selectedDateProvider = StateProvider<DateTime>((ref) => DateTime.now());
