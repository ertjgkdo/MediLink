import '../../../utils/exporter.dart';

class DepartmentRepository extends Repository<Department> {
  DepartmentRepository({super.localClient});

  @override
  Department fromJson(Map<String, dynamic> map) => Department.fromJson(map);

  @override
  Department fromRawJson(String json) => Department.fromRawJson(json);

  Future<List<Department>> getDepList() => getAll(path: "/departments");
  Future<Department> getDepbyId({required String id}) =>
      getById(path: "/departments", id: id);
  Future<List<Department>> searchDepartments(
      {String? query, Client? client}) async {
    return await getByQuery(
        path: "search/departments", queries: query, client: client);
  }
}
