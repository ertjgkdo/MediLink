import '../utils/exporter.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({super.key});

  final List<({IconData icon, String label})> items = const [
    (icon: Icons.home, label: "Home"),
    (icon: Icons.explore, label: "Explore"),
    (icon: Icons.event_note, label: "Book"),
    (icon: Icons.folder_copy, label: "OPD"),
    (icon: Icons.person_outline, label: "Profile")
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final selected = ref.watch(navBarSelectionProvider);
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: const Color.fromRGBO(55, 71, 79, 1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: items
              .asMap()
              .entries
              .map((item) => bottomBarIcons(
                    icon: item.value.icon,
                    label: item.value.label,
                    isSelected: item.key == selected,
                    onPressed: () {
                      ref.read(navBarSelectionProvider.notifier).state =
                          item.key;
                    },
                  ))
              .toList(),
        ),
      );
    });
  }

  Widget bottomBarIcons({
    required IconData icon,
    required String label,
    required bool isSelected,
    required Function() onPressed,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: isSelected
            ? BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: const Color.fromRGBO(0, 137, 123, 1),
              )
            : null,
        child: Row(
          children: [
            Icon(
              icon,
              size: 24,
              color: Colors.white,
            ),
            if (isSelected) ...[
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
