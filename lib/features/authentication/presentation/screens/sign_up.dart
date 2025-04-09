import '../../../../utils/exporter.dart';

class SignUp extends ConsumerWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final currentStep = ref.watch(formStepProvider);
    final stepController = ref.read(formStepProvider.notifier);
    // final signUpFormState = ref.watch(signUpFormProvider);
    final signUpFormController = ref.read(signUpFormProvider.notifier);
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          ref.invalidate(signUpFormProvider);
        }
      },
      child: Scaffold(
          body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                child: Image.asset(
                  'assets/images/logo.png',
                  width: 60,
                ),
              ),
            ),
            const Expanded(
              flex: 5,
              child: Text.rich(TextSpan(children: [
                TextSpan(
                    text: "Medi",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 26,
                        color: Color.fromRGBO(55, 71, 79, 1))),
                TextSpan(
                    text: "Link",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 26,
                        color: Color.fromRGBO(0, 137, 123, 1)))
              ])),
            ),
          ],
        ),
        Expanded(
          child: Stepper(
              type: StepperType.horizontal,
              currentStep: currentStep,
              onStepContinue: () {
                if (currentStep == 0) {
                  // Check if basic info is filled, continue to step 2
                  if (signUpFormController.generalInfoFormKey.currentState
                          ?.validate() ??
                      false) {
                    stepController.continueStep(formKeys: [
                      signUpFormController.generalInfoFormKey,
                      signUpFormController.addressFormKey,
                      signUpFormController.passwordFormKey
                    ]);
                  }
                } else if (currentStep == 1) {
                  // Check if address form is skipped or valid, proceed
                  if (signUpFormController.addressFormKey.currentState
                          ?.validate() ??
                      false) {
                    stepController.continueStep(formKeys: [
                      signUpFormController.generalInfoFormKey,
                      signUpFormController.addressFormKey,
                      signUpFormController.passwordFormKey
                    ]);
                  }
                } else {
                  stepController.continueStep(formKeys: [
                    signUpFormController.generalInfoFormKey,
                    signUpFormController.addressFormKey,
                    signUpFormController.passwordFormKey
                  ]);
                }
              },
              onStepCancel: () {
                if (currentStep > 0) {
                  stepController.previousStep();
                }
              },
              controlsBuilder: (context, details) => Container(
                    margin: const EdgeInsets.only(top: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              if (currentStep == 0) {
                                // Go to the previous page.
                                Navigator.pop(context);
                                signUpFormController.clearFormFields();
                              } else {
                                // Go to the previous step.
                                details.onStepCancel!();
                              }
                            },
                            child: const Text("Back"),
                          ),
                        ),
                        const SizedBox(width: 10),
                        if (currentStep == 1)
                          Expanded(
                              child: ElevatedButton(
                                  onPressed: () {
                                    stepController.continueStep(formKeys: [
                                      signUpFormController.generalInfoFormKey,
                                      signUpFormController.addressFormKey,
                                      signUpFormController.passwordFormKey
                                    ], skip: true);
                                  },
                                  child: const Text("Skip"))),
                        const SizedBox(width: 10),
                        if (currentStep != 2)
                          Expanded(
                            child: ElevatedButton(
                                onPressed: () {
                                  details.onStepContinue!();
                                },
                                child: const Text("Continue")),
                          ),
                        if (currentStep == 2)
                          Expanded(
                            child: ElevatedButton(
                                onPressed: () {
                                  if (signUpFormController
                                          .generalInfoFormKey.currentState!
                                          .validate() &&
                                      signUpFormController
                                          .addressFormKey.currentState!
                                          .validate() &&
                                      signUpFormController
                                          .passwordFormKey.currentState!
                                          .validate()) {
                                    signUpFormController.signUp(
                                        context: context);
                                    ref.invalidate(signUpFormProvider);
                                  }
                                },
                                child: const Text("Submit")),
                          ),
                      ],
                    ),
                  ),
              steps: [
                Step(
                    state: currentStep > 0
                        ? StepState.complete
                        : StepState.indexed,
                    isActive: currentStep == 0,
                    title: const Text(
                      "Step 1",
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    content: Form(
                        key: signUpFormController.generalInfoFormKey,
                        child: GeneralInfoForm(
                          formController: signUpFormController,
                        ))),
                Step(
                    state: currentStep > 1
                        ? StepState.complete
                        : StepState.indexed,
                    isActive: currentStep == 1,
                    title: const Text(
                      "Step 2",
                      textAlign: TextAlign.center,
                    ),
                    content: Form(
                        key: signUpFormController.addressFormKey,
                        child:
                            AddressForm(formController: signUpFormController))),
                Step(
                    state: currentStep > 2
                        ? StepState.complete
                        : StepState.indexed,
                    isActive: currentStep == 2,
                    title: const Text(
                      "Step 3",
                      textAlign: TextAlign.center,
                    ),
                    content: Form(
                        key: signUpFormController.passwordFormKey,
                        child:
                            PasswordForm(formController: signUpFormController)))
              ]),
        ),
      ])),
    );
  }
}
