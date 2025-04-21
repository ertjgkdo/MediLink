import 'package:medilink/utils/exporter.dart';

class SymptomRow extends ConsumerWidget {
  const SymptomRow({
    super.key,
    required this.symptom,
  });

  final String symptom;

  @override
  Widget build(BuildContext context, ref) {
    final selectedSymptoms = ref.watch(selectedSymptomProvider);
    final isChecked = selectedSymptoms.contains(symptom);

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Checkbox(
          activeColor: secondary,
          value: isChecked,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5), // Adjust as needed
          ),
          onChanged: (bool? value) {
            ref.read(selectedSymptomProvider.notifier).toggleSymptom(symptom);
          },
        ),
        Expanded(
          flex: 5,
          child: Container(
            constraints: const BoxConstraints(maxWidth: 80),
            child: Text(
              symptom,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ],
    );
  }
}
