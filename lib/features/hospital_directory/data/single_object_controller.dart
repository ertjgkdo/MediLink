import 'dart:async';

import 'package:medilink/utils/exporter.dart';

class SingleObjectController<T>
    extends AutoDisposeFamilyAsyncNotifier<T, String> {
  final Future<T> Function(String id) fetchFunction;

  SingleObjectController({required this.fetchFunction});

  @override
  FutureOr<T> build(String id) {
    return fetchFunction(id);
  }
}
