import '../../../../utils/exporter.dart';

class FormStepController extends Notifier<int> {
  final pages = 2;
  @override
  build() {
    return 0;
  }

  continueStep() {
    if (state < 1) {
      state = state + 1;
    } else {
      state = state - 1;
    }
  }
}
