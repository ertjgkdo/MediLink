import 'package:medilink/utils/exporter.dart';

class ChangePassword extends ConsumerWidget {
  const ChangePassword({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final editController = ref.watch(changePasswordProvider.notifier);
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const backButton(),
            SizedBox(
              height: 80,
            ),
            Expanded(
              child: Form(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Text(
                        "Change Your Password",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                        child: Form(
                      child: Column(
                        children: [
                          fieldColumn(
                              passwordVisibilityProvider:
                                  oldPasswordVisibilityProvider,
                              controller: editController.oldPasswordController,
                              label: "Old Password"),
                          fieldColumn(
                              passwordVisibilityProvider:
                                  passwordVisibilityProvider,
                              controller: editController.newPasswordController,
                              label: "New Password"),
                          fieldColumn(
                              passwordVisibilityProvider:
                                  confirmPasswordVisibilityProvider,
                              controller:
                                  editController.confirmPasswordController,
                              label: "Confirm Password"),
                          Flexible(
                            child: ElevatedButton(
                              onPressed: () {
                                editController.changePassword(context: context);
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: primary,
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(8)))),
                              child: Text("Save"),
                            ),
                          )
                        ],
                      ),
                    )),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Padding fieldColumn(
      {required TextEditingController controller,
      required String label,
      required StateProvider<bool> passwordVisibilityProvider}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 8), // spacing between label and field
          PasswordField(
            controller: controller,
            visibilityProvider: passwordVisibilityProvider,
          ),
        ],
      ),
    );
  }
}
