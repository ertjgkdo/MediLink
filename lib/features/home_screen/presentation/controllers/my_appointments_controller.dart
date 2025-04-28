import 'dart:async';

import 'package:medilink/utils/exporter.dart';

class MyAppointmentsController extends AutoDisposeAsyncNotifier<List<Slot>> {
  final _homeRepo = HomeRepository();
  @override
  FutureOr<List<Slot>> build() {
    return _homeRepo.getBookedSlots();
  }

  Map<DateTime, List<Slot>> groupByDate(List<Slot> slots) {
    final Map<DateTime, List<Slot>> grouped = {};
    for (var slot in slots) {
      if (slot.date == null) continue;
      final normalizedDate =
          DateTime(slot.date!.year, slot.date!.month, slot.date!.day);
      grouped.putIfAbsent(normalizedDate, () => []).add(slot);
    }
    return grouped;
  }
}
