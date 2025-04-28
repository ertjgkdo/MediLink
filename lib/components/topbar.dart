import 'package:medilink/utils/exporter.dart';

class top_bar extends ConsumerWidget {
  const top_bar({
    super.key,
  });

  @override
  Widget build(BuildContext context, ref) {
    final logoutController = ref.read(signoutProvider.notifier);
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 3,
            child: const Text.rich(TextSpan(children: [
              TextSpan(
                  text: "Medi",
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 24,
                      color: Color.fromRGBO(55, 71, 79, 1))),
              TextSpan(
                  text: "Link",
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 24,
                      color: Color.fromRGBO(0, 137, 123, 1)))
            ])),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NotificationScreen()));
                      },
                      icon: const Icon(Icons.notifications_outlined)),
                ),
                Expanded(
                  child: IconButton(
                      onPressed: () {
                        logoutController.signout(context: context);
                      },
                      icon: const Icon(Icons.logout_outlined)),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
