import 'package:medilink/utils/exporter.dart';

class Home extends ConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final currentPage = ref.watch(navBarSelectionProvider);
    return Scaffold(
      body: Stack(
        children: [
          IndexedStack(
            index: currentPage,
            children: [
              Visibility(
                visible: currentPage == 0,
                child: home(),
              ),
              Visibility(
                visible: currentPage == 1,
                child: Explore(),
              ),
            ],
          ),
          const Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: BottomBar(),
          )
        ],
      ),
    );
  }

  Column home() {
    return Column(
      children: [
        const top_bar(),
        const searchBar(),
      ],
    );
  }
}
