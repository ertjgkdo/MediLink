import '../../../../utils/exporter.dart';

class SignUp extends ConsumerWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final currentStep = ref.watch(formStepProvider);
    final stepController = ref.read(formStepProvider.notifier);
    // final signUpFormState = ref.watch(signUpFormProvider);
    final signUpFormController = ref.read(signUpFormProvider.notifier);
    return Scaffold(
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
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
                      fontWeight: FontWeight.w900,
                      fontSize: 26,
                      color: Color.fromRGBO(55, 71, 79, 1))),
              TextSpan(
                  text: "Link",
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 26,
                      color: Color.fromRGBO(0, 137, 123, 1)))
            ])),
          ),
        ],
      ),
      Expanded(
        child: Stepper(
            controlsBuilder: (context, details) => Row(
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          details.onStepContinue!();
                        },
                        child:
                            Text(currentStep <= 1 ? "Continue" : "Previous")),
                    if (currentStep > 1)
                      ElevatedButton(
                          onPressed: () {
                            // if (formController.basicFormKey.currentState!
                            //         .validate() &&
                            //     formController.nutritionFormKey.currentState!
                            //         .validate()) {
                            //   formController.submit(context: context);
                            // }
                          },
                          child: const Text("Submit"))
                  ],
                ),
            type: StepperType.horizontal,
            currentStep: currentStep,
            onStepContinue: () {
              stepController.continueStep(formKeys: [
                signUpFormController.generalInfoFormKey,
                signUpFormController.addressFormKey,
                signUpFormController.passwordFormKey
              ]);
            },
            steps: [
              Step(
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
                  title: const Text(
                    "Step 2",
                    textAlign: TextAlign.center,
                  ),
                  content: Form(
                      key: signUpFormController.addressFormKey,
                      child:
                          AddressForm(formController: signUpFormController))),
              Step(
                  title: const Text(
                    "Step 3",
                    textAlign: TextAlign.center,
                  ),
                  content: Form(
                      key: signUpFormController.passwordFormKey,
                      child:
                          PasswordForm(formController: signUpFormController)))
            ]),
      )
    ]));
  }
}
