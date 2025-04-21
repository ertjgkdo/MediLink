import '../utils/exporter.dart';

class topbar_extended extends StatelessWidget {
  const topbar_extended({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        backButton(),
        const top_bar(),
      ],
    );
  }
}
