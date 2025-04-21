import 'package:medilink/utils/exporter.dart';

class SymptomCheckerController {
  final RunPrediction _runPrediction = RunPrediction();

  Future<List<ResultModel>> getPrediction(List<String> selectedSymptoms) async {
    await _runPrediction.loadModel();
    return await _runPrediction.predict(selectedSymptoms);
  }
}
