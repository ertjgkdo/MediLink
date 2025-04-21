import '../utils/exporter.dart';

class PasswordField extends ConsumerWidget {
  const PasswordField(
      {super.key,
      required this.controller,
      required this.visibilityProvider,
      this.label});

  final TextEditingController controller;
  final String? label;
  final StateProvider<bool> visibilityProvider;
  @override
  Widget build(BuildContext context, ref) {
    final isPasswordVisible = ref.watch(visibilityProvider);

    return TextFormField(
      controller: controller,
      obscureText: !isPasswordVisible, // Toggle visibility
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: const Icon(Icons.password),
        suffixIcon: IconButton(
          icon: Icon(
            isPasswordVisible ? Icons.visibility : Icons.visibility_off,
          ),
          onPressed: () {
            ref.read(visibilityProvider.notifier).state = !isPasswordVisible;
          },
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Password is required';
        }
        return null;
      },
    );
  }
}
