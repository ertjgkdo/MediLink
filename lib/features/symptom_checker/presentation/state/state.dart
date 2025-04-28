import 'package:medilink/features/symptom_checker/presentation/controller/description_toggler_controller.dart';
import 'package:medilink/features/symptom_checker/presentation/controller/disease_description_controller.dart';
import 'package:medilink/utils/exporter.dart';

final categoryFilterProvider =
    NotifierProvider.autoDispose<CategoryController, String>(
        (CategoryController.new));
final symptomToggleProvider = StateProvider<bool>((ref) => false);
final topDescriptionToggleProvider = StateProvider<bool>((ref) => false);

final selectedSymptomProvider =
    StateNotifierProvider<SymptomsController, List<String>>(
        (ref) => SymptomsController());
final otherConditiontoggler =
    StateNotifierProvider<DescTogglerController, Map<int, bool>>(
        (ref) => DescTogglerController());
