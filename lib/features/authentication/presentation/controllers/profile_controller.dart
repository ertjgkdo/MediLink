import 'dart:async';

import 'package:medilink/utils/exporter.dart';

class ProfileController extends AutoDisposeAsyncNotifier<Patient> {
  final _repo = AuthRepository();
  @override
  FutureOr<Patient> build() {
    return _repo.getDetails();
  }
}
