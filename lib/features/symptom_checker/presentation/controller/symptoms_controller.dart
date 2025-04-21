import 'package:medilink/utils/exporter.dart';

class SymptomsController extends StateNotifier<List<String>> {
  SymptomsController() : super([]);

  void toggleSymptom(String symptom) {
    if (state.contains(symptom)) {
      state = List.from(state)..remove(symptom);
    } else {
      state = List.from(state)..add(symptom);
    }
  }

  void clear() => state = [];
}
