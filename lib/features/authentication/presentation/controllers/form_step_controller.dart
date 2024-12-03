import '../../../../utils/exporter.dart';

class FormStepController extends Notifier<int> {
  final pages = 3;
  @override
  build() {
    return 0;
  }

  continueStep() {
    if (state < 2) {
      state = state + 1;
    } else {
      state = state - 1;
    }
  }
}
