import '../../../utils/exporter.dart';

class HospitalRepository extends Repository<Hospital> {
  HospitalRepository({super.localClient});

  @override
  Hospital fromJson(Map<String, dynamic> map) => Hospital.fromJson(map);

  @override
  Hospital fromRawJson(String json) => Hospital.fromRawJson(json);

  Future<List<Hospital>> getHospList() => getAll(path: "/hospitals");
  Future<Hospital> getHospitalbyId({required String id}) =>
      getById(path: "/hospitals", id: id);
}
