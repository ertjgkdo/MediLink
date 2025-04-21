import 'dart:async';

import '../../../../utils/exporter.dart';

class PasswordChangeController extends AsyncNotifier<void> {
  final AuthRepository _authRepo = AuthRepository();
  final GlobalKey<FormState> passwordChangeKey = GlobalKey<FormState>();

  late final TextEditingController oldPasswordController =
      TextEditingController();
  late final TextEditingController newPasswordController =
      TextEditingController();
  late final TextEditingController confirmPasswordController =
      TextEditingController();
  @override
  FutureOr<void> build() {
    // TODO: implement build
    throw UnimplementedError();
  }

  Future<void> changePassword({required BuildContext context}) async {
    if (!passwordChangeKey.currentState!.validate()) return;

    final oldPassword = oldPasswordController.text.trim();
    final newPassword = newPasswordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

    if (newPassword != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("New and Confirm Passwords do not match")),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => Profile(), // Replace with your target screen
        ),
      );
      return;
    }

    try {
      await _authRepo.changePassword(
          oldPassword: oldPassword, newPassword: newPassword);

      // if (response['success'] == true) {
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     const SnackBar(content: Text("Password changed successfully")),
      //   );
      Navigator.pop(context);
      // } else {
      //   throw Exception(response['message'] ?? "Failed to change password");
      // }
    } catch (e) {
      print("Change Password Error: $e");

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }
}
