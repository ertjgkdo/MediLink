import 'package:flutter/material.dart';
import 'package:medilink/utils/exporter.dart';

class PasswordForm extends ConsumerWidget {
  const PasswordForm({super.key, required this.formController});
  final SignUpController formController;
  @override
  Widget build(BuildContext context, ref) {
    return Column(
      children: [
        Container(
            margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
            child: formTextfield(
                controller: formController.passwordController,
                icon: Icons.password,
                label: "Enter a password",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a password';
                  }
                  return null;
                })),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
          child: formTextfield(
              controller: formController.confirmController,
              icon: Icons.password,
              label: "Re-enter Password",
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please re-enter your password';
                }
                return null;
              }),
        ),
        // Container(
        //   margin: EdgeInsets.all(60),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: [
        //       ElevatedButton(
        //         onPressed: () {
        //           Navigator.pop(context);
        //         },
        //         style: ElevatedButton.styleFrom(
        //             backgroundColor: Color.fromRGBO(0, 137, 123, 1),
        //             shape: RoundedRectangleBorder(
        //                 borderRadius: BorderRadius.all(Radius.circular(8)))),
        //         child: Text(
        //           "Back",
        //           style: TextStyle(color: Colors.white, wordSpacing: 1),
        //         ),
        //       ),
        //       ElevatedButton(
        //         onPressed: () {
        //           if (_passwordFormKey.currentState!.validate()) {
        //             Navigator.push(
        //                 context,
        //                 MaterialPageRoute(
        //                   builder: (context) => PasswordForm(),
        //                 ));
        //           }
        //         },
        //         style: ElevatedButton.styleFrom(
        //             backgroundColor: Color.fromRGBO(0, 137, 123, 1),
        //             shape: RoundedRectangleBorder(
        //                 borderRadius: BorderRadius.all(Radius.circular(8)))),
        //         child: Text(
        //           "Sign Up",
        //           style: TextStyle(color: Colors.white, wordSpacing: 1),
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
      ],
    );
  }
}
