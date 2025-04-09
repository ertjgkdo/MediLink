import 'package:medilink/utils/exporter.dart';

final searchFilterProvider =
    NotifierProvider.autoDispose<SearchFilterController, String>(
        (SearchFilterController.new));

// final searchProvider = AsyncNotifierProvider.family<EntitySearchController,
//     List<dynamic>, SearchModel>(EntitySearchController.new);
// final searchProvider = AsyncNotifierProvider.family<EntitySearchController,
//     List<dynamic>, SearchModel>(
//   () => EntitySearchController(),
// );
