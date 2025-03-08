import 'dart:async';

import 'package:medilink/utils/exporter.dart';

class DoctorController extends AutoDisposeAsyncNotifier<List<Doctor>> {
  final _docRepo = DoctorRepository();

  Future<Doctor> getDoctorById(String id) async {
    return await _docRepo.getDocbyId(id: id);
  }

  @override
  FutureOr<List<Doctor>> build() {
    return _docRepo.getDocList();
  }
}
