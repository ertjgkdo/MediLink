import 'package:medilink/utils/exporter.dart';

class DiseaseDescriptionController {
  final Map<String, String> _descriptionMap = {};

  Future<void> loadDescriptions() async {
    final data = await rootBundle
        .loadString('assets/images/csv/disease_Description.csv');
    final lines = const LineSplitter().convert(data);

    for (var line in lines.skip(1)) {
      final parts = line.split(',');
      if (parts.length >= 2) {
        final disease = parts[0].trim();
        final description =
            parts.sublist(1).join(',').trim(); // handles commas in description
        _descriptionMap[disease] = description;
      }
    }
  }

  String? getDescription(String disease) {
    return _descriptionMap[disease];
  }

  Map<String, String> get descriptionMap => _descriptionMap;
}
