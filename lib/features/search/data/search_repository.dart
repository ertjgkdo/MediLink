// import '../../../utils/exporter.dart';

// class SearchRepository<T> extends Repository<T> {
//   final T Function(Map<String, dynamic>) fromJsonFunc;
//   final T Function(String) fromRawJsonFunc;
//   SearchRepository(
//       {super.localClient,
//       required this.fromJsonFunc,
//       required this.fromRawJsonFunc});

//   Future<List<T>> search({
//     required String searchEndpoint,
//     required String query,
//   }) async {
//     return await getByQuery(path: "search/$searchEndpoint", queries: query);
//   }

//   @override
//   T fromJson(Map<String, dynamic> map) {
//     return fromJsonFunc(map);
//   }

//   @override
//   T fromRawJson(String json) {
//     return fromRawJsonFunc(json);
//   }
// }
