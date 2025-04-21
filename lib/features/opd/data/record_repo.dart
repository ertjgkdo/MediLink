import 'package:medilink/utils/exporter.dart';

class RecordRepository extends Repository<RecordModel> {
  @override
  RecordModel fromJson(Map<String, dynamic> map) => RecordModel.fromJson(map);

  @override
  RecordModel fromRawJson(String json) => RecordModel.fromRawJson(json);

  Future<List<RecordModel>> getAllRecords({required String id}) async {
    final String? authToken = await SecureStorage.getToken();
    print(authToken);
    return getListById(path: "/opd/records/all", id: id, authtoken: authToken);
  }

  Future<RecordModel> getRecordDetails(String id) async {
    final String? authToken = await SecureStorage.getToken();
    return getById(path: "/opd/records", id: id, authToken: authToken);
  }
}
