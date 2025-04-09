import '../../../../utils/exporter.dart';

class LoginController extends AutoDisposeNotifier<Patient?> {
  final authRepository = AuthRepository();
  final loginFormKey = GlobalKey<FormState>();

  final TextEditingController idController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Patient? build() {
    return null;
  }

  Future<void> login({required BuildContext context}) async {
    if (loginFormKey.currentState!.validate()) {
      loginFormKey.currentState!.save();
    }
    try {
      final response = await authRepository.signIn(
          phone: idController.text, password: passwordController.text);

      state = response;
      print(state?.name);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Login Successful!")),
      );
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Home()));
    } catch (e) {
      print(e);

      String errorMessage = "Login Failed. Please try again.";

      if (e.toString().contains("Invalid phone")) {
        errorMessage = "This phone number is not registered";
      } else if (e.toString().contains("Invalid password")) {
        errorMessage = "Incorrect password!";
      }

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(errorMessage)));
      // ScaffoldMessenger.of(context).showSnackBar(
      //     const SnackBar(content: Text("Sign Up Not Successful!")));
      state = null;
    }
  }
}
