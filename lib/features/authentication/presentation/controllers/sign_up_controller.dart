import '../../../../utils/exporter.dart';

class SignUpController extends AutoDisposeNotifier<UserModel?> {
  final generalInfoFormKey = GlobalKey<FormState>();
  final addressFormKey = GlobalKey<FormState>();
  final passwordFormKey = GlobalKey<FormState>();
//texteditingcontroller for basic info form
  final TextEditingController nameController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
//controllers for address form
  final TextEditingController toleController = TextEditingController();
  //controllers for password form
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();
  @override
  UserModel? build() {
    // TODO: implement build
    throw UnimplementedError();
  }
}
