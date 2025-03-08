import '../../../utils/exporter.dart';

class SchedRepository extends Repository<Schedule> {
  SchedRepository({super.localClient});

  @override
  Schedule fromJson(Map<String, dynamic> map) => Schedule.fromJson(map);

  @override
  Schedule fromRawJson(String json) => Schedule.fromRawJson(json);

  Future<List<Schedule>> getSchedList() => getAll(path: "/schedules");
  Future<Schedule> getSchedbyId({required String id}) =>
      getById(path: "/schedules/$id", id: id);
}
