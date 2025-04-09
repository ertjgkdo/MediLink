import 'package:medilink/utils/exporter.dart';

class PasswordForm extends ConsumerWidget {
  const PasswordForm({super.key, required this.formController});
  final SignUpController formController;
  @override
  Widget build(BuildContext context, ref) {
    return Column(
      children: [
        Container(
            margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
            child: PasswordField(
              controller: formController.passwordController,
              label: "Enter a Password",
              visibilityProvider: passwordVisibilityProvider,
            )),
        Container(
            margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
            child: PasswordField(
                controller: formController.confirmController,
                visibilityProvider: confirmPasswordVisibilityProvider,
                label: "Re-enter Password")),
      ],
    );
  }
}
