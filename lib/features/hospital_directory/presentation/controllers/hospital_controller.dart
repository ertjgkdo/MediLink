import 'dart:async';

import 'package:medilink/utils/exporter.dart';

class HospitalController extends AutoDisposeAsyncNotifier<List<Hospital>> {
  final _hospitalRepo = HospitalRepository();

  Future<Hospital> getHospitalById(String id) async {
    return await _hospitalRepo.getHospitalbyId(id: id);
  }

  @override
  FutureOr<List<Hospital>> build() {
    return _hospitalRepo.getHospList();
  }
}
