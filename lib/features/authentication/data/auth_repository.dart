import 'package:medilink/utils/exporter.dart';

class AuthRepository extends Repository<Patient> {
  AuthRepository({super.localClient});
  @override
  Patient fromJson(Map<String, dynamic> map) => Patient.fromJson(map);

  @override
  Patient fromRawJson(String json) => Patient.fromRawJson(json);

  Future<Patient> signUp({required Patient patient}) async {
    return await postRequest(
        path: "/auth/patient/signup", body: patient.patientToJson(patient));
  }

  Future<Patient> signIn(
      {required String phone, required String password}) async {
    // print("here");
    final response = await postRequest(
        path: "/auth/patient/login",
        client: localClient,
        body: jsonEncode({"phone": phone, "password": password}));
    // print(response.name);

    final Patient user = response;
    print("Received token: ${user.token}");
    await SecureStorage.saveUserInfo(user);
    return response;
  }

  Future<Patient> getDetails() async {
    final token = await SecureStorage.getToken();
    final response =
        await getRequest(path: "/patients/profile/view", authToken: token);
    return response;
  }

  Future<void> updateProfile(
      String userId, Map<String, dynamic> updatedData) async {
    try {
      final token = await SecureStorage.getToken();
      final updatedUser = await putRequest(
        authToken: token,
        path:
            '/patients/profile/edit', // adjust if your actual path is different
        id: userId,
        body: updatedData,
      );

      // You can update any local state or provider here
      print("User profile updated successfully: $updatedUser");

      // Optionally show a success message or redirect
    } catch (e) {
      print("Failed to update user profile: $e");
      // Handle the error or show a dialog/snackbar
    }
  }

  Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    final body = {
      "oldPassword": oldPassword,
      "newPassword": newPassword,
    };

    await postRequest(path: "/auth/change-password", body: jsonEncode(body));
  }
}
