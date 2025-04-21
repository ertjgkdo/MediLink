import 'package:medilink/features/symptom_checker/presentation/controller/disease_description_controller.dart';
import 'package:medilink/utils/exporter.dart';

final categoryFilterProvider =
    NotifierProvider.autoDispose<CategoryController, String>(
        (CategoryController.new));
final symptomToggleProvider = StateProvider<bool>((ref) => false);

final selectedSymptomProvider =
    StateNotifierProvider<SymptomsController, List<String>>(
        (ref) => SymptomsController());

final descriptionProvider =
    FutureProvider<DiseaseDescriptionController>((ref) async {
  final controller = DiseaseDescriptionController();
  await controller.loadDescriptions();
  return controller;
});
