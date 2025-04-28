import 'package:medilink/utils/exporter.dart';

class DescTogglerController extends StateNotifier<Map<int, bool>> {
  DescTogglerController() : super({});
  void toggle(int index) {
    state = {
      ...state,
      index: !(state[index] ?? false),
    };
  }
}
