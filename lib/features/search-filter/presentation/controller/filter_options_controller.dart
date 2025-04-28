import 'dart:async';

import 'package:medilink/features/search-filter/domain/filter_model.dart';
import 'package:medilink/utils/exporter.dart';

class FilterOptionsController<T> extends AsyncNotifier<List<Hosp>> {
  late final FilterRepository _filterRepo = FilterRepository();

  Future<List<Hosp>> fetchData() {
    return _filterRepo.getData();
  }

  @override
  FutureOr<List<Hosp>> build() async {
    return await fetchData();
  }
}
