import 'package:medilink/utils/exporter.dart';

class EditController extends AutoDisposeFamilyNotifier<Patient, Patient?> {
  final AuthRepository _authrepo = AuthRepository();
  final GlobalKey<FormState> editFormKey = GlobalKey<FormState>();

  late final TextEditingController nameController =
      TextEditingController(text: arg?.name ?? "name");
  late final TextEditingController dobController = TextEditingController(
    text: arg?.dob != null ? arg!.dob?.toIso8601String().split('T')[0] : "",
  );
  late final TextEditingController genderController =
      TextEditingController(text: arg?.gender ?? "gender");
  late final TextEditingController bloodGroupController =
      TextEditingController(text: arg?.bloodGroup ?? "bloodGroup");
  late final TextEditingController addressController =
      TextEditingController(text: arg?.address ?? "address");
  late final TextEditingController phoneController =
      TextEditingController(text: arg?.phone ?? "phone");
  late final TextEditingController mailController =
      TextEditingController(text: arg?.email ?? "email");

  @override
  Patient build(Patient? arg) {
    return arg ?? Patient(name: "", phone: "", password: "");
  }

  addInfo(
      {String? name,
      DateTime? dob,
      String? gender,
      String? bloodGroup,
      String? address,
      String? phone,
      String? email}) {
    state = state.copyWith(
        name: name,
        dob: dob,
        gender: gender,
        bloodGroup: bloodGroup,
        address: address,
        phone: phone,
        email: email);
  }

  Future<void> updateProfile({required BuildContext context}) async {
    if (editFormKey.currentState!.validate()) {
      editFormKey.currentState!.save();

      final updatedData = {
        "name": nameController.text.trim(),
        "dob": dobController.text.trim(),
        "gender": state.gender,
        "bloodGroup": state.bloodGroup,
        "address": addressController.text.trim(),
        "phone": phoneController.text.trim(),
        "email": mailController.text.trim(),
      };

      try {
        await _authrepo.updateProfile(state.id!, updatedData);

        // Optional: update state if you want the local UI to reflect changes
        state = state.copyWith(
          name: updatedData["name"],
          dob: DateTime.tryParse(updatedData["dob"] ?? ""),
          gender: updatedData["gender"],
          bloodGroup: updatedData["bloodGroup"],
          address: updatedData["address"],
          phone: updatedData["phone"],
          email: updatedData["email"],
        );
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Profile updated successfully")),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => Home(), // Replace with your target screen
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Failed to update profile")),
        );

        rethrow;
      }
    }
  }
}
