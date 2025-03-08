import 'package:medilink/features/authentication/presentation/controllers/login_controller.dart';
import 'package:medilink/utils/exporter.dart';

class Login extends ConsumerWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final formController = ref.read(loginFormProvider.notifier);
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 60),
                  child: Text(
                    "Welcome\nto",
                    style: TextStyle(
                      color: Color.fromRGBO(55, 71, 79, 1),
                      fontWeight: FontWeight.w700,
                      fontSize: 33,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  child: Image.asset(
                    'assets/images/logo.png',
                    width: 80,
                  ),
                ),
                const Text.rich(TextSpan(children: [
                  TextSpan(
                      text: "Medi",
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 33,
                          color: Color.fromRGBO(55, 71, 79, 1))),
                  TextSpan(
                      text: "Link",
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 33,
                          color: Color.fromRGBO(0, 137, 123, 1)))
                ])),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: const Text(
                    "Simplifying your healthcare journey,\n one click at a time.",
                    style: TextStyle(color: Colors.black, fontSize: 15),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Form(
              key: formController.loginFormKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 35,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 40),
                    child: formTextfield(
                        controller: formController.idController,
                        icon: Icons.phone,
                        prefixtext: "+977",
                        label: "Phone number",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Phone number is required';
                          }
                          return null;
                        }),
                  ),
                  Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 10),
                      child: formTextfield(
                          controller: formController.passwordController,
                          icon: Icons.password,
                          label: "Password",
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Password is required';
                            }
                            return null;
                          })),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 10),
                    child: ElevatedButton(
                      onPressed: () {
                        print("pressed");
                        if (formController.loginFormKey.currentState!
                            .validate()) {
                          formController.login(context: context);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromRGBO(0, 137, 123, 1),
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)))),
                      child: const Text(
                        "Log In",
                        style: TextStyle(color: Colors.white, wordSpacing: 1),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account?",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          )),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SignUp(),
                              ));
                        },
                        style: TextButton.styleFrom(
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            overlayColor: Colors.transparent),
                        child: const Text("Sign Up",
                            style: TextStyle(
                                fontSize: 14,
                                color: Color.fromRGBO(55, 71, 79, 1),
                                decoration: TextDecoration.underline)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
