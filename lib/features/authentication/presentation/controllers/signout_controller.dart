import '../../../../utils/exporter.dart';

class SignoutController extends StateNotifier<void> {
  SignoutController(super.state);

  Future<void> signout({required BuildContext context}) async {
    await SecureStorage.deleteUserInfo();
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => Login()), (route) => false);
  }
}
