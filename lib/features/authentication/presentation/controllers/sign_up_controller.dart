import '../../../../utils/exporter.dart';

class SignUpController extends Notifier<Patient?> {
  final authRepository = AuthRepository();

  final generalInfoFormKey = GlobalKey<FormState>();
  final addressFormKey = GlobalKey<FormState>();
  final passwordFormKey = GlobalKey<FormState>();
//texteditingcontroller for basic info form
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  String? gender = "";
  String? bloodgroup = "";

//controllers for address form
  String? province = "";
  String? district = "";
  String? subdistrict = "";
  final TextEditingController toleController = TextEditingController();
  //controllers for password form
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();
  @override
  Patient? build() {
    return null;
  }

  Future<void> signUp({required BuildContext context}) async {
    if (generalInfoFormKey.currentState!.validate() &&
        addressFormKey.currentState!.validate() &&
        passwordFormKey.currentState!.validate()) {
      generalInfoFormKey.currentState!.save();
      addressFormKey.currentState!.save();
      passwordFormKey.currentState!.save();

      state = Patient(
          name: nameController.text,
          phone: phoneController.text,
          password: passwordController.text,
          address: formatAddress(
              province, district, subdistrict, toleController.text),
          bloodGroup: bloodgroup,
          dob: DateTime.parse(dobController.text),
          email: emailController.text.isEmpty ? null : emailController.text,
          gender: gender);

      try {
        final user = await authRepository.signUp(patient: state!);

        if (user.token != null) {
          await SecureStorage.saveUserInfo(user);
        }
        void clearFormFields() {
          // Reset form keys
          generalInfoFormKey.currentState?.reset();
          addressFormKey.currentState?.reset();
          passwordFormKey.currentState?.reset();

          // Clear text controllers
          nameController.clear();
          emailController.clear();
          dobController.clear();
          phoneController.clear();
          toleController.clear();
          passwordController.clear();
          confirmController.clear();

          // Reset dropdown selections
          gender = "";
          bloodgroup = "";
          province = "";
          district = "";
          subdistrict = "";

          // Notify UI if needed (depends on Riverpod usage)
          state = null;
        }

        clearFormFields();

        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Sign Up Successful!")));
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const Home()),
            (route) => false);
      } catch (e) {
        String errorMessage = "Sign Up Not Successful!";

        if (e.toString().contains("Phone number already registered")) {
          errorMessage = "This phone number is already in use!";
        } else if (e.toString().contains("Email already registered")) {
          errorMessage = "This email is already in use!";
        }

        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(errorMessage)));
        // ScaffoldMessenger.of(context).showSnackBar(
        //     const SnackBar(content: Text("Sign Up Not Successful!")));
        state = null;
      }
    }
  }

  String formatAddress(
      String? province, String? district, String? subdistrict, String tole) {
    List<String> addressParts = [];

    if (province != null && province.isNotEmpty) addressParts.add(province);
    if (district != null && district.isNotEmpty) addressParts.add(district);
    if (subdistrict != null && subdistrict.isNotEmpty) {
      addressParts.add(subdistrict);
    }
    if (tole.isNotEmpty) addressParts.add(tole);

    return addressParts.isNotEmpty
        ? addressParts.join(", ")
        : "N/A"; // Default to "N/A" if empty
  }

  void clearFormFields() {
    // Reset form keys
    generalInfoFormKey.currentState?.reset();
    addressFormKey.currentState?.reset();
    passwordFormKey.currentState?.reset();

    // Clear text controllers
    nameController.clear();
    emailController.clear();
    dobController.clear();
    phoneController.clear();
    toleController.clear();
    passwordController.clear();
    confirmController.clear();

    // Reset dropdown selections
    gender = "";
    bloodgroup = "";
    province = "";
    district = "";
    subdistrict = "";

    // Notify UI if needed (depends on Riverpod usage)
    state = null;
  }
}
