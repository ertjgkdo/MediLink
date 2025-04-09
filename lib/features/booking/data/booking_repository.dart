import 'package:medilink/utils/exporter.dart';

class BookingRepository extends Repository {
  @override
  fromJson(Map<String, dynamic> map) {
    // TODO: implement fromJson
    throw UnimplementedError();
  }

  @override
  fromRawJson(String json) {
    // TODO: implement fromRawJson
    throw UnimplementedError();
  }

  book({required String slotId, required String userId}) async {
    return await postRequest(
        path: "/bookings/book",
        body: jsonEncode({"slot_Id": slotId, "user_id": userId}));
  }
}
