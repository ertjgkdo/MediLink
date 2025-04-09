import 'package:medilink/home_screen/profile.dart';
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
              Expanded(
                child: Visibility(
                  visible: currentPage == 0,
                  child: home(),
                ),
              ),
              Expanded(
                child: Visibility(
                  visible: currentPage == 1,
                  child: Explore(),
                ),
              ),
              Expanded(
                child: Visibility(
                  visible: currentPage == 2,
                  child: Container(),
                ),
              ),
              Expanded(
                child: Visibility(
                  visible: currentPage == 3,
                  child: MyOpd(),
                ),
              ),
              Expanded(
                child: Visibility(
                  visible: currentPage == 4,
                  child: Profile(),
                ),
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
        // Text("Welcome Back, "),
        const searchBar(),
      ],
    );
  }
}
