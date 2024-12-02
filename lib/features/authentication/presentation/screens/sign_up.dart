import '../../../../utils/exporter.dart';

class SignUp extends ConsumerWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final signupFormKey = GlobalKey<FormState>();
    final currentStep = ref.watch(formStepProvider);
    final stepController = ref.read(formStepProvider.notifier);
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
        child: Form(
            key: signupFormKey,
            child: Stepper(
                type: StepperType.horizontal,
                currentStep: currentStep,
                onStepContinue: () {
                  stepController.continueStep();
                },
                steps: const [
                  Step(
                      title: Text(
                        "General Information Form",
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      content: GeneralInfoForm()),
                  Step(
                      title: Text(
                        "Address Form",
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      content: AddressForm())
                ])),
      )
    ]));
  }
}
