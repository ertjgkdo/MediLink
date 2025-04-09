import 'dart:async';

import '../../../../utils/exporter.dart';

class RecordController<T>
    extends FamilyAsyncNotifier<List<RecordModel>, String> {
  final _recordRepository = RecordRepository();

  @override
  FutureOr<List<RecordModel>> build(String arg) async {
    return await _recordRepository.getAllRecords(id: arg);
  }
}
