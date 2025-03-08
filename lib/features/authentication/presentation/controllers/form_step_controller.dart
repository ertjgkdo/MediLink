import '../../../../utils/exporter.dart';

class FormStepController extends Notifier<int> {
  final pages = 3;
  @override
  build() {
    return 0;
  }

  continueStep(
      {required List<GlobalKey<FormState>> formKeys, bool skip = false}) {
    // if (state < 2) {
    //   if (formKeys[0].currentState!.validate()) {
    //     state = state + 1;
    //   }
    //   if (formKeys[1].currentState!.validate()) {
    //     state = state + 1;
    //   }
    // } else {
    //   if (formKeys[1].currentState!.validate()) state = state - 1;
    // }
    if (state < pages - 1) {
      if (skip) {
        // Skip current step and move to the next one
        state = state + 1;
      } else if (formKeys[state].currentState?.validate() ?? false) {
        // Validate normally if not skipping
        state = state + 1;
      } else {
        debugPrint("Validation failed for step $state");
      }
    }
  }

  void previousStep() {
    if (state > 0) {
      // Move to the previous step
      state--;
    }
  }
}
