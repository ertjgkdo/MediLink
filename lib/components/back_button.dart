import '../utils/exporter.dart';

class backButton extends StatelessWidget {
  const backButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        width: 35,
        height: 35,
        margin: const EdgeInsets.only(left: 10, top: 10),
        padding: const EdgeInsets.only(left: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border: Border.all(color: const Color.fromRGBO(0, 137, 123, 1)),
        ),
        child: const Icon(
          Icons.arrow_back_ios,
          color: Color.fromRGBO(0, 137, 123, 1),
          size: 18,
        ),
      ),
    );
  }
}
