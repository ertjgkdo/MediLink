import '../utils/exporter.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({super.key});

  final List<({IconData icon, String label})> items = const [
    (icon: Icons.home_outlined, label: "Home"),
    (icon: Icons.search_outlined, label: "Explore"),
    (icon: Icons.calendar_month_outlined, label: "Book"),
    (icon: Icons.content_paste, label: "OPD"),
    (icon: Icons.person_outline, label: "Profile")
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final selected = ref.watch(navBarSelectionProvider);
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: const Color.fromRGBO(26, 43, 80, 1),
        ),
        height: 55,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: items
              .asMap()
              .entries
              .map((item) => Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      child: bottomBarIcons(
                        icon: item.value.icon,
                        label: item.value.label,
                        isSelected: item.key == selected,
                        onPressed: () {
                          ref.read(navBarSelectionProvider.notifier).state =
                              item.key;
                        },
                      ),
                    ),
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
        alignment: Alignment.center,
        duration: const Duration(milliseconds: 200),
        decoration: isSelected
            ? BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
              )
            : null,
        child: Expanded(
          child: Icon(
            icon,
            size: 24,
            color: isSelected
                ? const Color.fromRGBO(255, 183, 77, 1)
                : const Color.fromRGBO(60, 191, 174, 1),
          ),
        ),
      ),
    );
  }
}
