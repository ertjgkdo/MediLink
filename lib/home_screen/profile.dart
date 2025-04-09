import '../utils/exporter.dart';

class Profile extends ConsumerWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final signoutController = ref.read(signoutProvider.notifier);
    return Scaffold(
        body: Column(
      children: [
        Container(
          height: 40,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(0, 137, 123, 1),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)))),
              onPressed: () {
                signoutController.signout(context: context);
              },
              child: Text(
                "Sign out",
                style: TextStyle(color: Colors.black),
              )),
        )
      ],
    ));
  }
}
