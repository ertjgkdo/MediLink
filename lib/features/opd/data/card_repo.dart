import 'package:medilink/utils/exporter.dart';

class CardRepository extends Repository<CardModel> {
  @override
  CardModel fromJson(Map<String, dynamic> map) => CardModel.fromJson(map);

  @override
  CardModel fromRawJson(String json) => CardModel.fromRawJson(json);

  Future<List<CardModel>> getOpdCards({required String id}) async {
    final String? authToken = await SecureStorage.getToken();

    return getListById(path: "/opd/cards/all", id: id, authtoken: authToken);
  }

  Future<CardModel> getOpdDetails(String id) async {
    final String? authToken = await SecureStorage.getToken();
    return getById(path: "/cards", id: id, authToken: authToken);
  }
}
