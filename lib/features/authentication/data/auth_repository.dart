import 'package:medilink/utils/exporter.dart';

class AuthRepository extends Repository<Patient> {
  AuthRepository({super.localClient});
  @override
  Patient fromJson(Map<String, dynamic> map) => Patient.fromJson(map);

  @override
  Patient fromRawJson(String json) => Patient.fromRawJson(json);

  Future<Patient> signUp({required Patient patient}) async {
    return await postRequest(
        path: "/auth/signup", body: patient.patientToJson(patient));
  }

  Future<Patient> signIn(
      {required String phone, required String password}) async {
    // print("here");
    final response = await postRequest(
        path: "/auth/login",
        client: localClient,
        body: jsonEncode({"phone": phone, "password": password}));
    print(response.name);
    final String? token = response.token;
    // final Patient user = Patient.fromJson(response['user']);

    // Store token securely
    await storage.write(key: 'auth_token', value: token);
    return response;
  }
}
