import 'package:medilink/utils/exporter.dart';

class BookingRepository extends Repository<Slot> {
  @override
  Slot fromJson(Map<String, dynamic> map) => Slot.fromJson(map);

  @override
  Slot fromRawJson(String json) => Slot.fromRawJson(json);

  book({required String slotId, required String userId}) async {
    return await postRequest(
        path: "/bookings/book",
        body: jsonEncode({"slot_Id": slotId, "user_id": userId}));
  }
}
