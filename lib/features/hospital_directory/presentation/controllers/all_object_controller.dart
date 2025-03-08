import 'dart:async';

import '../../../../utils/exporter.dart';

class AllObjectsController<T> extends AutoDisposeAsyncNotifier<List<T>> {
  final Future<List<T>> Function() fetchFunction;

  AllObjectsController({required this.fetchFunction});

  @override
  FutureOr<List<T>> build() {
    return fetchFunction();
  }
}
