import 'package:medilink/utils/exporter.dart';

class RunPrediction {
  late final Interpreter _interpreter;

  Future<void> loadModel() async {
    _interpreter = await Interpreter.fromAsset(
        "assets/prediction_model/symptom_checker_model.tflite");
  }

  Future<List<ResultModel>> predict(List<String> selectedSymptoms) async {
    final input = [encodeSymptoms(selectedSymptoms, allSymptoms)];
    const numClasses = 41; // or whatever your model outputs
    var output = List.filled(1 * numClasses, 0.0).reshape([1, numClasses]);

    _interpreter.run(input, output);

    List<double> probs = output[0];

    final labels = [
      "(vertigo) Paroxysmal Positional Vertigo",
      "AIDS",
      "Acne",
      "Alcoholic hepatitis",
      "Allergy",
      "Arthritis",
      "Bronchial Asthma",
      "Cervical spondylosis",
      "Chicken pox",
      "Chronic cholestasis",
      "Common Cold",
      "Dengue",
      "Diabetes",
      "Dimorphic hemorrhoids (piles)",
      "Drug Reaction",
      "Fungal infection",
      "GERD",
      "Gastroenteritis",
      "Heart attack",
      "Hepatitis A",
      "Hepatitis B",
      "Hepatitis C",
      "Hepatitis D",
      "Hepatitis E",
      "Hypertension",
      "Hyperthyroidism",
      "Hypoglycemia",
      "Hypothyroidism",
      "Impetigo",
      "Jaundice",
      "Malaria",
      "Migraine",
      "Osteoarthritis",
      "Paralysis (brain hemorrhage)",
      "Peptic ulcer disease",
      "Pneumonia",
      "Psoriasis",
      "Tuberculosis",
      "Typhoid",
      "Urinary tract infection",
      "Varicose veins"
    ];

    final indexed = probs.asMap().entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return indexed.take(3).map((entry) {
      return ResultModel(
        condition: labels[entry.key],
        confidence: "${(entry.value * 100).toStringAsFixed(2)}%",
      );
    }).toList();
  }
}
