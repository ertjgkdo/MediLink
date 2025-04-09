import '../utils/exporter.dart';

class RecordDetailColumn extends StatelessWidget {
  const RecordDetailColumn(
      {super.key, required this.label, required this.value});
  final String label;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: secondary),
        ),
        Text(
          value,
          style: const TextStyle(fontSize: 15, color: Colors.black),
        ),
      ],
    );
  }
}
