import '../../../utils/exporter.dart';

class SlotRepository extends Repository<Slot> {
  SlotRepository({super.localClient});

  @override
  Slot fromJson(Map<String, dynamic> map) => Slot.fromJson(map);

  @override
  Slot fromRawJson(String json) => Slot.fromRawJson(json);

  Future<List<Slot>> getSlotList() => getAll(path: "/slots");
  Future<Slot> getSlotbyId({required String id}) =>
      getById(path: "/slots/$id", id: id);
  Future<List<Slot>> getSlotbyDocId({required String id}) =>
      getListById(path: "/slots/by-doctor", id: id);
  Future<List<Slot>> getSlot(
      {required String hospital,
      required String department,
      required DateTime date,
      required String doctor,
      required String timeslot}) async {
    final body = {
      'hospitalId': hospital,
      'departmentId': department,
      'date': date.toIso8601String(),
      'doctorId': doctor,
      'time': timeslot,
    };
    return await postList(path: "/filter", body: body);
  }
}
