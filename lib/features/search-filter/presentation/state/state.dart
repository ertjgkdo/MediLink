import 'package:medilink/features/search-filter/domain/filter_model.dart';
import 'package:medilink/features/search-filter/presentation/controller/filter_controller.dart';
import 'package:medilink/features/search-filter/presentation/controller/filter_options_controller.dart';
import 'package:medilink/utils/exporter.dart';

//for search
final searchFilterProvider =
    NotifierProvider.autoDispose<SearchFilterController, String>(
        (SearchFilterController.new));
//for filters
// Selected Hospital ID
final selectedHospitalIdProvider = StateProvider<String?>((ref) => null);

// Selected Department ID
final selectedDepartmentIdProvider = StateProvider<String?>((ref) => null);

// Selected Doctor ID
final selectedDoctorIdProvider = StateProvider<String?>((ref) => null);

// Selected Time Slot Text
final selectedTimeSlotProvider = StateProvider<String?>((ref) => null);

// Selected AM/PM
final selectedAmPmProvider = StateProvider<String?>((ref) => null);

final filterOptionsProvider =
    AsyncNotifierProvider<FilterOptionsController, List<Hosp>>(
        FilterOptionsController.new);
final filteredProvider =
    AsyncNotifierProvider<FilterController, List<Slot>>(FilterController.new);
// final searchProvider = AsyncNotifierProvider.family<EntitySearchController,
//     List<dynamic>, SearchModel>(EntitySearchController.new);
// final searchProvider = AsyncNotifierProvider.family<EntitySearchController,
//     List<dynamic>, SearchModel>(
//   () => EntitySearchController(),
// );
