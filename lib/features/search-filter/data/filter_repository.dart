import 'package:medilink/features/search-filter/domain/filter_model.dart';
import 'package:medilink/utils/exporter.dart';

class FilterRepository extends Repository<Hosp> {
  @override
  Hosp fromJson(Map<String, dynamic> map) => Hosp.fromJson(map);

  @override
  Hosp fromRawJson(String json) => Hosp.fromRawJson(json);

  Future<List<Hosp>> getData() async {
    return await getAll(path: "/filter/hospital-summary");
  }
}
