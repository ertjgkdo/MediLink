import '../../../utils/exporter.dart';

class DoctorRepository extends Repository<Doctor> {
  DoctorRepository({super.localClient});

  @override
  Doctor fromJson(Map<String, dynamic> map) => Doctor.fromJson(map);

  @override
  Doctor fromRawJson(String json) => Doctor.fromRawJson(json);

  Future<List<Doctor>> getDocList() => getAll(path: "/doctors");
  Future<Doctor> getDocbyId({required String id}) =>
      getById(path: "/doctors/$id", id: id);
  Future<List<Doctor>> searchDoctors({String? query, Client? client}) async {
    return await getByQuery(
        path: "search/doctors", queries: query, client: client);
  }
}
