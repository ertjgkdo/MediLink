import 'package:medilink/utils/exporter.dart';

class HomeRepository extends Repository<Slot> {
  @override
  Slot fromJson(Map<String, dynamic> map) => Slot.fromJson(map);

  @override
  Slot fromRawJson(String json) => Slot.fromRawJson(json);

  Future<List<Slot>> getBookedSlots() async {
    final String? authToken = await SecureStorage.getToken();
    return getAll(path: "/booked/patient", authToken: authToken);
  }
}
