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
}
